# Guide d'Implémentation Socket.IO - Synchronisation Temps Réel

## 📋 Table des Matières
1. [Vue d'ensemble](#vue-densemble)
2. [Prérequis et Installation](#prérequis-et-installation)
3. [Configuration Backend (Laravel)](#configuration-backend-laravel)
4. [Configuration Mobile (Flutter)](#configuration-mobile-flutter)
5. [Étendre à d'autres pages](#étendre-à-dautres-pages)
6. [Déploiement en Production](#déploiement-en-production)
7. [Dépannage](#dépannage)

---

## 🎯 Vue d'ensemble

### Problème Résolu
L'application mobile nécessitait un **pull-to-refresh manuel** pour récupérer les données mises à jour depuis le backoffice. Cela créait une mauvaise expérience utilisateur et un décalage entre les données affichées.

### Solution Implémentée
**Synchronisation temps réel avec Socket.IO** : Lorsqu'une donnée change dans le backoffice, un événement est immédiatement envoyé au mobile qui se met à jour automatiquement.

### Architecture
```
┌─────────────────┐         ┌──────────────┐         ┌─────────────────┐
│   Backoffice    │         │    Redis     │         │  Laravel Echo   │
│    (Laravel)    │────────▶│  (Pub/Sub)   │────────▶│     Server      │
└─────────────────┘         └──────────────┘         │  (Port 6001)    │
                                                      └────────┬────────┘
                                                               │
                                                               │ WebSocket
                                                               ▼
                                                      ┌─────────────────┐
                                                      │   Mobile App    │
                                                      │   (Flutter)     │
                                                      └─────────────────┘
```

### Flux de Données
1. **Action utilisateur** → Backoffice modifie une donnée (ex: toggle visibilité tâche)
2. **Broadcasting** → Laravel déclenche `event(new PlanificationUpdated())`
3. **Redis Pub/Sub** → Redis propage l'événement
4. **Laravel Echo Server** → Reçoit l'événement et le diffuse via WebSocket
5. **Mobile** → SocketService reçoit l'événement et déclenche le rechargement
6. **UI Refresh** → Les données sont mises à jour automatiquement

---

## 🔧 Prérequis et Installation

### 1. Installation Redis (Base de Données In-Memory)

**Sur macOS avec Homebrew :**
```bash
# Installation
brew install redis

# Démarrer Redis en tant que service (démarre automatiquement au boot)
brew services start redis

# Vérifier que Redis fonctionne
redis-cli ping
# Réponse attendue : PONG
```

**Sur Linux (Ubuntu/Debian) :**
```bash
sudo apt update
sudo apt install redis-server
sudo systemctl start redis-server
sudo systemctl enable redis-server
```

**Sur Windows :**
- Télécharger depuis : https://github.com/microsoftarchive/redis/releases
- Ou utiliser WSL2 avec la méthode Linux

### 2. Installation Node.js et npm

**Sur macOS avec Homebrew :**
```bash
brew install node
node --version  # v25.2.1 ou supérieur
npm --version   # v10.x ou supérieur
```

**Sur Linux :**
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### 3. Installation Laravel Echo Server

```bash
# Installation globale
npm install -g laravel-echo-server

# Vérifier l'installation
laravel-echo-server --version  # 1.6.3
```

---

## ⚙️ Configuration Backend (Laravel)

### Étape 1 : Configuration de l'Environnement

**Fichier : `.env`**
```env
# Changer le driver de broadcasting de 'log' à 'redis'
BROADCAST_DRIVER=redis

# Configuration Redis (par défaut)
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379
```

### Étape 2 : Création de l'Événement Broadcastable

**Fichier : `app/Events/PlanificationUpdated.php`**

```php
<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

/**
 * Événement déclenché lorsqu'une planification est mise à jour
 * Implémente ShouldBroadcast pour être diffusé automatiquement
 */
class PlanificationUpdated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $personnelId;
    public $message;
    public $timestamp;

    /**
     * @param int|null $personnelId - ID du personnel concerné (null = broadcast global)
     * @param string $message - Message descriptif de la modification
     */
    public function __construct($personnelId = null, $message = 'Planification mise à jour')
    {
        $this->personnelId = $personnelId;
        $this->message = $message;
        $this->timestamp = now()->format('Y-m-d H:i:s');
    }

    /**
     * Définit sur quel(s) canal/canaux broadcaster l'événement
     * - planification.all : Tous les utilisateurs reçoivent
     * - planification.{id} : Seul l'utilisateur concerné reçoit
     */
    public function broadcastOn()
    {
        // Option 1: Canal global (tous les utilisateurs)
        return new Channel('planification.all');
        
        // Option 2: Canal spécifique à un utilisateur
        // if ($this->personnelId) {
        //     return new Channel('planification.' . $this->personnelId);
        // }
        // return new Channel('planification.all');
    }

    /**
     * Nom personnalisé de l'événement (optionnel)
     * Par défaut Laravel utilise le nom de la classe
     */
    public function broadcastAs()
    {
        return 'planification.updated';
    }

    /**
     * Données envoyées avec l'événement
     * Ces données seront accessibles côté client
     */
    public function broadcastWith()
    {
        return [
            'personnel_id' => $this->personnelId,
            'message' => $this->message,
            'timestamp' => $this->timestamp,
        ];
    }
}
```

### Étape 3 : Déclencher l'Événement dans le Contrôleur

**Fichier : `app/Http/Controllers/PlanificationController.php`**

```php
<?php

namespace App\Http\Controllers;

use App\Events\PlanificationUpdated; // ← Importer l'événement

class PlanificationController extends Controller
{
    public function toggleVisibleTache(Request $request)
    {
        // ... Logique existante de toggle ...
        
        $tache = ProjetTache::findOrFail($request->tache_id);
        $tache->visible_frontend = !$tache->visible_frontend;
        $tache->save();

        // ✨ NOUVEAU : Récupérer l'ID du personnel concerné
        $personnelId = null;
        if ($tache->fonctionnalite && $tache->fonctionnalite->projet_planification) {
            $planification = $tache->fonctionnalite->projet_planification;
            if ($planification->planificationAssigne) {
                $personnelId = $planification->planificationAssigne->personnel_id;
            }
        }

        $message = $tache->visible_frontend 
            ? 'Cette tâche est maintenant visible dans le frontend mobile'
            : 'Cette tâche est maintenant masquée dans le frontend mobile';

        // ✨ NOUVEAU : Broadcaster l'événement
        event(new PlanificationUpdated($personnelId, $message));

        return response()->json([
            'success' => true,
            'message' => $message,
            'visible_frontend' => $tache->visible_frontend
        ]);
    }
}
```

### Étape 4 : Configuration Laravel Echo Server

**Fichier : `laravel-echo-server.json`** (à la racine du projet Laravel)

```json
{
  "authHost": "http://localhost",
  "authEndpoint": "/broadcasting/auth",
  "clients": [],
  "database": "redis",
  "databaseConfig": {
    "redis": {
      "host": "127.0.0.1",
      "port": "6379"
    }
  },
  "devMode": true,
  "host": null,
  "port": "6001",
  "protocol": "http",
  "socketio": {},
  "secureOptions": 67108864,
  "sslCertPath": "",
  "sslKeyPath": "",
  "sslCertChainPath": "",
  "sslPassphrase": "",
  "subscribers": {
    "http": true,
    "redis": true
  },
  "apiOriginAllow": {
    "allowCors": true,
    "allowOrigin": "*",
    "allowMethods": "GET, POST",
    "allowHeaders": "Origin, Content-Type, X-Auth-Token, X-Requested-With, Accept, Authorization, X-CSRF-TOKEN, X-Socket-Id"
  }
}
```

### Étape 5 : Démarrage du Serveur

```bash
cd /Applications/XAMPP/xamppfiles/htdocs/guindy_manager

# Démarrer Laravel Echo Server
laravel-echo-server start

# Vous devriez voir :
# L A R A V E L  E C H O  S E R V E R
# version 1.6.3
# 
# ⚠ Starting server in DEV mode...
# ✔  Running at localhost on port 6001
# ✔  Channels are ready.
# ✔  Listening for http events...
# ✔  Listening for redis events...
```

---

## 📱 Configuration Mobile (Flutter)

### Étape 1 : Ajouter la Dépendance

**Fichier : `pubspec.yaml`**

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Autres dépendances...
  
  # Socket.IO Client
  socket_io_client: ^1.0.2  # ⚠️ Version 1.x pour compatibilité avec laravel-echo-server
```

**Installation :**
```bash
cd /Users/macbookpro/pointage_mobile
flutter pub get
```

> **⚠️ Important :** La version 2.x de socket_io_client n'est pas compatible avec laravel-echo-server 1.6.3. Utilisez impérativement la version 1.0.2.

### Étape 2 : Créer le Service Socket

**Fichier : `lib/services/socket_service.dart`**

```dart
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

/// Service singleton pour gérer la connexion Socket.IO
/// Pattern Singleton : Une seule instance partagée dans toute l'application
class SocketService {
  // Instance unique (Singleton)
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  // Socket.IO client
  IO.Socket? _socket;
  
  // URL du serveur Socket.IO
  String _serverUrl = 'http://localhost:6001'; // ⚠️ localhost = simulateur uniquement
  
  // Callbacks pour les événements reçus
  final Map<String, Function(dynamic)> _eventCallbacks = {};

  /// Vérifie si le socket est connecté
  bool get isConnected => _socket?.connected ?? false;

  /// Connexion au serveur Socket.IO
  /// 
  /// @param personnelId - ID du personnel pour l'abonnement au canal personnel
  void connect({int? personnelId}) {
    if (_socket?.connected ?? false) {
      debugPrint('🔵 Socket.IO déjà connecté');
      return;
    }

    debugPrint('🔌 Initialisation Socket.IO avec personnel_id: $personnelId');
    debugPrint('🔵 Connexion à Socket.IO: $_serverUrl');

    // Configuration de la connexion
    _socket = IO.io(_serverUrl, <String, dynamic>{
      'transports': ['websocket'], // ⚠️ WebSocket uniquement (pas de polling)
      'autoConnect': true,
      'reconnection': true,
      'reconnectionDelay': 1000,
      'reconnectionAttempts': 5,
    });

    // Event: Connexion réussie
    _socket!.onConnect((_) {
      debugPrint('✅ Socket.IO connecté avec succès');
      
      // S'abonner aux canaux
      _subscribeToChannels(personnelId);
      
      // Écouter les événements avec le format Laravel Echo Server
      _listenToEvents();
    });

    // Event: Erreur de connexion
    _socket!.onConnectError((error) {
      debugPrint('❌ Erreur connexion Socket.IO: $error');
    });

    // Event: Déconnexion
    _socket!.onDisconnect((_) {
      debugPrint('🔴 Socket.IO déconnecté');
    });

    // Event: Erreur générale
    _socket!.onError((error) {
      debugPrint('❌ Erreur Socket.IO: $error');
    });
  }

  /// S'abonner aux canaux de broadcasting
  void _subscribeToChannels(int? personnelId) {
    if (_socket == null || !_socket!.connected) return;

    // S'abonner au canal global
    _socket!.emit('subscribe', {
      'channel': 'planification.all',
      'auth': {}, // Pas d'authentification pour les canaux publics
    });
    debugPrint('📡 Abonné au canal: planification.all');

    // S'abonner au canal personnel si personnelId fourni
    if (personnelId != null) {
      _socket!.emit('subscribe', {
        'channel': 'planification.$personnelId',
        'auth': {},
      });
      debugPrint('📡 Abonné au canal: planification.$personnelId');
    }
  }

  /// Écouter les événements avec le format Laravel Echo Server
  /// Format: 'channel:event' (ex: 'planification.all:planification.updated')
  void _listenToEvents() {
    if (_socket == null) return;

    // ⚠️ Format Laravel Echo Server : 'channel:event'
    _socket!.on('planification.all:planification.updated', (data) {
      debugPrint('📨 Événement reçu: planification.updated');
      debugPrint('📦 Données: $data');
      
      // Propager l'événement aux listeners enregistrés
      if (_eventCallbacks.containsKey('planification.updated')) {
        _eventCallbacks['planification.updated']!(data);
      }
    });
  }

  /// Enregistrer un callback pour un événement
  /// 
  /// @param event - Nom de l'événement (ex: 'planification.updated')
  /// @param callback - Fonction à exécuter lors de la réception
  void on(String event, Function(dynamic) callback) {
    _eventCallbacks[event] = callback;
    debugPrint('🎧 Listener enregistré pour: $event');
  }

  /// Supprimer un callback
  void off(String event) {
    _eventCallbacks.remove(event);
    debugPrint('🔇 Listener supprimé pour: $event');
  }

  /// Déconnexion
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
      _eventCallbacks.clear();
      debugPrint('🔌 Socket.IO déconnecté et nettoyé');
    }
  }

  /// Reconnexion manuelle
  void reconnect({int? personnelId}) {
    disconnect();
    connect(personnelId: personnelId);
  }
}
```

### Étape 3 : Intégrer dans une Page Flutter

**Fichier : `lib/screens/Planning/Planning.dart`**

```dart
import 'package:flutter/material.dart';
import '../../services/socket_service.dart'; // ← Importer le service

class PlanningPage extends StatefulWidget {
  final int id; // user_id
  final String nom;
  final String email;

  const PlanningPage({
    Key? key,
    required this.id,
    required this.nom,
    required this.email,
  }) : super(key: key);

  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  // Instance du SocketService
  final SocketService _socketService = SocketService();
  
  // Données
  List<Planification> planifications = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Charger les données au démarrage
    _chargerPlanifications();
    
    // ⚠️ Ne PAS connecter le socket ici si vous n'avez pas encore le personnel_id
  }

  /// Charger les planifications depuis l'API
  Future<void> _chargerPlanifications() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Appel API pour récupérer les planifications
      final response = await http.get(
        Uri.parse('$baseUrl/planifications-mobile?personnel_email=${widget.email}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        setState(() {
          planifications = (data['data'] as List)
              .map((json) => Planification.fromJson(json))
              .toList();
          _isLoading = false;
        });

        // ✨ NOUVEAU : Initialiser Socket.IO après avoir les données
        if (planifications.isNotEmpty && !_socketService.isConnected) {
          // Récupérer le personnel_id depuis les données
          final personnelId = planifications.first.personnelId;
          
          // Connecter au socket
          _socketService.connect(personnelId: personnelId);
          
          // ✨ NOUVEAU : Enregistrer le listener pour les événements
          _socketService.on('planification.updated', (data) {
            debugPrint('🔄 Rechargement automatique des planifications');
            
            // Recharger les données seulement si le widget est monté et pas déjà en chargement
            if (mounted && !_isLoading) {
              _chargerPlanifications();
            }
          });
        }
      }
    } catch (e) {
      debugPrint('❌ Erreur chargement planifications: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    // ✨ NOUVEAU : Se déconnecter lors de la destruction du widget
    _socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planifications')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _chargerPlanifications,
              child: ListView.builder(
                itemCount: planifications.length,
                itemBuilder: (context, index) {
                  return PlanificationCard(
                    planification: planifications[index],
                  );
                },
              ),
            ),
    );
  }
}
```

---

## 🔄 Étendre à d'autres pages

Pour ajouter la synchronisation temps réel à d'autres pages (Dashboard, Statistiques, etc.), suivez ces étapes :

### 1. Backend : Créer un nouvel événement

```php
// Exemple pour les KPI du Dashboard
// app/Events/KpiUpdated.php

<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class KpiUpdated implements ShouldBroadcast
{
    public $personnelId;
    public $kpiType; // 'semaine', 'mois', 'annee'
    public $data;

    public function __construct($personnelId, $kpiType, $data)
    {
        $this->personnelId = $personnelId;
        $this->kpiType = $kpiType;
        $this->data = $data;
    }

    public function broadcastOn()
    {
        return new Channel('kpi.' . $this->personnelId);
    }

    public function broadcastAs()
    {
        return 'kpi.updated';
    }

    public function broadcastWith()
    {
        return [
            'personnel_id' => $this->personnelId,
            'kpi_type' => $this->kpiType,
            'data' => $this->data,
            'timestamp' => now()->format('Y-m-d H:i:s'),
        ];
    }
}
```

### 2. Backend : Déclencher l'événement

```php
// Dans le contrôleur approprié
use App\Events\KpiUpdated;

public function updateKpi(Request $request)
{
    // ... logique métier ...
    
    event(new KpiUpdated($personnelId, 'semaine', $kpiData));
    
    // ...
}
```

### 3. Mobile : Modifier SocketService pour écouter le nouvel événement

```dart
// Dans lib/services/socket_service.dart

void _listenToEvents() {
  if (_socket == null) return;

  // Événements planifications (existant)
  _socket!.on('planification.all:planification.updated', (data) {
    debugPrint('📨 Événement reçu: planification.updated');
    if (_eventCallbacks.containsKey('planification.updated')) {
      _eventCallbacks['planification.updated']!(data);
    }
  });

  // ✨ NOUVEAU : Événements KPI
  _socket!.on('kpi.\${personnelId}:kpi.updated', (data) {
    debugPrint('📨 Événement reçu: kpi.updated');
    if (_eventCallbacks.containsKey('kpi.updated')) {
      _eventCallbacks['kpi.updated']!(data);
    }
  });
}

// Ajouter une méthode pour s'abonner au canal KPI
void subscribeToKpi(int personnelId) {
  if (_socket == null || !_socket!.connected) return;
  
  _socket!.emit('subscribe', {
    'channel': 'kpi.$personnelId',
    'auth': {},
  });
  debugPrint('📡 Abonné au canal: kpi.$personnelId');
}
```

### 4. Mobile : Utiliser dans la page Dashboard

```dart
// Dans lib/screens/Dashboard/Dashboard.dart

@override
void initState() {
  super.initState();
  _chargerKpi();
}

Future<void> _chargerKpi() async {
  // ... chargement des données ...
  
  // Connecter et écouter les événements KPI
  if (!_socketService.isConnected) {
    _socketService.connect(personnelId: personnelId);
    _socketService.subscribeToKpi(personnelId);
    
    _socketService.on('kpi.updated', (data) {
      debugPrint('🔄 Rechargement automatique des KPI');
      if (mounted && !_isLoading) {
        _chargerKpi();
      }
    });
  }
}
```

---

## 🚀 Déploiement en Production

### 1. Configuration pour Appareils Physiques

**⚠️ Problème :** `localhost:6001` ne fonctionne que sur le simulateur.

**Solution 1 : Utiliser l'adresse IP locale**
```dart
// lib/services/socket_service.dart
String _serverUrl = 'http://192.168.1.100:6001'; // Remplacer par votre IP
```

**Solution 2 : Utiliser un domaine avec ngrok (développement)**
```bash
# Installer ngrok
brew install ngrok

# Exposer laravel-echo-server
ngrok http 6001

# Utiliser l'URL ngrok dans le mobile
String _serverUrl = 'https://abc123.ngrok.io';
```

**Solution 3 : Déployer sur un serveur (production)**
```dart
String _serverUrl = 'https://socket.votre-domaine.com';
```

### 2. Sécuriser avec SSL/TLS (WSS)

**Configuration Laravel Echo Server :**
```json
{
  "protocol": "https",
  "sslCertPath": "/chemin/vers/cert.pem",
  "sslKeyPath": "/chemin/vers/key.pem"
}
```

**Mobile :**
```dart
String _serverUrl = 'https://socket.votre-domaine.com'; // wss:// automatique
```

### 3. Lancer Laravel Echo Server en tant que Service

**Avec PM2 (recommandé) :**
```bash
# Installer PM2
npm install -g pm2

# Démarrer laravel-echo-server avec PM2
cd /chemin/vers/guindy_manager
pm2 start laravel-echo-server --name "echo-server" -- start

# Sauvegarder la configuration
pm2 save

# Démarrage automatique au boot
pm2 startup
```

**Avec Supervisor (Linux) :**
```ini
; /etc/supervisor/conf.d/laravel-echo-server.conf
[program:laravel-echo-server]
directory=/var/www/guindy_manager
command=laravel-echo-server start
autostart=true
autorestart=true
user=www-data
redirect_stderr=true
stdout_logfile=/var/log/laravel-echo-server.log
```

### 4. Configuration Nginx (Reverse Proxy)

```nginx
server {
    listen 443 ssl;
    server_name socket.votre-domaine.com;

    ssl_certificate /etc/letsencrypt/live/socket.votre-domaine.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/socket.votre-domaine.com/privkey.pem;

    location / {
        proxy_pass http://localhost:6001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

## 🐛 Dépannage

### Problème 1 : "Socket.IO version incompatible"

**Symptôme :** Console navigateur montre `client is using unsupported version of the protocol`

**Solution :**
```bash
# Vérifier la version de socket_io_client
flutter pub deps | grep socket_io_client

# Doit être 1.0.2, sinon :
# Dans pubspec.yaml
socket_io_client: ^1.0.2

flutter pub get
```

### Problème 2 : "Événements non reçus par le mobile"

**Vérifications :**

1. **Laravel Echo Server fonctionne ?**
```bash
cd /Applications/XAMPP/xamppfiles/htdocs/guindy_manager
laravel-echo-server start
# Doit afficher : "Listening for redis events..."
```

2. **Redis fonctionne ?**
```bash
redis-cli ping
# Doit retourner : PONG
```

3. **Format d'événement correct ?**
```dart
// ❌ FAUX
_socket!.on('planification.updated', ...)

// ✅ CORRECT (format Laravel Echo Server)
_socket!.on('planification.all:planification.updated', ...)
```

4. **Abonnement au canal ?**
```dart
// Vérifier les logs Flutter
// Doit afficher : "📡 Abonné au canal: planification.all"
```

### Problème 3 : "Personnel_id = 0 ou null"

**Symptôme :** Le socket se connecte mais avec `planification.0`

**Solution :**
```dart
// ❌ FAUX : Utiliser widget.id (user_id)
final personnelId = widget.id;

// ✅ CORRECT : Récupérer depuis les données de planification
if (planifications.isNotEmpty) {
  final personnelId = planifications.first.personnelId;
  _socketService.connect(personnelId: personnelId);
}
```

### Problème 4 : "Connexion fonctionne sur simulateur mais pas sur téléphone"

**Cause :** `localhost` n'est accessible que depuis la même machine.

**Solution :**
```dart
// Option 1 : Utiliser l'IP locale
String _serverUrl = 'http://192.168.1.100:6001';

// Option 2 : Utiliser ngrok pour le développement
String _serverUrl = 'https://abc123.ngrok.io';

// Option 3 : Déployer sur un serveur avec domaine
String _serverUrl = 'https://socket.mondomaine.com';
```

### Problème 5 : "Redis connection refused"

**Solution :**
```bash
# Vérifier si Redis tourne
ps aux | grep redis

# Si non, démarrer Redis
brew services start redis  # macOS
sudo systemctl start redis # Linux

# Tester la connexion
redis-cli ping
```

### Problème 6 : "Multiple reloads déclenchés"

**Symptôme :** La page se recharge plusieurs fois pour un seul événement.

**Solution :**
```dart
// Ajouter une vérification _isLoading
_socketService.on('planification.updated', (data) {
  if (mounted && !_isLoading) {  // ← Vérifier !_isLoading
    _chargerPlanifications();
  }
});
```

---

## 📊 Logs et Monitoring

### Logs Laravel Echo Server

```bash
# Voir les logs en temps réel
cd /Applications/XAMPP/xamppfiles/htdocs/guindy_manager
laravel-echo-server start

# Vous verrez :
# Channel: planification.all
# Event: planification.updated
```

### Logs Flutter (Debug)

```dart
// Les logs SocketService affichent :
// 🔌 Initialisation Socket.IO avec personnel_id: 12
// 🔵 Connexion à Socket.IO: http://localhost:6001
// ✅ Socket.IO connecté avec succès
// 📡 Abonné au canal: planification.all
// 📨 Événement reçu: planification.updated
// 🔄 Rechargement automatique des planifications
```

### Monitoring Redis

```bash
# Voir les commandes Redis en temps réel
redis-cli monitor

# Vérifier les canaux Pub/Sub actifs
redis-cli PUBSUB CHANNELS

# Statistiques Redis
redis-cli INFO
```

---

## 📝 Checklist de Vérification

### Backend
- [ ] Redis installé et démarré (`brew services start redis`)
- [ ] Node.js et npm installés (`node --version`)
- [ ] laravel-echo-server installé (`npm install -g laravel-echo-server`)
- [ ] `.env` : `BROADCAST_DRIVER=redis`
- [ ] Événement créé dans `app/Events/` avec `ShouldBroadcast`
- [ ] Événement déclenché dans le contrôleur avec `event(new ...)`
- [ ] `laravel-echo-server.json` configuré
- [ ] Laravel Echo Server démarré (`laravel-echo-server start`)

### Mobile
- [ ] `socket_io_client: ^1.0.2` dans `pubspec.yaml`
- [ ] `flutter pub get` exécuté
- [ ] `lib/services/socket_service.dart` créé
- [ ] Format d'écoute correct : `channel:event`
- [ ] Connexion après chargement des données (pour avoir personnel_id)
- [ ] Listener enregistré avec `_socketService.on('event', callback)`
- [ ] Déconnexion dans `dispose()`

### Tests
- [ ] Redis répond à `redis-cli ping`
- [ ] Laravel Echo Server affiche "Listening for redis events..."
- [ ] Mobile affiche "✅ Socket.IO connecté avec succès"
- [ ] Mobile affiche "📡 Abonné au canal: ..."
- [ ] Action dans backoffice → événement reçu par mobile
- [ ] Logs montrent "📨 Événement reçu" et "🔄 Rechargement automatique"

---

## 🎓 Concepts Clés à Retenir

### 1. **Broadcasting Laravel**
- Laravel peut "broadcaster" des événements via différents drivers (redis, pusher, log)
- `ShouldBroadcast` indique à Laravel de broadcaster automatiquement
- Les événements sont publiés sur des "canaux" (channels)

### 2. **Pub/Sub avec Redis**
- Redis agit comme un "message broker" (courtier de messages)
- Laravel publie → Redis propage → Laravel Echo Server reçoit
- Pattern Publish/Subscribe très performant pour temps réel

### 3. **WebSocket vs HTTP**
- HTTP : Client demande → Serveur répond (pull)
- WebSocket : Connexion persistante bidirectionnelle (push)
- Socket.IO : Bibliothèque qui simplifie l'utilisation des WebSockets

### 4. **Laravel Echo Server**
- Pont entre Laravel/Redis et les clients WebSocket
- Format spécifique : `channel:event`
- Gère les abonnements et la distribution des événements

### 5. **Singleton Pattern**
- Une seule instance de SocketService dans toute l'application
- Évite les multiples connexions
- Partage la connexion entre plusieurs widgets

### 6. **Lifecycle Flutter**
- `initState()` : Initialisation
- `dispose()` : Nettoyage (fermer les connexions)
- `mounted` : Vérifier que le widget existe encore avant `setState()`

---

## 📚 Ressources Utiles

- **Laravel Broadcasting:** https://laravel.com/docs/11.x/broadcasting
- **Laravel Echo Server:** https://github.com/tlaverdure/laravel-echo-server
- **Socket.IO Client Dart:** https://pub.dev/packages/socket_io_client
- **Redis Documentation:** https://redis.io/documentation
- **Flutter State Management:** https://flutter.dev/docs/development/data-and-backend/state-mgmt

---

## 🎉 Conclusion

Vous avez maintenant une **synchronisation temps réel complète** entre votre backoffice Laravel et votre application mobile Flutter !

**Avantages :**
- ✅ Expérience utilisateur fluide (pas de refresh manuel)
- ✅ Données toujours à jour
- ✅ Architecture scalable (peut supporter des milliers de connexions)
- ✅ Faible latence (< 100ms en général)

**Prochaines étapes suggérées :**
1. Étendre à d'autres pages (Dashboard, Statistiques, Pointages)
2. Ajouter des canaux privés avec authentification
3. Implémenter des notifications push couplées aux événements
4. Déployer en production avec SSL/TLS

---

**Document créé le :** 9 janvier 2026  
**Version :** 1.0  
**Auteur :** GitHub Copilot  
**Projet :** Pointage Mobile - Guindy Manager

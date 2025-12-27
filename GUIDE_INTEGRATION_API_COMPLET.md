# 📘 Guide Complet d'Intégration de l'API Backend
## Application Mobile de Pointage

> **Version :** 1.0  
> **Date :** 13 Décembre 2025  
> **Auteur :** Guide d'intégration pour l'équipe de développement

---

# 📋 Table des Matières

1. [Introduction](#introduction)
2. [Prérequis et Architecture Actuelle](#prérequis)
3. [Informations à Obtenir du Backend](#informations-backend)
4. [Configuration de l'Application](#configuration)
5. [Structure des Modèles de Données](#modèles)
6. [Service API - TacheService](#service-api)
7. [Intégration dans les Pages](#intégration-pages)
8. [Gestion des Erreurs](#gestion-erreurs)
9. [Tests et Validation](#tests)
10. [Résolution des Problèmes](#troubleshooting)
11. [Checklist de Déploiement](#checklist)

---

<div style="page-break-after: always;"></div>

# 1. Introduction {#introduction}

## 🎯 Objectif

Ce document vous guide pas à pas pour intégrer l'API backend de votre application de pointage mobile. Une fois que le backend est terminé, vous pourrez consommer l'API en suivant ce guide.

## 📦 Ce Qui Est Déjà Fait

Votre application Flutter possède déjà :

- ✅ **Architecture BLoC** : Pattern de gestion d'état robuste
- ✅ **Système d'authentification** : Login/Logout avec token Bearer
- ✅ **Fonctions API génériques** : `getApiData()`, `postApiData()`, `delApiData()`
- ✅ **Headers automatiques** : Le token est ajouté automatiquement aux requêtes
- ✅ **Modèles de données** : `Tache`, `Statistique`, `Utilisateur`
- ✅ **UI complète** : Dashboard, Planning, Détails des tâches avec Bottom Sheet

## 🚀 Ce Qu'il Reste à Faire

- 🔧 Obtenir les informations de l'API backend
- 🔧 Configurer l'URL de base
- 🔧 Adapter les modèles si nécessaire
- 🔧 Connecter les pages aux vraies données
- 🔧 Tester et valider

---

<div style="page-break-after: always;"></div>

# 2. Prérequis et Architecture Actuelle {#prérequis}

## 📁 Structure des Fichiers Importants

```
pointage_mobile/
├── lib/
│   ├── constant.dart                          ← URL de l'API ici !
│   ├── main.dart
│   ├── core/
│   │   ├── global.dart                        ← Headers avec token
│   │   ├── models/
│   │   │   └── user_model.dart
│   │   └── utils/
│   │       └── helpers.dart
│   ├── services/
│   │   ├── api/
│   │   │   ├── actions/
│   │   │   │   ├── getData.dart              ← GET requests
│   │   │   │   ├── postData.dart             ← POST requests
│   │   │   │   └── delData.dart              ← DELETE requests
│   │   │   └── models/
│   │   │       ├── tache_model.dart          ← Modèle Tâche
│   │   │       └── statistique_model.dart    ← Modèle Stats
│   │   ├── authentication_bloc/
│   │   ├── data_bloc/
│   │   └── post_api_bloc.dart
│   └── screens/
│       ├── Home/
│       │   └── dashboard_page.dart           ← À connecter
│       └── Planning/
│           ├── Planning.dart                  ← À connecter
│           └── tache_detail_page.dart
└── packages/
    └── authentication_repository/
```

## 🔐 Flux d'Authentification Actuel

```
1. Login → authentication_repository
2. Token sauvegardé → SharedPreferences
3. Token ajouté → Headers automatiquement
4. Toutes les requêtes → Incluent "Authorization: Bearer {token}"
```

## 🎨 UI Actuelle

- **Dashboard** : Statistiques du mois (92%, 132h/160h, 27 tâches)
- **Planning** : Liste des tâches par projet avec Bottom Sheet
- **Détails Tâche** : Modal avec sous-tâches et chronomètre

---

<div style="page-break-after: always;"></div>

# 3. Informations à Obtenir du Backend {#informations-backend}

## ❓ Questions Essentielles à Poser

### 🌐 Configuration de Base

**Q1 : Quelle est l'URL de base de l'API ?**
```
Production : https://__________.com/api/
Développement : http://192.168.__.___:____/api/
```

**Q2 : Le token est-il géré comme Bearer Token ?**
```
Format attendu : Authorization: Bearer {token}
Réponse : Oui / Non / Autre → _______________
```

---

### 📝 Endpoints - Tâches

**Q3 : Récupérer toutes les tâches**
```
Endpoint : GET /taches
Paramètres : ?page=1&status=en_cours&projet_id=1
```

**Exemple de réponse JSON attendue :**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "titre": "Dashboard principal",
      "description": "Créer le dashboard",
      "date": "2025-12-13",
      "date_fr": "13 décembre 2025",
      "status": "en_cours",
      "projet_nom": "Application Mobile",
      "lien_test": "https://test.com",
      "lien_prod": "https://prod.com",
      "nombre_collaborateurs": 3,
      "created_at": "2025-12-01T10:00:00Z"
    }
  ],
  "errors": null
}
```

**Q4 : Récupérer les tâches du jour**
```
Endpoint : GET /taches/jour?date=2025-12-13
```

**Q5 : Démarrer une tâche (chronomètre)**
```
Endpoint : POST /taches/{id}/demarrer
Body : {}
Réponse : { "success": true, "data": { ... } }
```

**Q6 : Terminer une tâche**
```
Endpoint : POST /taches/{id}/terminer
Body : { "duree": "02:30:00" }
Réponse : { "success": true, "data": { ... } }
```

---

### 📊 Endpoints - Statistiques

**Q7 : Récupérer les statistiques du mois**
```
Endpoint : GET /dashboard/statistiques
```

**Exemple de réponse JSON :**
```json
{
  "success": true,
  "data": {
    "pourcentage_jour": 92,
    "jours_travailles": 18,
    "jours_restants": 6,
    "heures_pointees": 132,
    "objectif_mensuel": 160,
    "moyenne_jour": 7.15,
    "total_taches": 27
  }
}
```

---

### 🔑 Compte de Test

**Q8 : Credentials de test**
```
Email : ___________________________
Password : ________________________
```

---

<div style="page-break-after: always;"></div>

# 4. Configuration de l'Application {#configuration}

## 🔧 Étape 1 : Modifier l'URL de Base

**Fichier :** `lib/constant.dart` (ligne 12)

```dart
// ❌ AVANT (ancienne API)
const BASE_URL = 'https://yogi-vida.com/yogivida_back/';

// ✅ APRÈS (votre API)
const BASE_URL = 'https://votre-api.com/api/';
```

### Exemple Complet :

```dart
import 'package:flutter/material.dart';

// 🔧 CONFIGURATION API - À MODIFIER ICI !
const BASE_URL = 'https://api.pointage.com/';  // ← Remplacez par votre URL
// const BASE_URL = 'http://192.168.1.100:8000/api/'; // Pour test local

// Endpoints (normalement déjà corrects)
const REGISTRATION_ENDPOINT = "inscription";
const LOGIN_ENDPOINT = "connexion";
const LOGOUT_ENDPOINT = "deconnexion";

// Couleurs de l'app (ne pas modifier)
const Color primaryColor = Color(0xff15274D);
const Color secondColor = Color(0xffA8923B);
// ...
```

## 🔧 Étape 2 : Vérifier le Format du Token

**Fichier :** `lib/core/global.dart`

Ce fichier gère automatiquement les headers. Vérifiez que ça correspond :

```dart
Future<Map<String, String>> getHeaders() async {
  Map<String, String> headers = {};
  headers.addAll({
    "Accept": "application/json", 
    "Content-Type": "application/json"
  });
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  
  if (token != null) {
    headers.addAll({"Authorization": "Bearer $token"}); // ← Vérifiez ce format
  }
  
  return headers;
}
```

**Si votre API utilise un autre format** (ex: `X-Auth-Token`), modifiez ici.

---

<div style="page-break-after: always;"></div>

# 5. Structure des Modèles de Données {#modèles}

## 📦 Modèle Tâche (Tache)

**Fichier :** `lib/services/api/models/tache_model.dart`

### Structure Actuelle :

```dart
class Tache {
  final int? id;
  final String? titre;
  final String? description;
  final String? date;
  final String? dateFr;
  final String? status;
  final String? lienTest;
  final String? lienProd;
  final int? nombreCollaborateurs;
  final String? createdAt;
  final String? updatedAt;

  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
      id: json['id'] as int?,
      titre: json['titre'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      dateFr: json['date_fr'] as String?,
      status: json['status'] as String?,
      lienTest: json['lien_test'] as String?,
      lienProd: json['lien_prod'] as String?,
      nombreCollaborateurs: json['nombre_collaborateurs'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  static List<Tache> fromJsonList(List<dynamic> json) {
    List<Tache> data = [];
    for (var result in json) {
      data.add(Tache.fromJson(result as Map<String, dynamic>));
    }
    return data;
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "tachespaginated" : "taches";
  }
}
```

### ⚠️ Si le JSON de l'API est Différent

**Exemple :** Si votre API retourne `project_name` au lieu de `nombreCollaborateurs` :

```dart
class Tache {
  final String? projectName; // Ajoutez ce champ
  
  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
      // ...
      projectName: json['project_name'] as String?, // Ajoutez cette ligne
    );
  }
}
```

---

## 📊 Modèle Statistique

**Fichier :** `lib/services/api/models/statistique_model.dart`

```dart
class Statistique {
  final double? pourcentageJour;
  final int? joursTravailles;
  final int? joursRestants;
  final double? heuresPointees;
  final double? objectifMensuel;
  final double? moyenneJour;
  final int? totalTaches;

  factory Statistique.fromJson(Map<String, dynamic> json) {
    return Statistique(
      pourcentageJour: (json['pourcentage_jour'] as num?)?.toDouble(),
      joursTravailles: json['jours_travailles'] as int?,
      joursRestants: json['jours_restants'] as int?,
      heuresPointees: (json['heures_pointees'] as num?)?.toDouble(),
      objectifMensuel: (json['objectif_mensuel'] as num?)?.toDouble(),
      moyenneJour: (json['moyenne_jour'] as num?)?.toDouble(),
      totalTaches: json['total_taches'] as int?,
    );
  }

  static String getEndpoint() {
    return "dashboard/statistiques";
  }
}
```

---

<div style="page-break-after: always;"></div>

# 6. Service API - TacheService {#service-api}

## 🛠️ Créer le Service

**Fichier à créer :** `lib/services/api/tache_service.dart`

```dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pointage_mobile/services/api/actions/getData.dart';
import 'package:pointage_mobile/services/api/actions/postData.dart';
import 'package:pointage_mobile/services/api/models/tache_model.dart';
import 'package:pointage_mobile/services/api/models/statistique_model.dart';

/// Service pour gérer les appels API liés aux tâches
class TacheService {
  
  /// Récupère toutes les tâches
  static Future<List<Tache>> getTaches({String? statut}) async {
    try {
      Map<String, dynamic> parameters = {};
      if (statut != null) parameters['status'] = statut;

      final response = await getApiData('taches', parameters: parameters);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        
        if (responseData['data'] != null) {
          List<dynamic> tachesJson = responseData['data'];
          return Tache.fromJsonList(tachesJson);
        }
      }
      return [];
    } catch (e) {
      if (kDebugMode) print("❌ Erreur getTaches: $e");
      return [];
    }
  }

  /// Récupère les tâches du jour
  static Future<List<Tache>> getTachesDuJour() async {
    try {
      final today = DateTime.now();
      final dateStr = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
      
      final response = await getApiData(
        'taches/jour',
        parameters: {'date': dateStr},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['data'] != null) {
          return Tache.fromJsonList(responseData['data']);
        }
      }
      return [];
    } catch (e) {
      if (kDebugMode) print("❌ Erreur getTachesDuJour: $e");
      return [];
    }
  }

  /// Récupère les statistiques du dashboard
  static Future<Statistique?> getStatistiques() async {
    try {
      final response = await getApiData('dashboard/statistiques');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['data'] != null) {
          return Statistique.fromJson(responseData['data']);
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) print("❌ Erreur getStatistiques: $e");
      return null;
    }
  }

  /// Démarre une tâche (lance le chronomètre)
  static Future<bool> demarrerTache(int tacheId) async {
    try {
      final response = await postApiData('taches/$tacheId/demarrer', {});
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['success'] == true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) print("❌ Erreur demarrerTache: $e");
      return false;
    }
  }

  /// Termine une tâche
  static Future<bool> terminerTache(int tacheId, {String? duree}) async {
    try {
      Map<String, dynamic> body = {};
      if (duree != null) body['duree'] = duree;

      final response = await postApiData('taches/$tacheId/terminer', body);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['success'] == true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) print("❌ Erreur terminerTache: $e");
      return false;
    }
  }
}
```

---

<div style="page-break-after: always;"></div>

# 7. Intégration dans les Pages {#intégration-pages}

## 🎯 Page Planning - Afficher les Tâches

**Fichier :** `lib/screens/Planning/Planning.dart`

### Ajouter les Variables d'État

```dart
class _PlanningState extends State<Planning> {
  // Variables existantes
  int _selectedTab = 0;
  final Set<String> _tachesTerminees = {};
  final Map<String, DateTime> _tachesEnCours = {};
  final Map<String, Duration> _dureesTaches = {};
  
  // ✨ NOUVELLES VARIABLES POUR L'API
  List<Tache> _tachesAPI = [];
  bool _isLoading = true;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    _chargerTachesDuJour(); // ← Appeler ici
  }
  
  // ✨ NOUVELLE MÉTHODE
  Future<void> _chargerTachesDuJour() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      List<Tache> taches = await TacheService.getTachesDuJour();
      setState(() {
        _tachesAPI = taches;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de chargement : $e';
        _isLoading = false;
      });
    }
  }
```

### Modifier _buildTachesDuJour()

```dart
Widget _buildTachesDuJour() {
  // Afficher le loader
  if (_isLoading) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(color: Color(0xFF5EBAAE)),
          SizedBox(height: 16),
          Text('Chargement des tâches...'),
        ],
      ),
    );
  }
  
  // Afficher l'erreur
  if (_errorMessage != null) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(_errorMessage!),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _chargerTachesDuJour,
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }
  
  // Afficher les tâches
  if (_tachesAPI.isEmpty) {
    return const Center(
      child: Text('Aucune tâche pour aujourd\'hui'),
    );
  }
  
  // Grouper les tâches par projet
  Map<String, List<Tache>> tachesParProjet = {};
  for (var tache in _tachesAPI) {
    String projet = tache.projectName ?? 'Projet sans nom';
    if (!tachesParProjet.containsKey(projet)) {
      tachesParProjet[projet] = [];
    }
    tachesParProjet[projet]!.add(tache);
  }
  
  // Afficher les sections de projets
  return Column(
    children: tachesParProjet.entries.map((entry) {
      String nomProjet = entry.key;
      List<Tache> tachesProjet = entry.value;
      
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _buildProjetSection(
          titre: nomProjet,
          taches: tachesProjet.map((tache) => {
            'titre': tache.titre ?? 'Sans titre',
            'duree': tache.dateFr ?? '',
            'tacheId': tache.id,
            'onTap': () => _ouvrirDetailTache(tache),
          }).toList(),
        ),
      );
    }).toList(),
  );
}

// ✨ NOUVELLE MÉTHODE
Future<void> _ouvrirDetailTache(Tache tache) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: TacheDetailPage(
          titre: tache.titre ?? '',
          duree: tache.dateFr ?? '',
          onToutTerminer: (Duration duree) async {
            bool success = await TacheService.terminerTache(
              tache.id!,
              duree: duree.toString(),
            );
            
            if (success) {
              await _chargerTachesDuJour();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Tâche terminée !'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            }
          },
        ),
      ),
    ),
  );
}
```

---

## 📊 Page Dashboard - Afficher les Statistiques

**Fichier :** `lib/screens/Home/dashboard_page.dart`

### Ajouter les Variables

```dart
class _DashboardPageState extends State<DashboardPage> {
  // ✨ NOUVELLES VARIABLES
  Statistique? _statistiques;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _chargerStatistiques(); // ← Appeler ici
  }
  
  // ✨ NOUVELLE MÉTHODE
  Future<void> _chargerStatistiques() async {
    setState(() => _isLoading = true);
    
    try {
      Statistique? stats = await TacheService.getStatistiques();
      setState(() {
        _statistiques = stats;
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) print('Erreur stats : $e');
      setState(() => _isLoading = false);
    }
  }
```

### Modifier _buildStatistiquesCards()

```dart
Widget _buildStatistiquesCards() {
  if (_isLoading) {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF5EBAAE)),
    );
  }
  
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        // Carte Jour - Remplacer les valeurs en dur
        Text(
          '${_statistiques?.pourcentageJour?.toInt() ?? 0}%',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF10B981),
          ),
        ),
        Text(
          '${_statistiques?.joursTravailles ?? 0} / ${_statistiques?.joursRestants ?? 0} jours',
          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
        
        const SizedBox(height: 16),
        
        // Carte Heures
        Text(
          '${_statistiques?.heuresPointees?.toInt() ?? 0}h',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B82F6),
          ),
        ),
        Text(
          'sur ${_statistiques?.objectifMensuel?.toInt() ?? 0}h',
          style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
        
        const SizedBox(height: 16),
        
        // Carte Moyenne
        Text(
          '${_statistiques?.moyenneJour?.toStringAsFixed(2) ?? 0}h',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFEC4899),
          ),
        ),
        const Text(
          'par jour',
          style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),
      ],
    ),
  );
}
```

### Modifier le Total Tâches

```dart
Widget _buildTotalTachesHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Row(
      children: [
        // ... icône et texte ...
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${_statistiques?.totalTaches ?? 0}', // ← Remplacer ici
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
        ),
      ],
    ),
  );
}
```

---

<div style="page-break-after: always;"></div>

# 8. Gestion des Erreurs {#gestion-erreurs}

## ⚠️ Erreurs Courantes et Solutions

### Erreur 1 : "Failed host lookup"

**Cause :** L'URL de l'API est incorrecte ou le serveur n'est pas accessible

**Solution :**
```dart
// Vérifiez l'URL dans constant.dart
const BASE_URL = 'https://votre-api.com/api/'; // Vérifier cette ligne
```

**Test avec curl :**
```bash
curl https://votre-api.com/api/taches
```

---

### Erreur 2 : "401 Unauthorized"

**Cause :** Le token n'est pas envoyé ou est invalide

**Solution :**
1. Vérifiez que vous êtes connecté
2. Ajoutez des logs pour voir le token :

```dart
// Dans global.dart
Future<Map<String, String>> getHeaders() async {
  // ...
  String? token = prefs.getString('token');
  print("🔑 TOKEN: $token"); // ← Ajoutez ce log
  // ...
}
```

---

### Erreur 3 : "404 Not Found"

**Cause :** L'endpoint n'existe pas

**Solution :**
1. Vérifiez l'endpoint exact avec votre ami backend
2. Testez avec Postman

---

### Erreur 4 : "500 Internal Server Error"

**Cause :** Erreur côté serveur

**Solution :**
1. Contactez votre ami backend
2. Vérifiez les logs du serveur
3. Testez avec Postman pour isoler le problème

---

### Erreur 5 : Les données ne s'affichent pas

**Cause :** Le format JSON ne correspond pas au modèle

**Solution :**
1. Ajoutez des logs pour voir la réponse :

```dart
final response = await getApiData('taches');
print("📦 RESPONSE: ${response.body}"); // ← Ajoutez ce log
```

2. Comparez avec votre modèle `Tache.fromJson()`
3. Adaptez le modèle si nécessaire

---

## 🛡️ Ajouter la Gestion d'Erreurs

### Dans TacheService :

```dart
static Future<List<Tache>> getTaches() async {
  try {
    final response = await getApiData('taches');
    
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      
      // Vérifier les erreurs de l'API
      if (responseData['success'] == false) {
        throw Exception(responseData['errors'] ?? 'Erreur inconnue');
      }
      
      if (responseData['data'] != null) {
        return Tache.fromJsonList(responseData['data']);
      }
    } else {
      throw Exception('Code HTTP: ${response.statusCode}');
    }
    
    return [];
  } on Exception catch (e) {
    if (kDebugMode) print("❌ Exception: $e");
    rethrow; // Relancer pour gérer dans l'UI
  } catch (e) {
    if (kDebugMode) print("❌ Erreur inattendue: $e");
    rethrow;
  }
}
```

### Dans Planning.dart :

```dart
Future<void> _chargerTachesDuJour() async {
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });
  
  try {
    List<Tache> taches = await TacheService.getTachesDuJour();
    setState(() {
      _tachesAPI = taches;
      _isLoading = false;
    });
  } on Exception catch (e) {
    setState(() {
      _errorMessage = 'Erreur : ${e.toString()}';
      _isLoading = false;
    });
  } catch (e) {
    setState(() {
      _errorMessage = 'Erreur inattendue : $e';
      _isLoading = false;
    });
  }
}
```

---

<div style="page-break-after: always;"></div>

# 9. Tests et Validation {#tests}

## 🧪 Plan de Test

### Phase 1 : Test avec Postman (Avant de coder)

#### Test 1 : Connexion
```
POST https://votre-api.com/api/connexion
Content-Type: application/json

{
  "email": "test@example.com",
  "password": "password123"
}

Résultat attendu:
{
  "success": true,
  "data": {
    "token": "eyJ0eXAiOiJKV1...",
    "user": { ... }
  }
}
```

#### Test 2 : Récupérer les tâches
```
GET https://votre-api.com/api/taches
Authorization: Bearer {TOKEN_FROM_LOGIN}

Résultat attendu:
{
  "success": true,
  "data": [ ... liste des tâches ... ]
}
```

#### Test 3 : Statistiques
```
GET https://votre-api.com/api/dashboard/statistiques
Authorization: Bearer {TOKEN}

Résultat attendu:
{
  "success": true,
  "data": {
    "pourcentage_jour": 92,
    ...
  }
}
```

---

### Phase 2 : Test dans l'Application

#### Test 1 : Configuration de base

```dart
// Créez un bouton de test dans dashboard_page.dart
ElevatedButton(
  onPressed: () async {
    print("🔍 Test de l'API...");
    
    try {
      var stats = await TacheService.getStatistiques();
      print("✅ Stats: $stats");
      
      var taches = await TacheService.getTaches();
      print("✅ Tâches: ${taches.length}");
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ API OK ! ${taches.length} tâches'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("❌ Erreur: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Erreur: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  child: const Text('Tester l\'API'),
)
```

#### Test 2 : Affichage des données

1. Lancez l'app : `flutter run`
2. Connectez-vous
3. Allez sur Planning
4. Vérifiez que les tâches s'affichent
5. Cliquez sur une tâche → Le bottom sheet s'ouvre
6. Allez sur Dashboard
7. Vérifiez les statistiques

#### Test 3 : Actions

1. Démarrez une tâche
2. Vérifiez dans les logs que l'API est appelée
3. Terminez la tâche
4. Vérifiez que la liste se rafraîchit

---

### Phase 3 : Tests de Robustesse

#### Test sans connexion internet

1. Désactivez le wifi/data
2. Ouvrez l'app
3. Vérifiez que les messages d'erreur s'affichent correctement

#### Test avec mauvais token

```dart
// Dans constant.dart, mettez temporairement une mauvaise URL
const BASE_URL = 'https://mauvaise-url.com/';
```

Vérifiez que l'erreur est bien gérée.

---

<div style="page-break-after: always;"></div>

# 10. Résolution des Problèmes {#troubleshooting}

## 🔧 Commandes de Débogage

### Voir les logs détaillés
```bash
flutter run --verbose
```

### Nettoyer le projet
```bash
flutter clean
flutter pub get
flutter run
```

### Inspecter les requêtes réseau

Ajoutez dans `getData.dart` et `postData.dart` :

```dart
if (kDebugMode) {
  print("📡 URL: $requestUri");
  print("📡 HEADERS: $headers");
  print("📡 RESPONSE: ${response.body}");
  print("📡 STATUS: ${response.statusCode}");
}
```

---

## 🐛 Checklist de Débogage

Quand quelque chose ne fonctionne pas :

- [ ] L'URL dans `constant.dart` est-elle correcte ?
- [ ] Le serveur backend est-il démarré ?
- [ ] Vous êtes connecté (token valide) ?
- [ ] L'endpoint existe-t-il vraiment ?
- [ ] Le format JSON correspond-il au modèle ?
- [ ] Les logs montrent-ils une erreur ?
- [ ] Avez-vous testé avec Postman ?
- [ ] Le token est-il bien envoyé dans les headers ?

---

## 📱 Tester sur Différents Environnements

### Développement Local

```dart
// constant.dart
const BASE_URL = 'http://192.168.1.100:8000/api/';
```

**Note :** Remplacez `192.168.1.100` par l'IP de votre machine

### Production

```dart
// constant.dart
const BASE_URL = 'https://api.pointage.com/';
```

### Basculer Facilement

```dart
const bool isDev = true; // Changez en false pour production

const BASE_URL = isDev 
  ? 'http://192.168.1.100:8000/api/' 
  : 'https://api.pointage.com/';
```

---

<div style="page-break-after: always;"></div>

# 11. Checklist de Déploiement {#checklist}

## ✅ Avant de Déployer

### Configuration

- [ ] L'URL de production est configurée dans `constant.dart`
- [ ] Les logs de debug sont désactivés ou commentés
- [ ] Les credentials de test sont retirés
- [ ] La variable `isDev` est à `false`

### Tests

- [ ] Toutes les pages fonctionnent avec l'API
- [ ] La connexion/déconnexion fonctionne
- [ ] Les tâches s'affichent correctement
- [ ] Les statistiques sont à jour
- [ ] Les actions (démarrer/terminer) fonctionnent
- [ ] La gestion d'erreurs est en place
- [ ] Testé sans connexion internet
- [ ] Testé sur plusieurs appareils (Android/iOS)

### Performance

- [ ] Les requêtes ne sont pas dupliquées
- [ ] Les données sont mises en cache si nécessaire
- [ ] Les images/assets se chargent rapidement
- [ ] Pas de fuite mémoire

### Sécurité

- [ ] Le token est stocké de manière sécurisée
- [ ] Les données sensibles ne sont pas loguées
- [ ] HTTPS est utilisé en production
- [ ] Les erreurs ne révèlent pas d'informations sensibles

---

## 📋 Checklist d'Intégration API

### Étape 1 : Préparation (Jour 1)
- [ ] Obtenir toutes les informations du backend (URL, endpoints, JSON)
- [ ] Tester tous les endpoints avec Postman
- [ ] Documenter les réponses JSON

### Étape 2 : Configuration (30 min)
- [ ] Modifier `constant.dart` avec la bonne URL
- [ ] Vérifier le format du token dans `global.dart`
- [ ] Créer le fichier `tache_service.dart`

### Étape 3 : Adaptation des Modèles (1h)
- [ ] Vérifier que `Tache` correspond au JSON
- [ ] Vérifier que `Statistique` correspond au JSON
- [ ] Ajouter les champs manquants si nécessaire

### Étape 4 : Intégration Planning (2h)
- [ ] Ajouter les variables d'état
- [ ] Créer la méthode `_chargerTachesDuJour()`
- [ ] Modifier `_buildTachesDuJour()`
- [ ] Ajouter la gestion d'erreurs
- [ ] Tester l'affichage

### Étape 5 : Intégration Dashboard (1h)
- [ ] Ajouter les variables d'état
- [ ] Créer la méthode `_chargerStatistiques()`
- [ ] Modifier `_buildStatistiquesCards()`
- [ ] Remplacer toutes les valeurs en dur
- [ ] Tester l'affichage

### Étape 6 : Actions sur les Tâches (1h)
- [ ] Implémenter `demarrerTache()`
- [ ] Implémenter `terminerTache()`
- [ ] Tester les actions
- [ ] Vérifier que les données se rafraîchissent

### Étape 7 : Tests et Validation (2h)
- [ ] Test complet de l'application
- [ ] Test sans connexion
- [ ] Test avec erreurs API
- [ ] Test sur plusieurs appareils
- [ ] Correction des bugs

---

## 🎯 Résumé : De 0 à 100%

### Vous Avez Déjà (90%)
- ✅ Architecture complète
- ✅ UI terminée
- ✅ Système d'authentification
- ✅ Fonctions API génériques
- ✅ Gestion du token automatique

### Il Reste à Faire (10%)
1. **5 minutes** : Changer l'URL dans `constant.dart`
2. **15 minutes** : Créer `tache_service.dart`
3. **30 minutes** : Adapter les modèles si nécessaire
4. **2 heures** : Intégrer dans Planning et Dashboard
5. **1 heure** : Tester et corriger

**Total : ~4 heures de travail pour tout intégrer !** 🚀

---

<div style="page-break-after: always;"></div>

# 📞 Support et Ressources

## 🔗 Liens Utiles

- **Flutter Documentation :** https://docs.flutter.dev/
- **Dart HTTP Package :** https://pub.dev/packages/http
- **Postman :** https://www.postman.com/
- **JSON Viewer :** https://jsonformatter.org/

## 📚 Fichiers de Référence

Dans votre projet :
- `lib/constant.dart` - Configuration URL
- `lib/core/global.dart` - Headers avec token
- `lib/services/api/actions/getData.dart` - Requêtes GET
- `lib/services/api/actions/postData.dart` - Requêtes POST
- `lib/services/api/models/tache_model.dart` - Modèle Tâche
- `lib/services/api/models/statistique_model.dart` - Modèle Stats

## 🆘 En Cas de Blocage

1. **Vérifiez les logs** : `flutter run --verbose`
2. **Testez avec Postman** : Isolez le problème (app vs API)
3. **Ajoutez des print()** : Voyez ce que renvoie l'API
4. **Contactez le backend** : Vérifiez que le serveur fonctionne
5. **Relisez ce guide** : La solution est probablement ici

---

# 🎉 Conclusion

Vous avez maintenant **tout ce qu'il faut** pour intégrer l'API backend dans votre application de pointage mobile !

## ✨ Points Clés à Retenir

1. **L'architecture est déjà prête** - 90% du travail est fait
2. **Suivez ce guide étape par étape** - Ne sautez pas d'étapes
3. **Testez avec Postman d'abord** - Avant de coder dans l'app
4. **Ajoutez des logs partout** - Pour comprendre ce qui se passe
5. **Communiquez avec le backend** - Travaillez en équipe

## 🚀 Prochaine Action

**MAINTENANT :**
1. Demandez à votre ami backend de vous fournir :
   - URL de l'API
   - Liste des endpoints
   - Exemples de réponses JSON
   - Compte de test

**ENSUITE :**
1. Testez tous les endpoints avec Postman
2. Changez l'URL dans `constant.dart`
3. Créez `tache_service.dart`
4. Intégrez dans Planning et Dashboard
5. Testez et validez

---

**Bon courage ! Vous êtes prêt à intégrer l'API ! 💪**

---

*Document généré le 13 décembre 2025*  
*Version 1.0*

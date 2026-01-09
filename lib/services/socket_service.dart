import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';

/// Service de gestion des connexions Socket.IO pour la synchronisation temps réel
///
/// Ce service se connecte au serveur laravel-echo-server et écoute les événements
/// de mise à jour des planifications pour rafraîchir automatiquement l'interface mobile
class SocketService {
  IO.Socket? _socket;
  bool _isConnected = false;

  // URL du serveur Socket.IO (laravel-echo-server)
  static const String _serverUrl = 'http://localhost:6001';

  // Callbacks pour les événements
  final Map<String, Function(dynamic)> _eventCallbacks = {};

  /// Singleton instance
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  /// Getter pour vérifier l'état de connexion
  bool get isConnected => _isConnected;

  /// Initialiser et connecter au serveur Socket.IO
  ///
  /// [personnelId] : ID du personnel connecté pour écouter son canal privé
  void connect({int? personnelId}) {
    if (_socket != null && _isConnected) {
      debugPrint('🔵 Socket.IO déjà connecté');
      return;
    }

    try {
      debugPrint('🔵 Connexion à Socket.IO: $_serverUrl');

      _socket = IO.io(
        _serverUrl,
        IO.OptionBuilder()
            .setTransports(
                ['websocket']) // WebSocket uniquement pour compatibilité
            .disableAutoConnect() // Connexion manuelle
            .enableForceNew() // Force nouvelle connexion
            .enableReconnection() // Active la reconnexion automatique
            .setReconnectionAttempts(5) // 5 tentatives de reconnexion
            .setReconnectionDelay(1000) // 1 seconde entre chaque tentative
            .build(),
      );

      // Événement : Connexion réussie
      _socket!.onConnect((_) {
        _isConnected = true;
        debugPrint('✅ Socket.IO connecté avec succès');

        // S'abonner au canal global avec Laravel Echo format
        _socket!
            .emit('subscribe', {'channel': 'planification.all', 'auth': {}});
        debugPrint('📡 Abonné au canal: planification.all');

        // S'abonner au canal personnel si personnelId fourni
        if (personnelId != null) {
          _socket!.emit('subscribe',
              {'channel': 'planification.$personnelId', 'auth': {}});
          debugPrint('📡 Abonné au canal: planification.$personnelId');
        }

        // Écouter les événements sur le canal planification.all
        _socket!.on('planification.all:App\\Events\\PlanificationUpdated',
            (data) {
          debugPrint('📨 [Canal global] Événement PlanificationUpdated reçu');
          debugPrint('📦 Données: $data');
          // Propager aux listeners
          if (_eventCallbacks.containsKey('planification.updated')) {
            _eventCallbacks['planification.updated']!(data);
          }
        });

        // Format avec broadcastAs
        _socket!.on('planification.all:planification.updated', (data) {
          debugPrint('📨 [Canal global] Événement planification.updated reçu');
          debugPrint('📦 Données: $data');
          if (_eventCallbacks.containsKey('planification.updated')) {
            _eventCallbacks['planification.updated']!(data);
          }
        });

        // Écouter aussi sur le canal personnel
        if (personnelId != null) {
          _socket!.on('planification.$personnelId:planification.updated',
              (data) {
            debugPrint(
                '📨 [Canal personnel] Événement planification.updated reçu');
            debugPrint('📦 Données: $data');
            if (_eventCallbacks.containsKey('planification.updated')) {
              _eventCallbacks['planification.updated']!(data);
            }
          });
        }
      });

      // Événement : Erreur de connexion
      _socket!.onConnectError((error) {
        debugPrint('❌ Erreur de connexion Socket.IO: $error');
        _isConnected = false;
      });

      // Événement : Déconnexion
      _socket!.onDisconnect((_) {
        _isConnected = false;
        debugPrint('🔴 Socket.IO déconnecté');
      });

      // Événement : Erreur générale
      _socket!.on('error', (error) {
        debugPrint('❌ Erreur Socket.IO: $error');
      });

      // Lancer la connexion
      _socket!.connect();
    } catch (e) {
      debugPrint('❌ Exception lors de la connexion Socket.IO: $e');
    }
  }

  /// Écouter un événement spécifique
  ///
  /// [eventName] : Nom de l'événement (ex: 'planification.updated')
  /// [callback] : Fonction appelée quand l'événement est reçu
  void on(String eventName, Function(dynamic) callback) {
    if (_socket == null) {
      debugPrint('⚠️ Socket.IO non initialisé. Appelez connect() d\'abord.');
      return;
    }

    _eventCallbacks[eventName] = callback;
    _socket!.on(eventName, (data) {
      debugPrint('📨 Événement reçu: $eventName');
      debugPrint('📦 Données: $data');
      callback(data);
    });
  }

  /// Arrêter d'écouter un événement
  void off(String eventName) {
    if (_socket == null) return;
    _socket!.off(eventName);
    _eventCallbacks.remove(eventName);
    debugPrint('🔇 Événement $eventName désactivé');
  }

  /// Se désabonner d'un canal
  void unsubscribe(String channel) {
    if (_socket == null || !_isConnected) return;
    _socket!.emit('unsubscribe', {'channel': channel});
    debugPrint('📴 Désabonné du canal: $channel');
  }

  /// Déconnecter le socket
  void disconnect() {
    if (_socket == null) return;

    _socket!.disconnect();
    _socket!.dispose();
    _socket = null;
    _isConnected = false;
    _eventCallbacks.clear();

    debugPrint('🔴 Socket.IO déconnecté et nettoyé');
  }

  /// Reconnecter au serveur
  void reconnect({int? personnelId}) {
    disconnect();
    connect(personnelId: personnelId);
  }
}

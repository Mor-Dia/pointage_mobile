import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<List<ConnectivityResult>>
      _connectivityStreamController =
      StreamController<List<ConnectivityResult>>();

  ConnectivityService() {
    // Ecoute les changements de connectivité
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _connectivityStreamController.add(result);
    });
  }

  // Retourne un Stream de List<ConnectivityResult>
  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivityStreamController.stream;

  // Vérifie la connectivité initiale
  Future<bool> hasConnection() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void dispose() {
    _connectivityStreamController.close();
  }
}

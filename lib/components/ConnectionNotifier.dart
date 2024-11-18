// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:toastification/toastification.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:yogivida_mobile/services/connection/Connectivity_service.dart'; // Service de connectivité
//
// class ConnectionNotifier extends StatefulWidget {
//   final Widget child;
//
//   const ConnectionNotifier({Key? key, required this.child}) : super(key: key);
//
//   @override
//   _ConnectionNotifierState createState() => _ConnectionNotifierState();
// }
//
// class _ConnectionNotifierState extends State<ConnectionNotifier> {
//   late ConnectivityService _connectivityService;
//   late StreamSubscription<List<ConnectivityResult>> _subscription;
//   bool _isOnline = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _connectivityService = ConnectivityService();
//     _subscription = _connectivityService.connectivityStream
//         .listen(_updateConnectivityStatus);
//     _checkInitialConnectivity();
//   }
//
//   void _checkInitialConnectivity() async {
//     _updateConnectivityStatus;
//   }
//
//   void _updateConnectivityStatus(List<ConnectivityResult> result) async {
//     if (result[0] == ConnectivityResult.wifi) {
//       final response = await http.get(Uri.parse('https://www.google.com'));
//       if (response.statusCode == 200) {
//         _showOnlineSnackbar();
//       } else {
//         _showOfflineSnackbar();
//       }
//     } else if (result[0] == ConnectivityResult.none) {
//       _showOfflineSnackbar();
//     }
//   }
//
//   void _showOfflineSnackbar() {
//     Fluttertoast.showToast(
//         msg: "Vous êtes hors ligne !", // Message à afficher
//         toastLength: Toast.LENGTH_LONG, // Durée du toast (courte ou longue)
//         gravity: ToastGravity.BOTTOM, // Position du toast (haut, bas, centre)
//         backgroundColor: Colors.red, // Couleur de fond
//         textColor: Colors.white, // Couleur du texte
//         fontSize: 16.0 // Taille de la police
//         );
//   }
//
//   void _showOnlineSnackbar() {
//     Fluttertoast.showToast(
//         msg: "Connexion restauré ! ", // Message à afficher
//         toastLength: Toast.LENGTH_LONG, // Durée du toast (courte ou longue)
//         gravity: ToastGravity.BOTTOM, // Position du toast (haut, bas, centre)
//         backgroundColor: Colors.green, // Couleur de fond
//         textColor: Colors.white, // Couleur du texte
//         fontSize: 16.0 // Taille de la police
//         );
//   }
//
//   @override
//   void dispose() {
//     _subscription.cancel();
//     _connectivityService.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

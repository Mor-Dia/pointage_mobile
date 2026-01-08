import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pointage_mobile/screens/Boutique/Panier.dart';
import 'package:pointage_mobile/screens/Home/MainHome.dart';
import 'package:pointage_mobile/screens/Home/home_page.dart';
import 'package:pointage_mobile/screens/maintenance/maintenance_page_screen.dart';
import 'package:pointage_mobile/screens/update/update_page_screen.dart';
import 'package:pointage_mobile/services/api/models/panier_model.dart';
import 'package:pointage_mobile/services/authBloc/auth_bloc_bloc.dart';
import 'package:pointage_mobile/core/models/user_model.dart';
import 'package:pointage_mobile/services/authentication_bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  isMyAppUpdated() async {
    bool isUpdated = true;
    bool forceUpdate = false;
    Map<String, dynamic>? valueToReturn;

    CollectionReference linkRef = FirebaseFirestore.instance.collection(
      "versions",
    );
    dynamic linkDoc = await linkRef.doc("currentversion").get();
    String? lastAppVersion;
    String? version;
    String? message;
    try {
      lastAppVersion = linkDoc.data()["currentversion"];
      forceUpdate = linkDoc.data()["forceUpdate"];
      message = linkDoc.data()["message"];
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
      print("NOW VERSION CHECK " +
          version.toString() +
          " LAST VERSION CHECK " +
          lastAppVersion.toString());
    } catch (exception, stackTrace) {
      print("VERSION CONTROL ERROR" + exception.toString());
    }

    if (lastAppVersion != version) {
      isUpdated = false;
    }

    valueToReturn = {
      "isUpdated": isUpdated,
      "forceUpdate": forceUpdate,
      "message": message
    };

    print("OVER VERSION CHECK " + valueToReturn.toString());
    return valueToReturn;
  }

  showUpdateAdvertisement(context) async {
    Map<String, dynamic>? isAppUpdated = await isMyAppUpdated();
    bool isUpdated = true;
    bool forceUpdate = false;
    late String message;

    if (isAppUpdated != null) {
      isUpdated = isAppUpdated["isUpdated"]!;
      forceUpdate = isAppUpdated["forceUpdate"]!;
      message = isAppUpdated["message"]!;
    }

    print("IS UPDATED " + isUpdated.toString());
    print("IS FORCED UPDATED " + forceUpdate.toString());

    if (!isUpdated) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => UpdatePageScreen(
            message: message,
            forceUpdate: forceUpdate,
          ),
        ),
        (route) => false,
      );
    }
    return;
  }

  getMaintenance() async {
    bool isMaintenance = false;
    String? image;
    Map<String, dynamic>? valueToReturn;

    CollectionReference linkRef = FirebaseFirestore.instance.collection(
      "maintenance",
    );
    dynamic linkDoc = await linkRef.doc("maintenance").get();
    try {
      isMaintenance = linkDoc.data()["isMaintenance"];
      image = linkDoc.data()["image"];
      print("NOW MAINTENANCE CHECK " + isMaintenance.toString());
    } catch (exception, stackTrace) {
      print("MAINTENANCE CONTROL ERROR" + exception.toString());
    }

    valueToReturn = {"isMaintenance": isMaintenance, "image": image};

    print("OVER MAINTENANCE CHECK " + valueToReturn.toString());
    return valueToReturn;
  }

  bool _hasNavigated = false;

  void _navigateToHome(BuildContext context) async {
    if (_hasNavigated) return; // <-- empêche un second appel
    _hasNavigated = true;

    Map<String, dynamic>? isMaintenance = await getMaintenance();
    bool is_maintenance = false;
    late String image;
    if (isMaintenance != null) {
      is_maintenance = isMaintenance["isMaintenance"]!;
      image = isMaintenance["image"]!;
      if (is_maintenance) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) =>
                MaintenancePageScreen(image: image), // tu passes l’argument ici
          ),
          (route) => false,
        );
        return;
      }
    }

    showUpdateAdvertisement(context);

    await Future.delayed(const Duration(seconds: 2)); // effet de chargement

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Mainhome()),
      (route) => false,
    );
  }

  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToHome(context);
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logos/fond.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset('assets/images/logos/icon.png', width: 150),
        ),
      ),
    );
  }
}

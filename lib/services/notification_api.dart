import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  static final onNotifications = BehaviorSubject<String?>();
  static final CollectionReference devicesRef =
      FirebaseFirestore.instance.collection("devices");

  /// Initialisation des notifications et FCM
  Future<void> init({required BuildContext context}) async {
    print("Initialisation Notifications & FCM");

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('FCM permission status: ${settings.authorizationStatus}');

    // Demander la permission (iOS)
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    // Écoute des messages en foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification reçue en foreground");
      _showNotification(message);
    });

    // Écoute quand l'app est ouverte via une notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification ouverte par l'utilisateur");
      // Traiter navigation ici si besoin
    });
  }

  /// Affiche une notification locale à partir d'un message FCM
  static Future<void> _showNotification(RemoteMessage message) async {
    print("Affichage de la notifications");

    // await AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
    //     channelKey: 'basic_channel',
    //     title: 'Notification',
    //     body: 'test ici',
    //     notificationLayout: NotificationLayout.Default,
    //   ),
    // );

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: 'basic_channel',
          title: notification.title ?? 'Notification',
          body: notification.body ?? '',
          notificationLayout: NotificationLayout.Default,
        ),
      );
    }
  }

  static void manageTokenFcm() async {
    String? token = await getTokenFcm();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUserId = prefs.getInt("id").toString();
    print("rentre ici  notifications =>");
    print("rentre ici token fcm currentUserId =>" +
        currentUserId +
        prefs.getKeys().toString());
    print("Token FCM: $token, UserID: $currentUserId");

    String selectedBase = "test";
    if (token != null) {
      saveTokenToDatabase(token, currentUserId, selectedBase);
    }
  }

  static void saveTokenToDatabase(
      String token, String? currentUserId, String selectedBase) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var nomComplet = prefs.getString("nom_complet").toString();

    var data1 = {
      "token": token,
      "userId": currentUserId.toString(),
      "nomComplet": nomComplet
    };
    CollectionReference devicesRef1 =
        FirebaseFirestore.instance.collection("devices_" + selectedBase);

    try {
      if (currentUserId != null) {
        var snapshots = await devicesRef1.doc(currentUserId.toString()).get();
        if (snapshots.exists) {
          devicesRef1.doc(currentUserId.toString()).update(data1);
        } else {
          await devicesRef1.doc(currentUserId.toString()).set(data1);
        }
      }
    } catch (e) {
      print("Erreur lors de la sauvegarde du token FCM : $e");
    }
  }

  static Future<String?> getTokenFcm() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static Future<void> deleteTokenFcm() async {
    return await FirebaseMessaging.instance.deleteToken();
  }
}

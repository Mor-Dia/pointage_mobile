import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class NotificationApi {
  // static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static final CollectionReference devicesRef =
      FirebaseFirestore.instance.collection("devices");

  static Future init(
      {bool initSheduled = false, required BuildContext context}) async {
    log("function listen init");
  }

  static void manageTokenFcm() async {
    String? token = await getTokenFcm();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUserId = prefs.getInt("id").toString();
    print("rentre ici token fcm currentUserId =>" + token.toString());

    // var currentEmail = prefs.getKeys();
    // String selectedBase = prefs.getString("selectedBase").toString() ?? "prod";
    String selectedBase = "test";
    print("token fcm " + token.toString());
    print("token fcm id " + currentUserId);
    if (token != null) {
      print("rentre ici token fcm currentUserId =>" + currentUserId.toString());
      saveTokenToDatabase(token, currentUserId, selectedBase);
    }
  }

  static void saveTokenToDatabase(
      String token, String? currentUserId, String selectedBase) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var nomComplet = prefs.getString("nom_complet").toString();
    // {etat, current_credit, nom_complet, id, email, nb_souscription, userinfos, telephone, token}

    var data1 = {
      "token": token,
      "userId": currentUserId,
      "nomComplet": nomComplet
    };
    CollectionReference devicesRef1 =
        FirebaseFirestore.instance.collection("devices_" + selectedBase);

    try {
      if (currentUserId != null) {
        var snapshots = await devicesRef1.doc(currentUserId.toString()).get();
        if (snapshots.exists) {
          print("devices firebase ici dejaaaa" + snapshots.data().toString());
          devicesRef1.doc(currentUserId.toString()).update(data1);
          snapshots = await devicesRef1.doc(currentUserId.toString()).get();
        } else {
          print("devices firebase ici newww" + snapshots.data().toString());
          await devicesRef1.doc(currentUserId.toString()).set(data1);
          snapshots = await devicesRef1.doc(currentUserId.toString()).get();
          print("devices firebase " + snapshots.data().toString());
        }
      }
    } catch (e) {
      print("selected base when save token fcm 333 " + selectedBase);
      print("saveTk fcm " + e.toString());
    }
  }

  static Future<String?> getTokenFcm() async {
    String? token;
    token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  //post fcm
  static Future fcmSend(
      {required List<dynamic> fcmTokens,
      required chatId,
      required destName,
      required msgContent}) async {
    String serverKey =
        'AAAACtMWPeo:APA91bEAa5oSatG7_ZJBUkIms2yatYviUtxOiQg_yyk0--CaG6uTf0kiHwfxf-tnv7LZojiB7EAirFmvJqDZq3CVWmpDzmvVVipiBQYIqlRH-23udX9Tsj6ghnZ8zYy6sXRgXnznuA3-';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=' + serverKey
    };

    var data = {
      "notification": {
        'title': "Nouveau message",
        'body': destName.toString() + " : " + msgContent.toString()
      },
      'priority': "high",
      'contentAvailable': true,
      'data': {
        'route': 'message',
        'chatId': chatId.toString(),
        'chatName': destName.toString()
      },
      'registration_ids': fcmTokens
    };

    String url = "https://fcm.googleapis.com/fcm/send";

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(data), headers: headers);
      final parsed = json.decode(response.body);
      return parsed;
    } on Exception catch (e) {
      if (e is SocketException) {
        throw ('Aucun Acces a internet');
      } else {
        throw ('Une erreur est survenue');
      }
    }
  }
}

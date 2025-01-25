import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/services/api/actions/postData.dart';

import '../../constant.dart';
import '../global.dart';

class Helpers {
  static String firstLetterCapitalize(String? text) {
    if (text == null || text == "") {
      return "";
    } else {
      return "${text[0].toUpperCase()}${text.substring(1)}";
    }
  }

  static String formatNumber(dynamic number) {
    if (number is! int && number is! double) {
      throw ArgumentError('Input must be an int or double.');
    }

    // Convert the number to a string
    String numberString = number.toStringAsFixed(number is double ? 2 : 0);

    // Split into integer and decimal parts
    List<String> parts = numberString.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Format the integer part with commas
    StringBuffer formattedInteger = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger.write(' ');
      }
      formattedInteger.write(integerPart[i]);
    }

    // Combine formatted integer and decimal parts
    return decimalPart.isEmpty
        ? formattedInteger.toString()
        : '${formattedInteger.toString()}.${decimalPart}';
  }

  static showSnackBar(BuildContext context,
      {bool isError = false, String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "",
          style: TextStyle(
            color: isError ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isError
            ? Colors.red
            : Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }

  static saveDataInSharedPreferences(String key, dynamic data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      switch (data.runtimeType) {
        case String:
          if (kDebugMode) {
            print("SAVING STRING DATA $data");
          }
          await prefs.setString(key, data);
        case bool:
          if (kDebugMode) {
            print("SAVING BOOL DATA $data");
          }
          await prefs.setBool(key, data);
        case int:
          if (kDebugMode) {
            print("SAVING INT DATA $data");
          }
          await prefs.setInt(key, data);
        case double:
          if (kDebugMode) {
            print("SAVING DOUBLE DATA $data");
          }
          await prefs.setDouble(key, data);
      }
      if (kDebugMode) {
        print("SAVING NONE DATA $data");
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static removeDataFromSharedPreferences(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove(key);
      return true;
    } catch (e) {
      return false;
    }
  }

  static getDataFromSharedPreferences(String key, String dataType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print("DATA TYPE TO RETRIEVE $dataType");
    }
    try {
      switch (dataType) {
        case "String":
          return prefs.getString(key);
        case "bool":
          return prefs.getBool(key);
        case "int":
          return prefs.getInt(key);
        case "double":
          return prefs.getDouble(key);
        default:
          return prefs.getString(key);
      }
    } catch (e) {
      return;
    }
  }

  static initFcm() async {
    FirebaseMessaging fcm = firebaseMessagingInstance();

    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await fcm.setAutoInitEnabled(true);
    fcm.getToken().then((value) {
      print("FCM TOKEN $value");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("ON MESSAGE NOTIFICATION onMessage");
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      if (kDebugMode) {
        print("ON MESSAGE ON BACKGROUND NOTIFICATION ");
      }
    });
  }

  static Future<String> getBaseUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(
        "from firebase mode debug " + prefs.getString("modeDebug").toString());
    if (!prefs.containsKey("modeDebug")) {
      prefs.setString("selectedBase", "prod");
    }
    String selectedBase = prefs.getString("selectedBase").toString();
    CollectionReference linkRef =
        FirebaseFirestore.instance.collection(selectedBase);

    String? baseUrl;
    try {
      dynamic linkDoc = await linkRef.doc("liens").get();
      baseUrl = linkDoc.data()["baseUrl"];
      print("link from firebase " +
          selectedBase.toString() +
          " " +
          baseUrl.toString());
    } catch (exception, stackTrace) {
      print("NETWORK ERROR WITH CONSOLE B " + exception.toString());
    }

    baseUrl ??= BASE_URL;

    return baseUrl;
    // return BASE_URL;
  }

  static handleNotificationData(
      BuildContext context, Map<String, dynamic> notificationData) {
    if (kDebugMode) {
      //hideprint("NOTIFICATION DATA $notificationData");
    }
    if (notificationData["type"] == "pratique") {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else if (notificationData["type"] == "reservation") {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  static setFCMTokenToServer() async {
    print("SET FCM TOKEN ");
    // FirebaseMessaging fcm = firebaseMessagingInstance();
    // await fcm.setAutoInitEnabled(true);
    // String? fcmToken = await fcm.getToken();
    // if(fcmToken != null){
    //   print("SET FCM TOKEN 2");
    //   postApiData("setfcmtoken", {"fcm_token": fcmToken});
    // }
  }

  static double getGridElementWidth(context, extraSpace) {
    var number = 2;
    double currentSize = MediaQuery.of(context).size.width;
    if (currentSize > 600 && currentSize <= 840) {
      number = 3;
    } else if (currentSize > 840 && currentSize <= 1200) {
      number = 4;
    } else if (currentSize > 1200 && currentSize <= 1800) {
      number = 4;
    } else if (currentSize > 1800) {
      number = 6;
    }
    return (currentSize / number) - extraSpace;
  }
}

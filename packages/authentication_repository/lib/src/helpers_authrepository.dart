
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HelpersAuthrepository{

  // static Future<String> getBaseUrl() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print("from firebase mode debug " + prefs.getString("modeDebug").toString());
  //   if (!prefs.containsKey("modeDebug")) {
  //     prefs.setString("selectedBase", "prod");
  //   }
  //   String selectedBase = prefs.getString("selectedBase").toString();
  //   CollectionReference linkRef = FirebaseFirestore.instance.collection(selectedBase);
  //
  //   String? baseUrl;
  //   try {
  //     dynamic linkDoc = await linkRef.doc("liens").get();
  //     baseUrl = linkDoc.data()["baseUrl"];
  //   } catch (exception, stackTrace) {
  //     print("NETWORK ERROR WITH CONSOLE B " + exception.toString());
  //   }
  //
  //   if (baseUrl == null) {
  //     baseUrl = "https://yogi-vida.com/yogivida_back_test/";
  //   }
  //
  //   return baseUrl;
  // }

}
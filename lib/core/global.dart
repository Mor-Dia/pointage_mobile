import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseMessaging firebaseMessagingInstance() {
  FirebaseMessaging fcm = FirebaseMessaging.instance;
  return fcm;
}

Future<Map<String, String>> getHeaders() async {
  Map<String, String> headers = {};
  headers.addAll(
      {"Accept": "application/json", "Content-Type": "application/json"});
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  if (token != null) {
    headers.addAll({"Authorization": "Bearer $token"});
  }
  return headers;
}

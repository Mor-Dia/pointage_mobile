// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:http/http.dart' as http;

// class NotificationApi {
//   // static final _notifications = FlutterLocalNotificationsPlugin();
//   static final onNotifications = BehaviorSubject<String?>();
//   static final CollectionReference usersRef =
//       FirebaseFirestore.instance.collection("users");
//   static final CollectionReference devicesRef =
//       FirebaseFirestore.instance.collection("devices");

//   // static NotificationDetails _notificationDetails() {
//   //   // final androidDetails = new AndroidNotificationDetails(
//   //   //     "hoballahome", "Hoballahome Channel", "channelDescription",
//   //   //     importance: Importance.high,
//   //   //     priority: Priority.high,
//   //   //     playSound: true,
//   //   //     sound: RawResourceAndroidNotificationSound('newnotif'));

//   //   // final iosDetails = new IOSNotificationDetails(
//   //   //   sound: 'newnotif.mp3',
//   //   //   presentAlert: true,
//   //   //   presentBadge: true,
//   //   //   presentSound: true,
//   //   // );
//   //   return NotificationDetails();
//   //   // return NotificationDetails(android: androidDetails);
//   //   // return NotificationDetails(android: androidDetails, iOS: iosDetails);
//   // }

//   static Future init(
//       {bool initSheduled = false, required BuildContext context}) async {
//     log("function listen init");
//     //final android = new AndroidInitializationSettings('mipmap/ic_launcher');
//     // final android = new AndroidInitializationSettings('logo_light');

//     // final iOS = new IOSInitializationSettings();

//     // final settings = new InitializationSettings(android: android, iOS: iOS);
//     // final settings = new InitializationSettings(android: android);

//     //Quand l'application est fermée
//     // final details = await _notifications.getNotificationAppLaunchDetails();
//     // if (details != null && details.didNotificationLaunchApp) {
//     //   onNotifications.add(details.payload);
//     // }

//     // await _notifications.initialize(settings,
//     //     onSelectNotification: (payload) async {
//     //   //onNotifications.add(payload);
//     //   //CommonValues.payload = payload;
//     //   listenNotifications(context: context, payload: payload, navBloc: navBloc);
//     // });
//   }

//   // redirection des notifs vers les pages concerneis
//   // static void listenNotifications(
//   //     {BuildContext? context, String? payload, required NavBloc navBloc}) {
//   //   log("function listen notifications");
//   //   if (payload != null) {
//   //     log("function listen dougue 1");
//   //     Widget? a = getPageFromRoute(route: payload, data: CommonValues.msgData);
//   //     if (context != null && a != null) {
//   //       if (navBloc.state is NavDisplaying) {
//   //         NavDisplaying nd = navBloc.state as NavDisplaying;
//   //         log('current page : ' +
//   //             nd.currentPage.toString() +
//   //             " page to redirect " +
//   //             a.toString());
//   //         if (nd.currentPage.toString() != a.toString()) {
//   //           goTo1(context, a, navBloc);
//   //         }
//   //       }
//   //     }
//   //   }
//   // }

//   // afficher une notification en locale
//   // static Future showNotification(
//   //     {int id = 0, String? title, String? content, String? payload}) async {
//   //   return _notifications.show(id, title, content, _notificationDetails(),
//   //       payload: payload);
//   // }

//   // FCM functions firebase cloud Message

//   // Quand l'app est en arriere plan et le user tape sur la notification
//   // static void onMessageOpenedApp(
//   //     {required BuildContext? context, required NavBloc navBloc}) {
//   //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
//   //     log("function listen notifications fcm");
//   //     final routeFromMessage = message.data["route"];
//   //     if (routeFromMessage != null) {
//   //       log("function listen dougue 2");
//   //       log("arriere plan " + routeFromMessage);
//   //       Widget? a =
//   //           getPageFromRoute(route: routeFromMessage, data: message.data);
//   //       if (context != null && a != null) {
//   //         if (navBloc.state is NavDisplaying) {
//   //           NavDisplaying nd = navBloc.state as NavDisplaying;
//   //           log('current page : ' +
//   //               nd.currentPage.toString() +
//   //               " page to redirect " +
//   //               a.toString());
//   //           if (nd.currentPage.toString() != a.toString()) {
//   //             goTo1(context, a, navBloc);
//   //           }
//   //         }
//   //       }
//   //     }
//   //   });
//   // }

//   //Quand l'app n'est pas en arriere plan
//   // static void onMessage({required BuildContext context}) {
//   //   FirebaseMessaging.onMessage.listen((message) {
//   //     log("on plan 0" + message.toString());
//   //     if (message.notification != null) {
//   //       log("on plan 1 " + message.notification!.body.toString());
//   //       log("on plan 2 " + message.notification!.title.toString());
//   //       log("on plan 3 " + message.data.toString());
//   //       CommonValues.msgData = message.data;
//   //       NotificationApi.showNotificationFCM(message);
//   //     }
//   //   });
//   // }

//   //Lorsque l'application est fermée et FCM envoie une notification
//   // static void onAppCloseInstance({required BuildContext context}) {
//   //   FirebaseMessaging.instance.getInitialMessage().then((message) async {
//   //     log("function listen onAppCloseInstance fcm");
//   //     if (message != null) {
//   //       log("function listen dougue 3");
//   //       final routeFromMessage = message.data["route"];
//   //       Widget? a =
//   //           getPageFromRoute(route: routeFromMessage, data: message.data);

//   //       if (a != null) {
//   //         goTo(context, a);
//   //       }
//   //     }
//   //   });
//   // }

//   // static void backgroundMessageFcm({required BuildContext context}) {
//   //   FirebaseMessaging.onBackgroundMessage((message) async {
//   //     log("bg handler" + message.toString());
//   //     print("bg handler" + message.toString());
//   //     await Firebase.initializeApp();
//   //     return null;
//   //   });
//   // }

//   //Quand l'app est fermée et on transorme FCM en local Notification
//   // static Future showNotificationFCM(RemoteMessage message) async {
//   //   try {
//   //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//   //     return _notifications.show(id, message.notification!.title,
//   //         message.notification!.body, _notificationDetails(),
//   //         payload: message.data["route"]);
//   //   } on Exception catch (e) {
//   //     print(e);
//   //   }
//   // }

//   static void manageTokenFcm() async {
//     String? token = await getTokenFcm();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String currentUserId = prefs.getInt("id").toString();
//     print("rentre ici token fcm currentUserId =>" + token.toString());

//     // var currentEmail = prefs.getKeys();
//     // String selectedBase = prefs.getString("selectedBase").toString() ?? "prod";
//     String selectedBase = "test";
//     print("token fcm " + token.toString());
//     print("token fcm id " + currentUserId);
//     if (token != null) {
//       print("rentre ici token fcm currentUserId =>" + currentUserId.toString());
//       saveTokenToDatabase(token, currentUserId, selectedBase);
//     }
//     /*  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
//       saveTokenToDatabase(newToken, currentEmail);
//     }); */
//   }

//   // static void manageTokenRefreshedFcm() {
//   //   FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
//   // }

//   static void saveTokenToDatabase(
//       String token, String? currentUserId, String selectedBase) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     var nomComplet = prefs.getString("nom_complet").toString();
//     // {etat, current_credit, nom_complet, id, email, nb_souscription, userinfos, telephone, token}

//     var data1 = {
//       "token": token,
//       "userId": currentUserId,
//       "nomComplet": nomComplet
//     };
//     CollectionReference devicesRef1 =
//         FirebaseFirestore.instance.collection("devices_" + selectedBase);

//     try {
//       if (currentUserId != null) {
//         var snapshots = await devicesRef1.doc(currentUserId.toString()).get();
//         if (snapshots.exists) {
//           print("devices firebase ici dejaaaa" + snapshots.data().toString());
//           devicesRef1.doc(currentUserId.toString()).update(data1);
//           snapshots = await devicesRef1.doc(currentUserId.toString()).get();
//         } else {
//           print("devices firebase ici newww" + snapshots.data().toString());
//           await devicesRef1.doc(currentUserId.toString()).set(data1);
//           snapshots = await devicesRef1.doc(currentUserId.toString()).get();
//           print("devices firebase " + snapshots.data().toString());
//         }
//       }
//     } catch (e) {
//       print("selected base when save token fcm 333 " + selectedBase);
//       print("saveTk fcm " + e.toString());
//     }
//   }

//   // Get the token each time the application loads

//   static Future<String?> getTokenFcm() async {
//     String? token;
//     token = await FirebaseMessaging.instance.getToken();
//     return token;
//   }

//   /* static void ifTokenRefreshed() {
//     // Any time the token refreshes, store this in the database too.
//     FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
//   } */

//   //post fcm
//   static Future fcmSend(
//       {required List<dynamic> fcmTokens,
//       required chatId,
//       required destName,
//       required msgContent}) async {
//     String serverKey =
//         'AAAACtMWPeo:APA91bEAa5oSatG7_ZJBUkIms2yatYviUtxOiQg_yyk0--CaG6uTf0kiHwfxf-tnv7LZojiB7EAirFmvJqDZq3CVWmpDzmvVVipiBQYIqlRH-23udX9Tsj6ghnZ8zYy6sXRgXnznuA3-';

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'key=' + serverKey
//     };

//     var data = {
//       "notification": {
//         'title': "Nouveau message",
//         'body': destName.toString() + " : " + msgContent.toString()
//       },
//       'priority': "high",
//       'contentAvailable': true,
//       'data': {
//         'route': 'message',
//         'chatId': chatId.toString(),
//         'chatName': destName.toString()
//       },
//       'registration_ids': fcmTokens
//     };

//     String url = "https://fcm.googleapis.com/fcm/send";

//     try {
//       final response = await http.post(Uri.parse(url),
//           body: json.encode(data), headers: headers);
//       final parsed = json.decode(response.body);
//       return parsed;
//     } on Exception catch (e) {
//       if (e is SocketException) {
//         throw ('Aucun Acces a internet');
//       } else {
//         throw ('Une erreur est survenue');
//       }
//     }
//   }

//   //Methode Post avec Dio pour upload image
//   // static Future<Response> uploadImage(
//   //     File? file, Map<String, dynamic> data) async {
//   //   String baseUrl = await getBaseUrl();
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String currentToken = prefs.getString("currentToken").toString();
//   //   var dio = Dio();
//   //   if (file != null) {
//   //     log("log data to send file upload " + file.path.toString());
//   //     String fileName = file.path.split('/').last;
//   //     MultipartFile multipartFile =
//   //         await MultipartFile.fromFile(file.path, filename: fileName);

//   //     data.update("image", (value) => multipartFile);
//   //   }

//   //   log("log data to send uploadd" + data.toString());
//   //   FormData formData = FormData.fromMap(data);
//   //   final response = await dio.post(baseUrl + "user/save",
//   //       data: formData,
//   //       options: Options(
//   //           headers: Attributes.setHeaders(currentToken),
//   //           followRedirects: false,
//   //           validateStatus: (status) => status! < 500));

//   //   return response;
//   // }

//   //Counter Client
//   // static counterClient(
//   //     /*{ required String destId,
//   //     required String currentUserId,
//   //     required msgContent,
//   //     required destName,
//   //     required }*/
//   //     ) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String baseUrl = await getBaseUrl();
//   //   String? token = prefs.getString("currentToken");
//   //   String? pointVenteId = prefs.getString("point_vente_id");
//   //   bool singlePv =
//   //       prefs.getString("single_point_vente").toString().toLowerCase() == "true"
//   //           ? true
//   //           : false;
//   //   log("token " + token.toString());
//   //   log("point_vente_id " + pointVenteId.toString());
//   //   log("single pv " + singlePv.toString());
//   //   dynamic headers = Attributes.setHeaders(token);
//   //   String route = baseUrl + "daycounter/save";
//   //   log("headers " + headers.toString());
//   //   log("route " + route);
//   //   var dio = Dio();
//   //   //dio.options.headers['Content-type'] = 'application/json';
//   //   // dio.options.headers["Authorization"] = "Bearer $token";

//   //   try {
//   //     if (singlePv == false && pointVenteId == null) {
//   //       return {
//   //         "errors": true,
//   //         "message":
//   //             "Veuillez choisir le point de vente par défaut dans les paramètres généraux"
//   //       };
//   //     }
//   //     final reponse = await Dio().post(route,
//   //         data: {"point_vente_id": pointVenteId},
//   //         options: Options(
//   //             followRedirects: true,
//   //             headers: headers,
//   //             validateStatus: (status) => status! < 500));
//   //     log("dio reponse " + reponse.data.toString());
//   //     if (reponse.statusCode == 302) {
//   //       return reponse.statusCode;
//   //     } else if (reponse.data.containsKey("data")) {
//   //       if (reponse.data["data"].containsKey("errors")) {
//   //         return {"errors": true, "message": reponse.data["data"]["errors"]};
//   //       }
//   //     } else
//   //       return 0;
//   //     /*  var x = reponse.data
//   //         .toString()
//   //         .split("url=")
//   //         .last
//   //         .split("/>")
//   //         .first
//   //         .replaceAll('"', "")
//   //         .replaceAll("'", "");
//   //     log("dio reponse " +
//   //         reponse.data
//   //             .toString()
//   //             .split("url=")
//   //             .last
//   //             .split("/>")
//   //             .first
//   //             .replaceAll('"', "")
//   //             .replaceAll("'", ""));
//   //     final reponse2 = await Dio().get(x);
//   //     log("dio get " + reponse2.toString()); */
//   //     /* final response = await http.post(Uri.parse(route),
//   //         headers: Attributes.setHeaders(token));
//   //     /*  final parsed = json.decode(response.body);
//   //     log("after post to back" + response.statusCode.toString());
//   //     return parsed; */
//   //     print("RESPOND BODY " + response.body.toString());

//   //     if (response.statusCode == 200) {
//   //       //final responseBody = json.decode(response.body);
//   //       print("RESPOND BODY " + response.body.toString());
//   //       /* if (responseBody['data'].containsKey("daycounterusers")) {
//   //         final parsed = responseBody['data']['daycounteruser'];
//   //         log("PARSED " + parsed.toString());
//   //       } */
//   //     } */
//   //   } on Exception catch (e) {
//   //     log(e.toString());
//   //     throw (0);
//   //   }
//   // }

//   /* static Future<void> sendNotifCloud({
//     required String destId,
//     required String currentUserId,
//     required String baseUrl,
//     required String token,
//     required msgContent,
//     required destName,
//   }) async {
//     HttpsCallable callable =
//         FirebaseFunctions.instance.httpsCallable('sendDataMsgToBack');
//     var data = {
//       "created_at_user_id": currentUserId,
//       "user_id": destId,
//       "title": "Nouveau message",
//       "message": destName.toString() + " : " + msgContent.toString(),
//       "baseUrl": baseUrl+'notif/save',
//       "token": token
//     };
//     final resp = await callable.call(data);
//     print("result: ${resp.data}");
//   } */

//   //send notif to user fCM
//   /* static sendDataMsgToBack({
//     required String destId,
//     required String currentUserId,
//     required msgContent,
//     required destName,
//   }) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String baseUrl = await getBaseUrl();
//     String? token = prefs.getString("currentToken");
//     var data = {
//       "created_at_user_id": currentUserId,
//       "user_id": destId,
//       "title": "Nouveau message",
//       "message": destName.toString() + " : " + msgContent.toString()
//     };

//     try {
//       final response = await http.post(Uri.parse(baseUrl + "notif/save"),
//           body: json.encode(data), headers: Attributes.setHeaders(token));
//       final parsed = json.decode(response.body);
//       log("after post to back" + parsed.toString());
//       return parsed;
//     } on Exception catch (e) {
//       log(e.toString());
//       throw ('Une erreur est survenue');
//     }
//   } */

//   //send notif to user fCM
//   // static sendNotifToUserFcm(
//   //     {required String destId,
//   //     String? currentUserId,
//   //     String? destEmail,
//   //     required chatId,
//   //     required destName,
//   //     required msgContent,
//   //     required}) async {
//   //   var snapshots = await devicesRef.doc(destEmail.toString()).get();
//   //   if (snapshots.exists) {
//   //     List<String> tokenList = [];
//   //     Map<String, dynamic> data = snapshots.data() as Map<String, dynamic>;
//   //     if (data.containsKey('token')) {
//   //       log("tokens snapshot dest id $destId $destEmail  " +
//   //           data['token'].toString());
//   //       String token = data['token'];
//   //       tokenList.add(token);
//   //       String? currentDeviceToken = await getTokenFcm();
//   //       if (token.toLowerCase() ==
//   //           currentDeviceToken.toString().toLowerCase()) {
//   //         tokenList = [];
//   //       }
//   //       log("mes tokens " + token.toString());
//   //       log("mes tokens 2 " + currentDeviceToken.toString());
//   //       if (tokenList.isNotEmpty)
//   //         fcmSend(
//   //                 fcmTokens: tokenList,
//   //                 chatId: chatId,
//   //                 destName: destName,
//   //                 msgContent: msgContent)
//   //             .then((value) {
//   //           log("value fcmSend " + value.toString());
//   //         });
//   //     }
//   //   }
//   // }

//   // Fin FCM functions

//   // des notifs par intervalles de temps future functions
//   // static void showScheduledNotification(
//   //     {int id = 0,
//   //     String? title,
//   //     String? body,
//   //     String? payload,
//   //     required DateTime scheduledDate}) async {
//   //   tz.initializeTimeZones();
//   //   /* var timeZoneName = "Africa/Dakar";
//   //   tz.setLocalLocation(tz.getLocation(timeZoneName));
//   //   tz.setLocalLocation(tz.getLocation(timeZoneName)); */

//   //   final locationName = await FlutterNativeTimezone.getLocalTimezone();
//   //   tz.setLocalLocation(tz.getLocation(locationName));

//   //   log(locationName.toString());
//   //   return _notifications.zonedSchedule(
//   //       id,
//   //       title,
//   //       body,
//   //       //tz.TZDateTime.from(scheduledDate, tz.local),
//   //       _scheduleDaily(Time(0, 0, 30)),
//   //       _notificationDetails(),
//   //       uiLocalNotificationDateInterpretation:
//   //           UILocalNotificationDateInterpretation.absoluteTime,
//   //       matchDateTimeComponents: DateTimeComponents.time,
//   //       androidAllowWhileIdle: true);
//   // }

//   // static tz.TZDateTime _scheduleDaily(Time time) {
//   //   final now = tz.TZDateTime.now(tz.local);
//   //   final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
//   //       time.hour, time.minute, time.second);

//   //   log(scheduledDate.toString());

//   //   return scheduledDate.isBefore(now)
//   //       ? scheduledDate.add(Duration(seconds: 12))
//   //       : scheduledDate;
//   // }
// }

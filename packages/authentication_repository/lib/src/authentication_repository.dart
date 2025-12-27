import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  failure,
}

class AuthenticationRepository {
  final String loginUrl;
  final String registrationUrl;
  final String logoutUrl;
  final UserRepository userRepository;
  AuthenticationRepository(
      {required this.loginUrl,
      required this.registrationUrl,
      required this.logoutUrl,
      required this.userRepository});
  final _controller = StreamController<AuthenticationStatus>();
  String? currentErrorMessage;

  call() {}

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future logIn(data) async {
    currentErrorMessage = "";
    _controller.add(AuthenticationStatus.authenticated);
    _controller.add(AuthenticationStatus.unauthenticated);
    var loginUri = Uri.parse(loginUrl);
    if (kDebugMode) {
      print("LOG IN $loginUri");
    }

    try {
      var loginResponse = await http.post(loginUri,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));

      if (kDebugMode) {
        print('Response status: ${loginResponse.statusCode}');
        print('Response body: ${loginResponse.body}');
      }

      // ❌ Erreur : Redirection ou HTML au lieu de JSON
      if (loginResponse.statusCode == 302 ||
          loginResponse.statusCode == 301 ||
          loginResponse.body.trim().startsWith('<!DOCTYPE') ||
          loginResponse.body.trim().startsWith('<html')) {
        _controller.add(AuthenticationStatus.failure);
        print('❌ Erreur: L\'API retourne une redirection ou du HTML');
        print('⚠️ Vérifiez l\'URL de l\'endpoint: $loginUri');
        return {
          "status": 0,
          "errors":
              "L'endpoint de connexion est incorrect. Contactez l'administrateur."
        };
      }

      // Essayer de parser le JSON
      Map<String, dynamic> responseBody;
      try {
        responseBody = jsonDecode(loginResponse.body) as Map<String, dynamic>;
      } catch (e) {
        _controller.add(AuthenticationStatus.failure);
        print('❌ Erreur de parsing JSON: $e');
        return {"status": 0, "errors": "Réponse invalide du serveur"};
      }

      // ✅ Succès : réponse contient "data"
      if (responseBody.containsKey("data") && responseBody['data'] != null) {
        Map<String, dynamic> userData = responseBody["data"];
        print("DATA REGIST $userData");
        await userRepository.saveUser(userData);
        _controller.add(AuthenticationStatus.authenticated);
        return {
          "status": 1,
          "data": userData,
        };
      }

      // ❌ Erreur : réponse contient "errors"
      else if (responseBody.containsKey("errors") &&
          responseBody['errors'] != null) {
        _controller.add(AuthenticationStatus.failure);
        String? message = responseBody["errors"];
        print('Response ERRORS: ${message}');
        return {"status": 0, "errors": message};
      }

      // ❌ Erreur : réponse contient "message" (nouveau format d'erreur)
      else if (responseBody.containsKey("message")) {
        _controller.add(AuthenticationStatus.failure);
        String? message = responseBody["message"];
        print('Response MESSAGE ERROR: ${message}');
        return {"status": 0, "errors": message ?? "Erreur de connexion"};
      }

      // ❌ Erreur : format de réponse inconnu
      else {
        _controller.add(AuthenticationStatus.failure);
        print('Response UNKNOWN FORMAT: ${responseBody}');
        return {"status": 0, "errors": "Format de réponse invalide"};
      }
    } catch (e) {
      // ❌ Erreur générale (réseau, etc.)
      _controller.add(AuthenticationStatus.failure);
      print('❌ Erreur lors de la connexion: $e');
      return {"status": 0, "errors": "Erreur de connexion: $e"};
    }
  }

  Future register({required Object requestBody}) async {
    var registrationUri = Uri.parse(registrationUrl);
    if (kDebugMode) {
      print("Register IN $registrationUri");
    }
    try {
      var requestResponse = await http.post(registrationUri, body: requestBody);
      if (kDebugMode) {
        print('Response status: ${requestBody}');
        print('Response status: ${requestResponse.statusCode}');
        print('Response body: ${requestResponse.body}');
      }
      if (requestResponse.body.isNotEmpty &&
          requestResponse.statusCode == 201) {
        Map<String, dynamic> responseJsonDecoded =
            jsonDecode(requestResponse.body);
        Map<String, dynamic> data = responseJsonDecoded["data"];
        return {
          "status": 1,
          "data": requestResponse.body,
        };
      } else {
        _controller.add(AuthenticationStatus.failure);
        print('Response body: ${requestResponse.body}');
        Map<String, dynamic> responseJsonDecoded =
            jsonDecode(requestResponse.body);
        Map<String, dynamic> errors = responseJsonDecoded["message"] ?? {};
        print('Response ERRORS: ${errors}');
        return {"status": 0, "errors": errors};
      }
    } catch (e, stacktrace) {
      print("CATCH ERROR $e $stacktrace");
      return {
        "status": 0,
        "errors": {"global": "Une erreur s'est produite"}
      };
    }
  }

  Future logOut() async {
    if (kDebugMode) {
      print("LOG USER OUT ");
    }
    try {
      var logoutUri = Uri.parse(logoutUrl);
      if (kDebugMode) {
        print(' logoutUrl: ${logoutUrl}');
      }
      Map<String, String> headers = {};
      headers.addAll(
          {"Accept": "application/json", "Content-Type": "application/json"});
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        headers.addAll({"Authorization": "Bearer $token"});
      }
      // var logoutResponse = await http.post(logoutUri, headers: headers);
      // if (kDebugMode) {
      //   print('Response status: ${logoutResponse.statusCode}');
      //   print('Response body: ${logoutResponse.body}');
      // }
      await prefs.remove("token");
      await prefs.remove("nom_complet");
      await prefs.remove("userinfos");
      _controller.add(AuthenticationStatus.unauthenticated);
      return;
    } catch (e) {
      if (kDebugMode) {
        print("AUTHENTICATION REPOSITORY ERROR $e");
      }
      currentErrorMessage = "Une erreur s'est produite";
      // _controller.add(AuthenticationStatus.failure);
      return;
    }
  }

  void checkPersistentUser() async {
    if (kDebugMode) {
      print("CHECK PERSISTENT USER");
    }
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      String? username = prefs.getString("nom_complet");
      if (token != null && username != null) {
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      if (kDebugMode) {
        print("AUTHENTICATION REPOSITORY ERROR $e");
      }
    }
  }

  void dispose() => _controller.close();
}

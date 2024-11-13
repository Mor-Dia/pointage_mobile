import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, failure, }

class AuthenticationRepository {
  final String loginUrl;
  final String registrationUrl;
  final String logoutUrl;
  final UserRepository userRepository;
  AuthenticationRepository({required this.loginUrl, required this.registrationUrl, required this.logoutUrl, required this.userRepository});
  final _controller = StreamController<AuthenticationStatus>();
  String? currentErrorMessage;

  call(){

  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future logIn({
    required String email,
    required String password,
  }) async {
    currentErrorMessage = "";
    _controller.add(AuthenticationStatus.authenticated);
    _controller.add(AuthenticationStatus.unauthenticated);
    var loginUri = Uri.parse(loginUrl);
    if (kDebugMode) {
      print("LOG IN $loginUri");
    }
    // headers: {"Content-Type": "application/json"},

    var loginResponse = await http.post(loginUri, headers: { "Accept": "application/json", "Content-Type": "application/json"}, body: jsonEncode(
        {
          "email": email,
          "password": password,
        }));
    if (kDebugMode) {
      print('Response status: ${email} and ${password}');
      print('Response status: ${loginResponse.statusCode}');
      print('Response body: ${loginResponse.body}');
    }
    if(loginResponse.body.isNotEmpty && loginResponse.statusCode == 200 ){
      Map<String, dynamic> responseJsonDecoded = jsonDecode(loginResponse.body);
      Map<String, dynamic> userData = responseJsonDecoded["data"];
      print("DATA REGUST $userData");
      String? token = userData["token"];
      String? userName = userData["user"]['name'];
      await userRepository.saveUser(userName, token);
      _controller.add(AuthenticationStatus.authenticated);
      return {
        "status": 1,
        "data": userData,
      };
    } else {
      _controller.add(AuthenticationStatus.failure);
      Map<String, dynamic> responseJsonDecoded = jsonDecode(loginResponse.body);
      String? message = responseJsonDecoded["message"];
      print('Response ERRORS: ${message}');
      return {
        "status": 0,
        "errors": message
      };
    }
  }

  Future register({required Object requestBody}) async {
    var registrationUri = Uri.parse(registrationUrl);
    if (kDebugMode) {
      print("Register IN $registrationUri");
    }
    try{
      var requestResponse = await http.post(registrationUri, body: requestBody);
      if (kDebugMode) {
        print('Response status: ${requestBody}');
        print('Response status: ${requestResponse.statusCode}');
        print('Response body: ${requestResponse.body}');
      }
      if(requestResponse.body.isNotEmpty && requestResponse.statusCode == 201 ){
        Map<String, dynamic> responseJsonDecoded = jsonDecode(requestResponse.body);
        Map<String, dynamic> data = responseJsonDecoded["data"];
        return {
          "status": 1,
          "data": requestResponse.body,
        };
      } else {
        _controller.add(AuthenticationStatus.failure);
        print('Response body: ${requestResponse.body}');
        Map<String, dynamic> responseJsonDecoded = jsonDecode(requestResponse.body);
        Map<String, dynamic> errors = responseJsonDecoded["message"]??{};
        print('Response ERRORS: ${errors}');
        return {
          "status": 0,
          "errors": errors
        };

      }
    } catch(e, stacktrace){
      print("CATCH ERROR $e $stacktrace");
      return {
        "status": 0,
        "errors": {
          "global": "Une erreur s'est produite"
        }
      };
    }
  }

  Future logOut() async {
    if(kDebugMode){
      print("LOG USER OUT ");
    }
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      await prefs.remove("username");
      _controller.add(AuthenticationStatus.unauthenticated);
      return ;
    } catch(e) {
      if(kDebugMode){
        print("AUTHENTICATION REPOSITORY ERROR $e");
      }
      currentErrorMessage = "Une erreur s'est produite";
      _controller.add(AuthenticationStatus.failure);
    }
  }

  void checkPersistentUser() async {
    if(kDebugMode){
      print("CHECK PERSISTENT USER");
    }
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      String? username = prefs.getString("username");
      if(token != null && username != null){
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } catch(e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      if(kDebugMode){
        print("AUTHENTICATION REPOSITORY ERROR $e");
      }
    }
  }

  void dispose() => _controller.close();
}

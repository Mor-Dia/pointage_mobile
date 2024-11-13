import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserChangeStatus { none, userchanged,}


class UserRepository<T> {
  final Function(dynamic value) factoryFunction;
  UserRepository({required this.factoryFunction});

  T? _user;
  final _controller = StreamController<UserChangeStatus>();

  call(){
    if (kDebugMode) {
      print("USER CALL");
    }
  }

  Stream<UserChangeStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield UserChangeStatus.none;
    yield* _controller.stream;
  }

  Future<T?> getUser() async {
    if (kDebugMode) {
      print("TRYING TO GET USER");
    }
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      String? token = prefs.getString('token');
      if (kDebugMode) {
        print('PREFERENCES TOKEN FROM GET USER: ${prefs.getString("token")}');
        print('PREFERENCES USERNAME FROM GET USER: ${prefs.getString("username")}');
      }
      if(username != null && token != null){
        Map<String, dynamic> tempMap = {
          "username": username,
          "token": token,
        };
        _user = factoryFunction(tempMap);
        if (kDebugMode) {
          print('CURRENT USERNAME FROM GET USER: $_user');
        }
      } else {
        _user = null;
      }
    } catch(e) {}
    return _user;
  }

  Future<bool> saveUser(String? userName, String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', userName??"");
    await prefs.setString('token', token??"");
    if (kDebugMode) {
      print('PREFERENCES TOKEN: ${prefs.getString("token")}');
      print('PREFERENCES USERNAME: ${prefs.getString("username")}');
    }
    return true;
  }

  void dispose() => _controller.close();

}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserChangeStatus {
  none,
  userchanged,
}

class UserRepository<T> {
  final Function(dynamic value) factoryFunction;
  UserRepository({required this.factoryFunction});

  T? _user;
  final _controller = StreamController<UserChangeStatus>();

  void call() {
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
      // print("TRYING TO GET USER");
    }
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('nom_complet');
      String? token = prefs.getString('token');
      String? userInfo = prefs.getString('userinfos');
      if (kDebugMode) {
        // print('PREFERENCES TOKEN FROM GET USER: ${prefs.getString("userinfos")}');
        // print('PREFERENCES TOKEN FROM GET USER: ${prefs.getString("token")}');
        print(
            'PREFERENCES USERNAME FROM GET USER: ${prefs.getString("nom_complet")}');
      }
      if (userInfo != null) {
        Map<String, dynamic> decoded = jsonDecode(userInfo);

        // Extraire les données utilisateur depuis la clé "data" si elle existe
        Map<String, dynamic> userData =
            decoded.containsKey('data') ? decoded['data'] : decoded;

        // Ajouter le token au niveau des données utilisateur pour faciliter l'accès
        if (decoded.containsKey('token') && !userData.containsKey('token')) {
          userData['token'] = decoded['token'];
        }

        // Créer nom_complet depuis name si non présent
        if (!userData.containsKey('nom_complet') &&
            userData.containsKey('name')) {
          userData['nom_complet'] = userData['name'];
        }

        _user = factoryFunction(userData);
        if (kDebugMode) {
          print('CURRENT USERNAME FROM GET USER: $_user');
        }
      } else {
        _user = null;
      }
    } catch (e) {}
    return _user;
  }

  Future<bool> saveUser(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (dynamic key in data.keys) {
      dynamic value = data[key];
      dynamic keyType = value.runtimeType;
      print("KEY RUNTIMETYPE $keyType");
      switch (keyType) {
        case String:
          await prefs.setString(key, value);
          break;
        case int:
          await prefs.setInt(key, value);
          break;
        case bool:
          await prefs.setBool(key, value);
          break;
        case double:
          await prefs.setDouble(key, value);
          break;
      }
    }
    String encodedData = jsonEncode(data);
    await prefs.setString("userinfos", encodedData);
    if (kDebugMode) {
      print('PREFERENCES TOKEN: ${prefs.getString("userinfos")}');
      print('PREFERENCES TOKEN: ${prefs.getString("token")}');
      print('PREFERENCES USERNAME: ${prefs.getString("nom_complet")}');
    }
    return true;
  }

  void dispose() => _controller.close();
}

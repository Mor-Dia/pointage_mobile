import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

const Color primaryColor = const Color(0xff15274D);
const Color greyColor = const Color(0xffD9D9D9);
const Color greyColorL = const Color(0xffF1F1F1);
const Color secondColor = const Color(0xffA8923B);

const Color successColor = Color(0xff37BC9B);
const Color dangerColor = Color(0xffDA4453);
const Color warningColor = Color(0xffF6BB42);

Color getDisplayColor(className) {
  switch (className) {
    case "success":
      return successColor;
    case "danger":
      return dangerColor;
    case "warning":
      return warningColor;
    default:
      return successColor;
  }
}

const padding_constant = 20.0;
const REGISTRATION_ENDPOINT = "inscription";
const LOGIN_ENDPOINT = "connexion";
const LOGOUT_ENDPOINT = "deconnexion";
const REQUEST_PWD_ENDPOINT = "password-reset";
const BASE_URL = 'https://yogi-vida.com/yogivida_back_test/';
const BASE_URL_QGL = '${BASE_URL}graphql?query=';

class UserClass {
  final dynamic data;
  final dynamic errors;
  final dynamic success;

  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      data: json['data'] ?? '',
      success: json['success'] ?? '',
      errors: json['errors'] ?? '',
    );
  }

  UserClass({required this.data, required this.errors, required this.success});
}

final List<Item> items = [Item(id: 1, nom: 'Homme'), Item(id: 2, nom: 'Femme')];

class Item {
  final int id;
  final String nom;

  Item({required this.id, required this.nom});
}

FirebaseAuth auth = FirebaseAuth.instance;

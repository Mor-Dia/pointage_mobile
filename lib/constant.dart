import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

const Color primaryColor = const Color(0xff15274D);
const Color greyColor = const Color(0xffD9D9D9);
const Color greyColorL = const Color(0xffF1F1F1);
const Color secondColor = const Color(0xffA8923B);

const padding_constant = 20.0;
const REGISTRATION_ENDPOINT = "inscription";
const LOGIN_ENDPOINT = "connexion";
const LOGOUT_ENDPOINT = "deconnexion";
// const BASE_URL = 'https://yogi-vida.com/yogivida_back_test/';
const BASE_URL = 'http://localhost/yogivida_back/public/';
const BASE_URL_QGL = '${BASE_URL}graphql?query=';

class Activite {
  final String nomActivite;
  final String nomProf;
  final String heure;
  final int color;

  Activite(this.nomActivite, this.nomProf, this.heure, this.color);
}

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

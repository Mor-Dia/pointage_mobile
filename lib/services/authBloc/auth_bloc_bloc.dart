import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

Future<void> storeUserData(dynamic data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_token', data["token"]); // Stocke le token
  await prefs.setString('user_id', data["id"].toString()); // Stocke le token
}

Future<dynamic> refreshConnexion(Emitter<AuthBlocState> emit) async {
  final prefs = await SharedPreferences.getInstance();
  String? currentUser = prefs.getString('user_id'); // Récupère le token,

  if (currentUser != null) {
    final url = Uri.parse(BASE_URL_QGL +
        '{clientspaginated(page:1,count:1,id:' +
        currentUser +
        '){metadata{total,per_page,current_page,last_page},data{id,nom_complet, token,email,image,telephone,etat,type_personne_id,type_personne{id,nom},nb_souscription,nb_vente,nb_reservation,ca_souscription,ca_vente,ca_bon,created_at_fr,current_credit}}}');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    try {
      // Vérification si la requête a réussi (statut 200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parsing des données JSON reçues
        final responseData = jsonDecode(response.body);

        UserClass user = UserClass.fromJson({
          'data': responseData['data']['clientspaginated']['data'][0]
        }); // Conversion du Map en User
        emit(AuthBlocInitial(user: user));
      } else {
        print('Erreur lors de la connexion: ${response.statusCode}');
      }
    } catch (error) {
      print('Erreur réseau ou autre: $error');
    }
  }
}

Future<dynamic> loginUser(
    Map<String, dynamic>? data, Emitter<AuthBlocState> emit) async {
  try {
    final url = Uri.parse(BASE_URL + 'connexion');
    // Requête POST avec le corps de la requête encodé en JSON
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    // Vérification si la requête a réussi (statut 200-299)
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Parsing des données JSON reçues
      final responseData = await jsonDecode(response.body);
      UserClass user =
          UserClass.fromJson(responseData); // Conversion du Map en User
      emit(AuthBlocInitial(user: user));

      if (user.data != '') {
        await storeUserData(user.data);
        await refreshConnexion(emit);
      }
    } else {
      print('Erreur lors de la connexion: ${response.statusCode}');
    }
  } catch (error) {
    print('Erreur réseau ou autre: $error');
  }
}

Future<dynamic> updateUser(
    Map<String, dynamic>? data, Emitter<AuthBlocState> emit) async {
  print(data);
  try {
    final url = Uri.parse(BASE_URL + 'update-user');
    // Requête POST avec le corps de la requête encodé en JSON
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    // Vérification si la requête a réussi (statut 200-299)
    if (response.statusCode >= 200 && response.statusCode <= 302) {
      await refreshConnexion(emit);
    } else {
      print('Erreur lors de la connexion: ${response.statusCode}');
    }
  } catch (error) {
    print('Erreur réseau ou autre: $error');
  }
}

Future<dynamic> signUpUser(
    Map<String, dynamic> data, Emitter<AuthBlocState> emit) async {
  final url = Uri.parse(BASE_URL + 'inscription');

  try {
    // Requête POST avec le corps de la requête encodé en JSON
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    // Vérification si la requête a réussi (statut 200-299)
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Parsing des données JSON reçues
      final responseData = jsonDecode(response.body);
      UserClass user =
          UserClass.fromJson(responseData); // Conversion du Map en User
      emit(AuthBlocInitial(user: user));

      if (user.data != '') {
        storeUserData(user.data["token"]);
      }
    } else {
      print('Erreur lors de la connexion: ${response.statusCode}');
    }
  } catch (error) {
    print('Erreur réseau ou autre: $error');
  }
}

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocInitial(user: null)) {
    on<AppStartedEvent>((event, emit) async {
      emit(AuthBlocLoading());
      await refreshConnexion(emit);
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthBlocLoading());
      await loginUser(event.data, emit);
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(AuthBlocLoading());
      await updateUser(event.data, emit);
      await refreshConnexion(emit);
    });

    on<SignUpEvent>((event, emit) async {
      Map<String, dynamic> data = {
        "login": event.emailController,
        "password": event.passwordController
      };
      await loginUser(data, emit);
      // fetchData();
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Compte/MonCompte.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:yogivida_mobile/services/authBloc/auth_bloc_bloc.dart';

import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  List<TextEditingController> _controllers = [];
  final TextEditingController controlerConfirmationPassword =
      TextEditingController();
  List<Map<String, dynamic>>? inputFields;
  Item? selectedGender;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    inputFields = [
      {
        'type': 'text',
        'text': 'Nom complet',
        'icon': 'user',
        'controller': null,
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Email',
        'icon': 'mail',
        'controller': null,
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Numéro de téléphone',
        'icon': 'phone',
        'controller': null,
        'error': ''
      },
      {
        'type': 'select',
        'text': 'Genre',
        'icon': '',
        'controller': null,
        'selectedValue': selectedGender,
        'items': items,
        'error': ''
      },
      {
        'type': 'password',
        'text': 'Mot de passe',
        'icon': '',
        'controller': null,
        'error': ''
      },
      {
        'type': 'password',
        'text': 'Confirmer le mot de passe',
        'icon': '',
        'controller': null,
        'error': ''
      }
    ];

    for (int i = 0; i < inputFields!.length; i++) {
      _controllers.add(TextEditingController());

      setState(() {
        inputFields![i]['controller'] = _controllers[i];
      });
    }
  }

  List keys = ['nom_complet', 'email', 'telephone', 'type_personne'];

  bool isUpdating = false;
  bool changePasswordEnable = false;
  String changePasswordError = '';

  void selectGenre(Item value) {
    setState(() {
      isUpdating = true;
      selectedGender = value;
      for (int i = 0; i < keys.length; i++) {
        if (inputFields?[i]['type'] != 'password') {
          if (inputFields?[i]['type'] == 'select') {
            inputFields?[i]['selectedValue'] = selectedGender;
          }
        }
      }
    });
  }

  void dispose() {
    // Ne pas oublier de nettoyer le contrôleur lorsque le widget est supprimé
    for (var i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  Future<dynamic> changePassword(Map<String, dynamic>? data) async {
    setState(() {
      isLoading = true;
    });

    if (data?['password'] == '') {
      setState(() {
        changePasswordError = 'Ce champ est requis !';
      });
    } else {
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
          if (responseData['errors'] == null) {
            setState(() {
              changePasswordEnable = true;
              changePasswordError = '';
            });
          } else {
            setState(() {
              changePasswordError = 'Mot de passe invalide !';
            });
          }
        } else {
          print('Erreur lors de la connexion: ${response.statusCode}');
        }
      } catch (error) {
        print('Erreur réseau ou autre: $error');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? currentUser = prefs.getString('user_id'); // Récupère le token,
    List keys = [
      'nom_complet',
      'email',
      'telephone',
      'genre',
      'password',
      'confirmpassword'
    ];

    Map<String, dynamic> data = {
      'id': currentUser,
      'image': null,
      'nom_complet': null,
      'telephone': null,
      'email': null,
      'password': null,
      'confirmpassword': null,
      'genre': null
    }; // Crée un Map vide
    dynamic value;
    var controller;
    var selectedItem;

    for (int i = 0; i < keys.length; i++) {
      String key = keys[i].toString().toLowerCase();

      controller = inputFields![i]['controller'];
      value = controller != null ? controller.text : '';

      if (inputFields![i]['type'] == 'select') {
        selectedItem = inputFields![i]['selectedValue'] as Item;
        value = selectedItem.id;
      }

      data[key] = value; // Ajoute la paire clé-valeur à la Map
    }
    // context.read<AuthenticationBloc<Utilisateur>>().add(UpdateUserEvent(data: data));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
      BlocBuilder<AuthenticationBloc<Utilisateur>, AuthenticationState<Utilisateur>>(
      builder: (context, state) {
        // if (state is AuthBlocInitial) {
        //   // print(state.user?.data);
        //   for (int i = 0; i < keys.length; i++) {
        //     if (isUpdating == false) {
        //       if (inputFields?[i]['type'] != 'password') {
        //         if (inputFields?[i]['type'] == 'select') {
        //           selectedGender = items[state.user?.data[keys[i]]['id'] - 1];
        //           inputFields?[i]['selectedValue'] = selectedGender;
        //         } else {
        //           _controllers[i].text = state.user?.data[keys[i]] ?? '';
        //           inputFields?[i]['controller'] = _controllers[i];
        //         }
        //       }
        //     }
        //   }
        // }
        // if (state is UpdateUserSucces) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     Navigator.pop(context);
        //   });
        // }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xffffffff),
            elevation: 0,
            leading: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: greyColorL, borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/back.svg'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Modifier votre compte',
                  style: GoogleFonts.arimo(
                    color: primaryColor,
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: spacingConstant),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Centrer verticalement
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Aligner à gauche
                        children: [
                          const SizedBox(
                              height:
                                  spacingConstant), // Espacement pour centrer verticalement
                          Column(
                              children: inputFields!.map((field) {
                            return field['type'] != "password"
                                ? Column(
                                    children: [
                                      Inputfiled(
                                        type: field['type'],
                                        text: field['text'],
                                        icon: field['icon'],
                                        controller: field['controller'],
                                        selectedValue: field['selectedValue'],
                                        items: field['items'],
                                        handleAction: (value) =>
                                            selectGenre(value!),
                                        error: field[
                                            'error'], // L'erreur est vide au départ
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  )
                                : SizedBox.shrink();
                          }).toList()),
                          Center(
                            child: Text(
                              'Modifier votre mot de passe',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Inputfiled(
                                  type: 'password',
                                  text: "Entrez l'ancien mot de passe",
                                  icon: '',
                                  error: changePasswordError,
                                  controller: controlerConfirmationPassword,
                                ),
                              ),
                              const SizedBox(width: 10),
                              IntrinsicWidth(
                                  child: ElevatedButton(
                                    onPressed: (){},
                                // onPressed: () => !changePasswordEnable
                                //     ? changePassword({
                                //         "login": (state as AuthBlocInitial)
                                //                 .user
                                //                 ?.data['email'] ??
                                //             "",
                                //         "password":
                                //             controlerConfirmationPassword
                                //                     .text ??
                                //                 ""
                                //       })
                                //     : null,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: const Color(0xff15274d),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Valide',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    isLoading ?? isLoading == true
                                        ? Container(
                                            height: 10,
                                            width: 10,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              )),
                            ],
                          ),

                          const SizedBox(height: 30),
                          Column(
                              children: inputFields!.map((field) {
                            return field['type'] == "password"
                                ? Column(
                                    children: [
                                      Inputfiled(
                                        type: field['type'],
                                        text: field['text'],
                                        icon: field['icon'],
                                        enable: changePasswordEnable,
                                        controller: field['controller'],
                                        error: field[
                                            'error'], // L'erreur est vide au départ
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  )
                                : SizedBox.shrink();
                          }).toList()),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 30),
                    ButtonFiled(
                      text: "Enregistrer",
                      handlerPress: () => {updateProfile()},
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

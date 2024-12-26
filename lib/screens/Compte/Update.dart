import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
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

import '../../components/animated_gesture_detector.dart';
import '../../components/please_login_widget.dart';
import '../../services/post_api_bloc.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late PostApiBloc updateUserPostBloc;
  List<TextEditingController> _controllers = [];
  String? currentError;
  int? currentUserId;
  final TextEditingController controlerConfirmationPassword =
      TextEditingController();
  List<Map<String, dynamic>> inputFields = [];
  Item? selectedGender;
  final List<Item> items = [
    Item(id: 1, nom: 'Homme'),
    Item(id: 2, nom: 'Femme')
  ];
  bool isLoading = false;
  List keys = ['nom_complet', 'email', 'telephone', 'type_personne'];
  bool isUpdating = false;
  bool changePasswordEnable = false;
  String changePasswordError = '';

  @override
  void initState() {
    super.initState();
    updateUserPostBloc = PostApiBloc();
    fillFields();
  }

  fillFields(){
    inputFields = [
      {
        'type': 'text',
        'text': 'Nom ',
        'icon': 'user',
        'tag': 'nom',
        // 'controller': null,
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Prénom',
        'icon': 'user',
        'tag': 'prenom',
        // 'controller': null,
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Email',
        'icon': 'mail',
        'tag': 'email',
        'controller': null,
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Numéro de téléphone',
        'icon': 'phone',
        'tag': 'phone',
        'controller': null,
        'error': ''
      },
      {
        'type': 'select',
        'text': 'Genre',
        'icon': '',
        'tag': 'genre',
        'controller': null,
        'selectedValue': selectedGender,
        'items': items,
        'error': ''
      },
      {
        'type': 'password',
        'text': 'Mot de passe',
        'icon': '',
        'tag': 'password',
        'controller': null,
        'error': ''
      },
      {
        'type': 'password',
        'text': 'Confirmer le mot de passe',
        'icon': '',
        'tag': 'confirmpassword',
        'controller': null,
        'error': ''
      }
    ];
    AuthenticationBloc currentAuthBloc = BlocProvider.of<AuthenticationBloc<Utilisateur>>(context);
    AuthenticationStatus currentStatus = currentAuthBloc.state.status;

    switch (currentStatus) {
      case AuthenticationStatus.unknown:
      case AuthenticationStatus.unauthenticated:
      case AuthenticationStatus.failure:
        break;
      case AuthenticationStatus.authenticated:
        Utilisateur currentUser = currentAuthBloc.state.user;
        currentUserId = currentUser.id;
        Map currentUserJson = currentUser.toJson();
        for (int i = 0; i < inputFields!.length; i++) {
          String tag = inputFields?[i]['tag'];
          _controllers.add(TextEditingController(text: currentUserJson[tag]));
          if (inputFields?[i]['type'] == "text" ||
              inputFields?[i]['type'] == "password") {
            setState(() {
              inputFields![i]['controller'] = _controllers[i];
            });
          }
        }
    }
  }

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
    setState(() {
      isLoading = false;
      currentError = null;
    });
    Map<String, dynamic> postData = {
      "id": currentUserId,
      "nom": null,
      "prenom": null,
      "email": null,
      "phone": null,
      "password": null,
      "confirmpassword": null,
      "genre": null,
    };

    if(inputFields.isNotEmpty){
      for(String key in postData.keys){
        print("HOLD $inputFields");
        dynamic currentField = inputFields.firstWhere((element) {
          if(element['tag'] != null){
            return element['tag'] == key;
          }
          return false;
        },  orElse: () => {}, );
        print("CurrentField $currentField");
        TextEditingController? currentController = currentField['controller'];
        if(currentController != null){
          postData[key] = currentController.text;
        } else {
          postData['genre'] = selectedGender?.id.toString();
        }
      }
    }
    updateUserPostBloc.add(PostApiMakeCall(endpoint: 'update-user', parameters: postData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc<Utilisateur>, AuthenticationState<Utilisateur>>(
      builder: (context, authState) {
        AuthenticationStatus currentStatus = authState.status;
        switch (currentStatus) {
          case AuthenticationStatus.unknown:
          case AuthenticationStatus.unauthenticated:
          case AuthenticationStatus.failure:
            return const Center(child: PleaseLoginWidget());
          case AuthenticationStatus.authenticated:
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Visibility(
                        visible: currentError != null,
                        child: Center(
                          child: Text(
                            "$currentError",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                            children: inputFields.map((field) {
                              return Column(
                                children: [
                                  Inputfiled(
                                    type: field['type'],
                                    text: field['text'],
                                    icon: field['icon'],
                                    controller: field['controller'],
                                    selectedValue: selectedGender,
                                    items: field['items'],
                                    handleAction: (value) => selectGenre(value!),
                                    error: field['error'], // L'erreur est vide au départ
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              );
                            }).toList()),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        BlocConsumer(
                          bloc: updateUserPostBloc,
                          listener: (context, state) {
                            if (state is PostApiSuccess) {
                              print("User Update Success ${state.message}");
                            }
                            if (state is PostApiFailure) {
                              print("User Update Failure ${state.message}");
                            }
                            if (state is PostApiProcessing) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            }
                          },
                          builder: (BuildContext context, postBlocState) {
                            return AnimatedGestureButton(
                              animate: postBlocState is PostApiProcessing,
                              child: ButtonFiled(
                                text: "Enregistrer",
                                handlerPress: () => {updateProfile()},
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}

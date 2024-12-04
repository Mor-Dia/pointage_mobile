import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/components/notifier_dialog.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<TextEditingController> _controllers = [];
  String? currentError;
  List<Map<String, dynamic>> inputFields = [];

  Item? selectedGender;

  final List<Item> items = [
    Item(id: 1, nom: 'Homme'),
    Item(id: 2, nom: 'Femme')
  ];

  void selectGenre(Item value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  void initState() {
    super.initState();

    inputFields = [
      {
        'type': 'text',
        'text': 'Nom ',
        'icon': 'user',
        'tag': 'nom',
        'controller': null,
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Prénom',
        'icon': 'user',
        'tag': 'prenom',
        'controller': null,
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

    for (int i = 0; i < inputFields!.length; i++) {
      _controllers.add(TextEditingController());
      if (inputFields?[i]['type'] == "text" ||
          inputFields?[i]['type'] == "password") {
        setState(() {
          inputFields![i]['controller'] = _controllers[i];
        });
      }
    }
  }

  void dispose() {
    // Ne pas oublier de nettoyer le contrôleur lorsque le widget est supprimé
    for (var i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  void signUp() async {
    Map<String, dynamic> postData = {
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
        dynamic currentField = inputFields.firstWhere((element) {
          if(element['tag'] != null){
            return element['tag'] == key;
          }
          return false;
        });
        TextEditingController? currentController = currentField['controller'];
        if(currentController != null){
          postData[key] = currentController.text;
        } else {
          postData['genre'] = selectedGender?.id.toString();
        }
      }
    }
    if (kDebugMode) {
      print("input field $postData");
    }

    var registrationLink = Uri.parse("$BASE_URL$REGISTRATION_ENDPOINT");
    await http.post(registrationLink, body: postData).then((Response response) {
      var responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      var isError = false;
      var message = "";
      if(responseBody.containsKey("errors") && responseBody['errors'] != null){
        message = responseBody['errors'];
        isError = true;
      } else if (responseBody.containsKey("success") && responseBody['success'] != null){
        message = responseBody['success'];
        isError = false;
      }
      showNotifyingDialog(context: context, message: message, isError: isError);
      if (kDebugMode) {
        print("REGISTRATION RESPONSE ${responseBody}");
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(spacingConstant),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Centrer verticalement
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligner à gauche
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/logos/logo.svg',
                            height: 80,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.1), // Espacement pour centrer verticalement

                      Column(
                          children: inputFields!.map((field) {
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
                              error: field[
                                  'error'], // L'erreur est vide au départ
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      }).toList()),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.1), // Espacement en bas pour mieux centrer
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ButtonFiled(
                    text: "S'inscrire",
                    handlerPress: () => {
                      signUp()
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Vous avez déjà un compte ? ',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          )
                        },
                        child: const Text(
                          'Connectez-vous !',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Color(0xff15274d),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
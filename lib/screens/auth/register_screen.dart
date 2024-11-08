import 'package:flutter/material.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<TextEditingController>? _controllers;

  String selectedGender = 'Homme';

  // Liste de champs avec leurs attributs
  List<Map<String, dynamic>>? inputFields;

  @override
  void initState() {
    super.initState();

    inputFields = [
      {
        'type': 'text',
        'text': 'Nom',
        'icon': 'user',
        'controller': _controllers?[0],
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Prénom',
        'icon': 'user',
        'controller': _controllers?[1],
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Email',
        'icon': 'mail',
        'controller': _controllers?[2],
        'error': ''
      },
      {
        'type': 'text',
        'text': 'Numéro de téléphone',
        'icon': 'phone',
        'controller': _controllers?[3],
        'error': ''
      },
      {
        'type': 'select',
        'text': 'Genre',
        'icon': '',
        'controller': null,
        'error': ''
      },
      {
        'type': 'password',
        'text': 'Mot de passe',
        'icon': '',
        'controller': _controllers?[4],
        'error': ''
      },
      {
        'type': 'password',
        'text': 'Confirmer le mot de passe',
        'icon': '',
        'controller': _controllers?[5],
        'error': ''
      }
    ];

    for (int i = 0; i < inputFields!.length; i++) {
      _controllers?.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    Future signUp() async {}

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
              ),
              Column(
                children: [
                  ButtonFiled(
                    text: "S'inscrire",
                    handlerPress: () => {
                      signUp()
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const Mainhome()
                      // ),
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
                                builder: (context) => LoginScreen()),
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

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yogivida_mobile/screens/auth/request_password_screen.dart';
import 'package:yogivida_mobile/services/authBloc/auth_bloc_bloc.dart';

import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String? currentErrorMessage;
  List<TextEditingController> _controllers = [];

  // Liste de champs avec leurs attributs
  List<Map<String, dynamic>>? inputFields;

  @override
  void initState() {
    super.initState();

    inputFields = [
      {
        'type': 'text',
        'text': 'Email',
        'icon': 'mail',
        'controller': null,
        'error': ''
      },
      {
        'type': 'password',
        'text': 'Mot de passe',
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

  void dispose() {
    // Ne pas oublier de nettoyer le contrôleur lorsque le widget est supprimé
    for (var i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  Future login() async {
    setState(() {
      isLoading = false;
    });

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    bool _areFieldsEmpty() {
      var isValid = false;
      for (int i = 0; i < inputFields!.length; i++) {
        setState(() {
          inputFields![i]['error'] = '';
        });

        if (inputFields![i]['text'].toString().toLowerCase() == 'email') {
          if (!regex.hasMatch(_controllers[i].text.trim())) {
            setState(() {
              inputFields![i]['error'] = 'Entrez un email valide!';
            });
          }
        }

        if (_controllers[i].text.isEmpty) {
          setState(() {
            inputFields![i]['error'] = 'Ce champ est requis !';
          });
          isValid = true;
        }
      }
      return isValid;
    }

    bool isFormValid = _areFieldsEmpty();
    isFormValid = true;
    if (kDebugMode) {
      print("DATA TO SUBMIT $isFormValid ");
    }

    if(isFormValid){
      List keys = ['login', 'password'];

      Map<String, dynamic> data = {}; // Crée un Map vide

      for (int i = 0; i < inputFields!.length; i++) {
        String key = keys[i].toString().toLowerCase();
        var controller = inputFields![i]['controller'];

        String value = controller != null ? controller.text : '';

        data[key] = value; // Ajoute la paire clé-valeur à la Map
      }

      if (kDebugMode) {
        print("DATA TO SUBMIT $data ");
      }

      AuthenticationRepository authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context);
      await authenticationRepository.logIn(data).then((value) {
        setState(() {
          isLoading = false;
        });
        if(value['status'] == 0) {
          if (kDebugMode) {
            print("ERRORSSS ${value['errors']}");
          }
          setState(() {
            currentErrorMessage = value['errors']??"";
          });
        } else if(value['status'] == 1) {
          setState(() {
            currentErrorMessage = "";
          });
        } else {
          setState(() {
            currentErrorMessage = "Veuillez réessayer plus tard";
          });
        }
      }).catchError((e, stacktrace) {
        if (kDebugMode) {
          print("ERROOR  RRR $e $stacktrace");
        }
        setState(() {
          isLoading = false;
          currentErrorMessage = "Une erreur est survenue";
        });
      });

      
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthenticationBloc<Utilisateur>, AuthenticationState<Utilisateur>>(
      listener: (context, state) {
        AuthenticationStatus currentStatus = state.status;
        switch(currentStatus){
          case AuthenticationStatus.authenticated:
            if (kDebugMode) {
              print("AUTH STATE AUTHENTICATED ${state.status}");
            }
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => const Mainhome(), ),
                    (route) => false
            );
            break;
          case AuthenticationStatus.unknown:
          case AuthenticationStatus.unauthenticated:
          case AuthenticationStatus.failure:
            if (kDebugMode) {
              print("AUTH STATE NOT AUTHENTICATED ${state.status}");
            }
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centrer verticalement
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

                            const SizedBox(
                                height:
                                    30), // Espacement entre le logo et le texte
                            Text(
                              'Bienvenue !',
                              style: GoogleFonts.alata(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.085,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                              ),
                            ),
                            Text(
                              'Yoga pour le corps, l\'esprit et l\'âme.',
                              style: GoogleFonts.montserrat(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                color: const Color(0xff15274d),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 30),

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
                            Center(
                              child: IntrinsicWidth(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: currentErrorMessage != null && currentErrorMessage != null,
                                          child: const Icon(
                                            Icons.info,
                                            color: Colors.red,
                                            size: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          currentErrorMessage ?? "",
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (BuildContext context) => const RequestPasswordScreen(), ),
                                            (route) => false
                                    );
                                  },
                                  child: Text(
                                    'Mot de passe oublier ?',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.030,
                                      color: const Color(0xff15274d),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                          isLoading: isLoading,
                          text: 'Se connecter',
                          handlerPress: () => {
                            login(),
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Vous n’avez pas de compte ? ',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.030,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                )
                              },
                              child: Text(
                                'Inscrivez-vous !',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.030,
                                  color: const Color(0xff15274d),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}

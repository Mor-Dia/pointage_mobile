import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:yogivida_mobile/services/authBloc/auth_bloc_bloc.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  List<TextEditingController> _controllers = [];

  // Liste de champs avec leurs attributs
  List<Map<String, dynamic>>? inputFields;

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

  String selectedGender = 'Homme';

  @override
  Widget build(BuildContext context) {
    List keys = ['nom_complet', 'email', 'telephone'];

    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        if (state is AuthBlocInitial) {
          print(state.user?.data['nom_complet']);
          for (int i = 0; i < keys.length; i++) {
            if (inputFields?[i]['type'] != 'password') {
              _controllers[i].text = state.user?.data[keys[i]] ?? '';
              inputFields?[i]['controller'] = _controllers[i];
            }
          }
        }
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                  20), // Espacement pour centrer verticalement
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
                            children: [
                              const Expanded(
                                child: Inputfiled(
                                  type: 'password',
                                  text: "Entrez l'ancien mot de passe",
                                  icon: '',
                                  error: '',
                                ),
                              ),
                              const SizedBox(width: 10),
                              IntrinsicWidth(
                                child: ButtonFiled(
                                  text: "Valider",
                                  handlerPress: () => {},
                                ),
                              ),
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
                      handlerPress: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Mainhome()),
                        )
                      },
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

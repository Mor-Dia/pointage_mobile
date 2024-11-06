import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedGender = 'Homme'; // Valeur par défaut pour le genre

  @override
  Widget build(BuildContext context) {
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
                        Inputfiled(
                          type: 'text',
                          text: "Nom d'utilisateur",
                          icon: 'user',
                        ),
                        SizedBox(height: 30),
                        Inputfiled(
                          type: 'text',
                          text: 'Email',
                          icon: 'mail',
                        ),
                        SizedBox(height: 30),
                        Inputfiled(
                          type: 'text',
                          text: 'Numéro de téléphone',
                          icon: 'phone',
                        ),
                        SizedBox(height: 30),
                        Inputfiled(
                          type: 'select',
                          text: 'Genre',
                          icon: '',
                        ),
                        SizedBox(height: 30),
                        Inputfiled(
                          type: 'password',
                          text: 'Mot de passe',
                          icon: '',
                        ),
                        SizedBox(height: 30),
                        Inputfiled(
                          type: 'password',
                          text: 'Confirmer le mote de passe',
                          icon: '',
                        ),

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Mainhome()),
                      )
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
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
                        child: Text(
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

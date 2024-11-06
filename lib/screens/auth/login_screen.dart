import 'package:flutter/material.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/inputFiled.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

                        SizedBox(
                            height: 30), // Espacement entre le logo et le texte
                        Text(
                          'Bienvenue !',
                          style: GoogleFonts.alata(
                            fontSize: MediaQuery.of(context).size.width * 0.085,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          'Yoga pour le corps, l\'esprit et l\'âme.',
                          style: GoogleFonts.montserrat(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: Color(0xff15274d),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 30),
                        Inputfiled(
                          type: 'text',
                          text: 'Email',
                          icon: 'user',
                        ),
                        SizedBox(height: 30),
                        Inputfiled(
                          type: 'password',
                          text: 'Mot de passe',
                          icon: 'user',
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => {print("Mot de passe oublier")},
                              child: Text(
                                'Mot de passe oublier ?',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.030,
                                  color: Color(0xff15274d),
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
              ),
              Column(
                children: [
                  ButtonFiled(
                    text: 'Se connecter',
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
                        'Vous n’avez pas de compte ? ',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.030,
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
                            fontSize: MediaQuery.of(context).size.width * 0.030,
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

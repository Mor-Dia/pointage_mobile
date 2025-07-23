import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';

class PleaseLoginWidget extends StatelessWidget {
  final String? message;
  const PleaseLoginWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        SizedBox.square(
          dimension: 250,
          child: Lottie.asset(
            'assets/animations/pleaselogin.json',
            repeat: false,
            reverse: false,
            animate: true,
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            textAlign: TextAlign.center,
            "Veuillez vous connecter à votre compte ou créer un compte pour continuer.",
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            )
          },
          child: Text(
            'Se connecter !',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.030,
              color: const Color(0xff15274d),
            ),
          ),
        ),
      ],
    );
  }
}

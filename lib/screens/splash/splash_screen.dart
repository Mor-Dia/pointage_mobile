import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:yogivida_mobile/services/authBloc/auth_bloc_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<void> checkUserData(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  String? currentToken = prefs.getString('user_id'); // Récupère le token,

  if (currentToken != null) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Mainhome()),
      (Route<dynamic> route) =>
          false, // Cette fonction indique de retirer toutes les routes
    );
  } else {
    print('Pas d\'utilisateur connecté');
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        if (state is AuthBlocInitial) {
          checkUserData(context);
        }
        return Scaffold(
          body: Container(
            color: primaryColor,
            child: Center(
              child: SvgPicture.asset('assets/images/logos/logo.svg'),
            ),
          ),
        );
      },
    );
  }
}

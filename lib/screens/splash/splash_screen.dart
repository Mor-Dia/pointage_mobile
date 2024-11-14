import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/services/authBloc/auth_bloc_bloc.dart';
import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc<Utilisateur>, AuthenticationState<Utilisateur>>(
      listener: (context, state){
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
          case AuthenticationStatus.unknown:
          case AuthenticationStatus.unauthenticated:
          case AuthenticationStatus.failure:
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => const LoginScreen(), ),
                    (route) => false
            );
        }
      },
      child: Scaffold(
        body: Container(
          color: primaryColor,
          child: Center(
            child: SvgPicture.asset('assets/images/logos/logo.svg'),
          ),
        ),
      ),
    );
  }
}

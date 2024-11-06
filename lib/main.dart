import 'package:flutter/material.dart';
import 'package:yogivida_mobile/screens/Boutique/Boutique.dart';
import 'package:yogivida_mobile/screens/Compte/MonCompte.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:yogivida_mobile/screens/planning/Planning.dart';
import 'package:yogivida_mobile/screens/splash/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'screens/splash/splash_screen.dart';

void main() async {
  // S'assurer que Flutter est initialisé avant d'appeler initializeDateFormatting
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser la locale pour le formatage des dates
  await initializeDateFormatting('fr_FR', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        // primarySwatch: Color(0xff15274d),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/planning': (context) => Planning(),
        '/boutique': (context) => Boutique(),
        '/moncompte': (context) => MonCompte(),
      },
    );
  }
}

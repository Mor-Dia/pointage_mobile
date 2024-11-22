import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:yogivida_mobile/components/ConnectionNotifier.dart';
import 'package:yogivida_mobile/screens/Boutique/Boutique.dart';
import 'package:yogivida_mobile/screens/Compte/Update.dart';
import 'package:yogivida_mobile/screens/Home/pratique_page.dart';
import 'package:yogivida_mobile/screens/splash/splash_screen.dart';
import 'package:yogivida_mobile/services/connection/Connectivity_service.dart'; // Le service de connectivité
import 'package:yogivida_mobile/components/ConnectionNotifier.dart'; // Le ConnectionNotifier
import 'package:yogivida_mobile/services/authBloc/auth_bloc_bloc.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'core/models/user_model.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository<Utilisateur> _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository<Utilisateur>(
        factoryFunction: (json) => Utilisateur.fromJson(json));
    _authenticationRepository = AuthenticationRepository(
        loginUrl: "$BASE_URL$LOGIN_ENDPOINT",
        registrationUrl: "$BASE_URL$LOGIN_ENDPOINT",
        logoutUrl: "$BASE_URL$LOGIN_ENDPOINT",
        userRepository: _userRepository);
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    _userRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => _authenticationRepository,
        ),
        RepositoryProvider<UserRepository<Utilisateur>>(
          create: (context) => _userRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc<Utilisateur>(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          initialRoute: '/',
          routes: {
            // '/': (context) => const PratiquesPage(),
            // '/': (context) => const (),
            // '/': (context) => const MonCompte(),
            // '/': (context) => const Update(),
            // '/': (context) => const Boutique(),
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomePage(),
          },
        ),
      ),
    );
  }
}

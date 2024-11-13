import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Boutique/Boutique.dart';
import 'package:yogivida_mobile/screens/Compte/MonCompte.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/auth/register_screen.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:yogivida_mobile/screens/splash/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yogivida_mobile/services/authBloc/auth_bloc_bloc.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'core/models/user_model.dart';
import 'firebase_options.dart';
// import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  // S'assurer que Flutter est initialisé avant d'appeler initializeDateFormatting
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser la locale pour le formatage des dates
  await initializeDateFormatting('fr_FR', null);

  WidgetsFlutterBinding.ensureInitialized();
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
    _userRepository = UserRepository<Utilisateur>(factoryFunction: (json) => Utilisateur.fromJson(json));
    _authenticationRepository = AuthenticationRepository(loginUrl: "$BASE_URL$LOGIN_ENDPOINT", registrationUrl: "$BASE_URL$LOGIN_ENDPOINT", logoutUrl: "$BASE_URL$LOGIN_ENDPOINT", userRepository: _userRepository);
  }


  @override
  void dispose() {
    _authenticationRepository.dispose();
    _userRepository.dispose();
    super.dispose();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers:  [
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
              // create: (context) => AuthenticationBloc<Utilisateur>()..add(AppStartedEvent(data: null)),

            ),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              // primarySwatch: Color(0xff15274d),
            ),
            initialRoute: '/',
            routes: {
              // '/': (context) => RegisterScreen(),
              '/': (context) => const Mainhome(),
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const HomePage(),
            },
          )
        ),
    );
    //   BlocProvider(
    //   create: (context) => AuthenticationBloc<Utilisateur>()..add(AppStartedEvent(data: null)),
    //   child: MaterialApp(
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blueGrey,
    //       // primarySwatch: Color(0xff15274d),
    //     ),
    //     initialRoute: '/',
    //     routes: {
    //       // '/': (context) => RegisterScreen(),
    //       '/': (context) => SplashScreen(),
    //       '/login': (context) => const LoginScreen(),
    //       '/home': (context) => const HomePage(),
    //     },
    //   ),
    // );
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:yogivida_mobile/components/ConnectionNotifier.dart';
import 'package:yogivida_mobile/screens/Boutique/Boutique.dart';
import 'package:yogivida_mobile/screens/Compte/LocalisationContact.dart';
import 'package:yogivida_mobile/screens/Compte/MonCompte.dart';
import 'package:yogivida_mobile/screens/Compte/reservations_page.dart';
import 'package:yogivida_mobile/screens/Compte/commandes_page.dart';
import 'package:yogivida_mobile/screens/Compte/Update.dart';
import 'package:yogivida_mobile/screens/Home/pratique_page.dart';
import 'package:yogivida_mobile/screens/Planning/Planning.dart';
import 'package:yogivida_mobile/screens/splash/splash_screen.dart';
import 'package:yogivida_mobile/services/connection/Connectivity_service.dart'; // Le service de connectivité
import 'package:yogivida_mobile/components/ConnectionNotifier.dart'; // Le ConnectionNotifier
import 'package:yogivida_mobile/services/authBloc/auth_bloc_bloc.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Home/MainHome.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:yogivida_mobile/services/panierBloc/panier_bloc_bloc.dart';
import 'package:yogivida_mobile/simple_bloc_observer.dart';
import 'core/global.dart';
import 'core/models/user_model.dart';
import 'core/utils/helpers.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging fcm = firebaseMessagingInstance();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = SimpleBlocObserver();
  await fcm.setAutoInitEnabled(true);
  fcm.getToken().then((value) {
    print("FCM TOKEN $value");
  });
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
    // String baseUrl = await Helpers.getBaseUrl();
    _authenticationRepository = AuthenticationRepository(
        loginUrl: "$BASE_URL$LOGIN_ENDPOINT",
        registrationUrl: "$BASE_URL$LOGIN_ENDPOINT",
        logoutUrl: "$BASE_URL$LOGIN_ENDPOINT",
        userRepository: _userRepository);    askForNotificationPermission();
  }
  askForNotificationPermission() async{
    final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
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
          BlocProvider(
            create: (_) =>
                PanierBlocBloc()..add(const PanierBlocEvent.started()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          initialRoute: '/',
          routes: {
            // '/': (context) => const (),
            // '/': (context) => const MonCompte(),
            // '/': (context) => const Update(),
            // '/': (context) => const CommandesPage(),
            // '/': (context) => const Planning(),
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomePage(),
          },
        ),
      ),
    );
  }
}

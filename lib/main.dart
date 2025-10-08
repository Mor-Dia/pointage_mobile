import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/global.dart';
import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/core/utils/helpers.dart';
import 'package:yogivida_mobile/screens/splash/splash_screen.dart';
import 'package:yogivida_mobile/screens/auth/login_screen.dart';
import 'package:yogivida_mobile/screens/Home/home_page.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:yogivida_mobile/services/panierBloc/panier_bloc_bloc.dart';
import 'package:yogivida_mobile/simple_bloc_observer.dart';

import 'package:yogivida_mobile/services/notification_api.dart';

import 'package:app_links/app_links.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print('📬 BG message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  FirebaseMessaging fcm = firebaseMessagingInstance();
  await fcm.setAutoInitEnabled(true);

  Helpers.setFCMTokenToServer();
  NotificationApi.manageTokenFcm();

  Bloc.observer = SimpleBlocObserver();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialisation Awesome Notifications
  await AwesomeNotifications().initialize(
    null, // icône par défaut (null = icône app)
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Notifications importantes',
        channelDescription: 'Notifications importantes de l\'application',
        defaultColor: Colors.teal,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        playSound: true,
        enableVibration: true,
      ),
    ],
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository<Utilisateur> _userRepository;

  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _sub;

  @override
  void initState() {
    super.initState();
    _initDeepLink();

    _userRepository = UserRepository<Utilisateur>(
      factoryFunction: (json) => Utilisateur.fromJson(json),
    );

    _authenticationRepository = AuthenticationRepository(
      loginUrl: "$BASE_URL$LOGIN_ENDPOINT",
      registrationUrl: "$BASE_URL$LOGIN_ENDPOINT",
      logoutUrl: "$BASE_URL$LOGIN_ENDPOINT",
      userRepository: _userRepository,
    );

    _requestNotificationPermission();
  }

  void _initDeepLink() async {
    _appLinks = AppLinks();

    final Uri? initialLink = await _appLinks.getInitialLink();
    if (initialLink != null && initialLink.path == '/app') {
      _navigateToSplash();
    }

    // 🔹 Écoute les liens ouverts pendant que l’app est déjà en cours d’exécution
    _sub = _appLinks.uriLinkStream.listen((Uri uri) {
      print('Lien reçu : $uri');
      if (uri.path == '/app') {
        _navigateToSplash();
      }
    }, onError: (err) {
      print('Erreur deep link: $err');
    });
  }

  void _navigateToSplash() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (route) => false,
    );
  }

  void _requestNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission(provisional: true);
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    _userRepository.dispose();
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => _authenticationRepository),
        RepositoryProvider(create: (_) => _userRepository),
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
          title: 'Yogivida',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blueGrey),
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => const SplashScreen());
              case '/login':
                return MaterialPageRoute(builder: (_) => const LoginScreen());
              case '/home':
                return MaterialPageRoute(builder: (_) => const HomePage());
              default:
                return MaterialPageRoute(builder: (_) => const SplashScreen());
            }
          },
        ),
      ),
    );
  }
}

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pointage_mobile/components/TopDialogNotification.dart';
import 'package:pointage_mobile/components/please_login_widget.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/core/models/user_model.dart';
import 'package:pointage_mobile/services/authentication_bloc/authentication_bloc.dart';

import 'package:pointage_mobile/screens/auth/login_screen.dart';

import '../../components/animated_gesture_detector.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/post_api_bloc.dart';

class MonCompte extends StatefulWidget {
  const MonCompte({super.key});

  @override
  State<MonCompte> createState() => _MonCompteState();
}

class _MonCompteState extends State<MonCompte> with RouteAware {
  late DataBloc<List<Utilisateur>> utilisateurBloc;
  late PostApiBloc accountDeletionPostBloc;

  var currentUserId;

  bool hide = true;

  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  void initState() {
    accountDeletionPostBloc = PostApiBloc();
    utilisateurBloc = DataBloc<List<Utilisateur>>(
        (response) => Utilisateur.fromJsonList(response),
        Utilisateur.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Utilisateur.shrinkedAttributs());
    super.initState();
    _loadUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<AuthenticationBloc<Utilisateur>>()
        .add(AuthenticationUserRefreshed());
  }

  Future<void> _loadUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? currentUserId = prefs.getInt("id");

      if (currentUserId != null) {
        utilisateurBloc.add(RefreshDataEvent(filter: {'id': currentUserId}));
      } else {
        print('Aucun ID utilisateur enregistré');
      }
    } catch (e) {
      print('Erreur lors du chargement de l\'utilisateur: $e');
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadUser(); // 👈 rechargement automatique quand on revient sur la page
  }

  Future logout() async {
    AuthenticationRepository authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    await authenticationRepository.logOut().then((value) {
      if (kDebugMode) {
        print("USER LOGGED OUT");
      }
    }).catchError((e, stacktrace) {
      if (kDebugMode) {
        print("ERROOR WHILE DISCONNECTING USER $e $stacktrace");
      }
    }); // Récupère le token,
  }

  deleteAccount() {
    AuthenticationBloc currentAuthBloc =
        BlocProvider.of<AuthenticationBloc<Utilisateur>>(context);
    AuthenticationStatus currentStatus = currentAuthBloc.state.status;
    switch (currentStatus) {
      case AuthenticationStatus.unknown:
      case AuthenticationStatus.unauthenticated:
      case AuthenticationStatus.failure:
        break;
      case AuthenticationStatus.authenticated:
        Utilisateur currentUser = currentAuthBloc.state.user;
        int? currentUserId = currentUser.id;
        String endpoint = "clientfrontdel/${currentUserId}";
        accountDeletionPostBloc.add(PostApiMakeCall(
            endpoint: endpoint, parameters: {}, isDeletion: true));
    }
  }

  hideAndShowBalance() {
    setState(() {
      hide = !hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      final int? id = prefs.getInt('id');
      final String? currentUserId = id?.toString();

      if (currentUserId != null) {
        this.currentUserId = currentUserId;
        print("Utilisateur ID : $currentUserId");
        // 👉 tu peux maintenant utiliser currentUserId ici
      } else {
        print("Aucun utilisateur enregistré");
      }
    });

    return BlocConsumer<AuthenticationBloc<Utilisateur>,
        AuthenticationState<Utilisateur>>(
      listener: (context, state) {
        AuthenticationStatus currentStatus = state.status;
        switch (currentStatus) {
          case AuthenticationStatus.authenticated:
            break;
          case AuthenticationStatus.unknown:
          case AuthenticationStatus.unauthenticated:
          case AuthenticationStatus.failure:
            if (kDebugMode) {
              print("AUTH STATE NOT AUTHENTICATED ${state.status}");
            }
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginScreen(),
                ),
                (route) => false);
        }
      },
      // builder: (context, state) {
      builder: (context, state) {
        AuthenticationStatus currentStatus = state.status;
        switch (currentStatus) {
          case AuthenticationStatus.authenticated:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xffffffff),
                elevation: 0,
                automaticallyImplyLeading:
                    false, // Empêche l'affichage du bouton back
                toolbarHeight: 60,
                title: Text(
                  'Mon compte',
                  style: GoogleFonts.arimo(
                    color: const Color(0xff15274d),
                    fontSize: titreConstant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: spacingConstant * 2),
                    Center(
                      child: Column(children: [
                        SvgPicture.asset(
                          "assets/icons/user2.svg",
                          width: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          state.user?.nom_complet ?? "Utilisateur",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                    ),
                    const Spacer(), // Pousse le bouton vers le bas
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: spacingConstant * 2),
                      child: GestureDetector(
                        onTap: () => logout(),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: greyColor),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spacingConstant,
                                vertical: spacingConstant * 1.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/off.svg",
                                  color: Colors.red,
                                  width: 24,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  "Déconnexion",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: spacingConstant),
                  ],
                ),
              ),
            );
          case AuthenticationStatus.unknown:
          case AuthenticationStatus.unauthenticated:
          case AuthenticationStatus.failure:
            return const Center(child: PleaseLoginWidget());
        }
      },
    );
  }

  showAccountDeletionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Suppression de votre compte',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.red,
                        fontSize: 20),
                  ),
                  const SizedBox.square(dimension: 20),
                  const Center(
                      child: Text(
                    'Etes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  )),
                  const SizedBox.square(dimension: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocConsumer(
                        bloc: accountDeletionPostBloc,
                        listener: (context, state) {
                          if (state is PostApiSuccess) {
                            Navigator.of(context).pop();
                            TopDialogNotification.show(context,
                                message: "${state.message}", isError: false);
                            Future.delayed(const Duration(seconds: 5), () {
                              logout();
                            });
                          }
                          if (state is PostApiProcessing) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          }
                        },
                        builder: (BuildContext context, postBlocState) {
                          return AnimatedGestureButton(
                            animate: postBlocState is PostApiProcessing,
                            child: GestureDetector(
                              child: TextButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll<Color>(
                                            Colors.transparent),
                                    side: WidgetStatePropertyAll<BorderSide>(
                                        BorderSide(
                                            color: Colors.red, width: 1))),
                                onPressed: () {
                                  deleteAccount();
                                },
                                child: const Text(
                                  'OUI',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox.square(dimension: 20),
                      TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll<Color>(primaryColor)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'NON',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

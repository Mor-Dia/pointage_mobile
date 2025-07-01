import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yogivida_mobile/components/TopDialogNotification.dart';
import 'package:yogivida_mobile/components/please_login_widget.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/screens/Compte/commandes_page.dart';
import 'package:yogivida_mobile/screens/Compte/favoris_page.dart';
import 'package:yogivida_mobile/screens/Compte/ligne_credit_page.dart';
import 'package:yogivida_mobile/screens/Compte/LocalisationContact.dart';
import 'package:yogivida_mobile/screens/Compte/reservations_page.dart';
import 'package:yogivida_mobile/screens/Compte/Update.dart';
import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/screens/Compte/type_notificationpush_page.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';

import 'package:yogivida_mobile/screens/auth/login_screen.dart';

import '../../components/animated_gesture_detector.dart';
import '../../core/utils/helpers.dart';
import '../../services/data_bloc/bloc/data_bloc.dart';
import '../../services/data_bloc/presentation/bloc_based_widget.dart';
import '../../services/post_api_bloc.dart';

class MonCompte extends StatefulWidget {
  const MonCompte({super.key});

  @override
  State<MonCompte> createState() => _MonCompteState();
}

class _MonCompteState extends State<MonCompte> {
  late DataBloc<List<Utilisateur>> utilisateurBloc;
  late PostApiBloc accountDeletionPostBloc;

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

  @override
  Widget build(BuildContext context) {
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
      builder: (context, state) {
        AuthenticationStatus currentStatus = state.status;
        Utilisateur? currentUser = state.user;
        switch (currentStatus) {
          case AuthenticationStatus.authenticated:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xffffffff),
                elevation: 0,
                automaticallyImplyLeading:
                    false, // Empêche l'affichage du bouton back
                toolbarHeight: 60,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mon compte',
                      style: GoogleFonts.arimo(
                        color: const Color(0xff15274d),
                        fontSize: titreConstant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Update())),
                          child: Container(
                            height: 50,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xff15274d),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/pen.svg',
                                width: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: Container(
                color: Colors.white,
                child: ListView(children: [
                  const SizedBox(height: spacingConstant),
                  Center(
                    child: Column(children: [
                      SvgPicture.asset(
                        "assets/icons/user2.svg",
                        width: 70,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.user?.nom_complet ?? "",
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      )
                    ]),
                  ),
                  const SizedBox(height: spacingConstant),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: spacingConstant),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LigneCreditPage()),
                              )
                            },
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: const Color(0xff5EAB43)),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Mes lignes crédit",
                                    style: TextStyle(color: Color(0xff5EAB43)),
                                  ),
                                  BlocBasedWidget<List<Utilisateur>>(
                                    customDataBloc: utilisateurBloc,
                                    filter: {"id": currentUser?.id},
                                    customWidget: (state) {
                                      List<Utilisateur> users = state.data;
                                      Utilisateur currentClient = users[0];
                                      return Text(
                                        "${Helpers.formatNumber(currentClient.solde)} XOF",
                                        style: TextStyle(
                                            color: currentClient.solde > 0
                                                ? Color(0xff5EAB43)
                                                : Colors.red,
                                            fontWeight: FontWeight.bold),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: spacingConstant),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReservationsPage()),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 1, color: greyColor))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spacingConstant,
                                vertical: spacingConstant),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/historique.svg"),
                                const SizedBox(width: 10),
                                const Text(
                                  "Historique des réservations",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CommandesPage()),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 1, color: greyColor))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spacingConstant,
                                vertical: spacingConstant),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/boutique.svg",
                                  color: primaryColor,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Mes commandes",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavorisPage()),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 1, color: greyColor))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spacingConstant,
                                vertical: spacingConstant),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/like.svg",
                                  color: primaryColor,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Favoris",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TypeNotificationPushsPage()),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 1, color: greyColor))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: spacingConstant,
                                vertical: spacingConstant),
                            child: Row(
                              children: [
                                Icon(Icons.settings, color: primaryColor),
                                SizedBox(width: 10),
                                Text(
                                  "Paramètres de notification",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LocalisationContact()),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 1, color: greyColor))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spacingConstant,
                                vertical: spacingConstant),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/carte.svg",
                                  color: primaryColor,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Localisation et contact",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => logout(),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 1, color: greyColor))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spacingConstant,
                                vertical: spacingConstant),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/off.svg",
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Déconnexion",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showAccountDeletionDialog(context);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 1, color: greyColor))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: spacingConstant,
                                vertical: spacingConstant),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/trash.svg",
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Supprimer le compte",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
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

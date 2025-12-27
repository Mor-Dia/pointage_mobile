import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pointage_mobile/components/ButtonField.dart';
import 'package:pointage_mobile/components/TopDialogNotification.dart';
import 'package:pointage_mobile/components/type_paiement_card.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/core/utils/Capitalized.dart';
import 'package:pointage_mobile/core/utils/helpers.dart';
import 'package:pointage_mobile/screens/Compte/ligne_credit_page.dart';
import 'package:pointage_mobile/services/api/models/ligne_credit_model.dart';
import 'package:pointage_mobile/services/api/models/programme_model.dart';

import '../core/models/user_model.dart';
import '../services/api/models/type_paiement_model.dart';
import '../services/authentication_bloc/authentication_bloc.dart';
import '../services/data_bloc/bloc/data_bloc.dart';
import '../services/data_bloc/presentation/bloc_based_widget.dart';
import '../services/post_api_bloc.dart';
import 'animated_gesture_detector.dart';

class CardRowPlanning extends StatefulWidget {
  final Programme data;
  final Function? onReservation;
  const CardRowPlanning({super.key, required this.data, this.onReservation});

  @override
  State<CardRowPlanning> createState() => _CardRowPlanningState();
}

class _CardRowPlanningState extends State<CardRowPlanning> {
  @override
  Widget build(BuildContext context) {
    Utilisateur? user =
        context.read<AuthenticationBloc<Utilisateur>>().state.user;

    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: greyColor))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spacingConstant),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: spacingConstant),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.professeurPratique!.pratique!.designation
                    .toString()
                    .toCapitalized
                    .toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/heure.svg",
                                      color: const Color(0xFF838282),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.data.heureDebut.toString(),
                                      style: const TextStyle(
                                          color: Color(0xff838282),
                                          fontSize: textminConstant),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/person.svg",
                                      width: 10,
                                      color: const Color(0xFF838282),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.data.professeurPratique!
                                            .professeur!.user!.name
                                            .toString()
                                            .toCapitalized,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Color(0xff838282),
                                            fontSize: textminConstant),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: spacingConstant,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/heure.svg",
                                      color: const Color(0xFF838282),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.data.heureFin.toString(),
                                      style: const TextStyle(
                                          color: Color(0xff838282),
                                          fontSize: textminConstant),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      // "",
                                      "assets/icons/loc.svg",
                                      color: const Color(0xFF838282),
                                      // color: const Color.fromARGB(
                                      // 255, 255, 255, 255),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        // 'Dakar plateau',
                                        widget.data.sallePratique!.salle!
                                            .designation
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xff838282),
                                            fontSize: textminConstant),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    width: spacingConstant,
                  ),
                  Expanded(
                    child: widget.data.etat == "1"
                        ? ButtonFiled(
                            text:
                                'Annuler', // Si fileAttente n'est pas 'Disponible', afficher "Plein"
                            handlerPress: () {}, // Pas d'action
                            color: Colors.red, // Couleur grise pour "Plein"
                          )
                        : widget.data.fileAttente.toString() ==
                                'true' // Comparaison en fonction de ton type de `fileAttente`
                            ? ButtonFiled(
                                text: 'Réserver',
                                handlerPress: () {
                                  if (user == null) {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    TopDialogNotification.show(context,
                                        message: "Veuillez vous connecter !",
                                        isError: false);
                                    return; // Arrêter l'exécution si l'utilisateur n'est pas connecté
                                  }
                                  showBottomSheet(
                                      context,
                                      widget
                                          .data); // Action pour afficher le BottomSheet
                                },
                              )
                            : ButtonFiled(
                                text:
                                    'Plein', // Si fileAttente n'est pas 'Disponible', afficher "Plein"
                                handlerPress: () {}, // Pas d'action
                                color:
                                    Colors.grey, // Couleur grise pour "Plein"
                              ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic currentElt;
  bool isProcessing = false;

  Future<dynamic> showBottomSheet(BuildContext context, Programme programme) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(spacingConstant),
                    topRight: Radius.circular(spacingConstant))),
            child: Padding(
              padding: const EdgeInsets.all(spacingConstant),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 2,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(spacingConstant))),
                    ),
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${programme.professeurPratique?.pratique?.designation.toString().toCapitalized}",
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "${programme.fileAttenteDisplay}",
                        style: const TextStyle(color: primaryColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/heure.svg",
                        height: 15,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${programme.heureDebut}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                      Text(
                        " - ${programme.heureFin}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(
                        "assets/icons/lc.svg",
                        height: 15,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${Helpers.formatNumber(programme.professeurPratique?.pratique?.prixSeance)} FCFA TTC",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5DFC5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      "assets/icons/heure.svg",
                                      height: 15,
                                      color: const Color(0xFFA8923B),
                                    ))),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Durée",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${programme.duration}",
                                  style: const TextStyle(
                                      color: Color(0xff838282), fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox.square(
                          dimension: 10,
                        ),
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5DFC5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      "assets/icons/person.svg",
                                      height: 15,
                                      color: const Color(0xFFA8923B),
                                    ))),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Professeur",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${programme.professeurPratique?.professeur?.user?.name.toString().toCapitalized}",
                                  style: const TextStyle(
                                      color: Color(0xff838282), fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox.square(
                          dimension: 10,
                        ),
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE5DFC5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      "assets/icons/home2.svg",
                                      height: 15,
                                      color: const Color(0xFFA8923B),
                                    ))),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Salle",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${programme.sallePratique?.salle?.designation.toString().toCapitalized}",
                                  style: const TextStyle(
                                      color: Color(0xff838282), fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: spacingConstant,
                  ),
                  // Spacer(flex: 1),
                  Center(
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.50),
                      child: widget.data.fileAttente.toString() == 'true'
                          ?
                          // Si l'état fileAttente est vrai, afficher le bouton "Réserver"
                          ButtonFiled(
                              text: 'Réserver',
                              handlerPress: () =>
                                  ShowBottomSheetPayment(context, programme),
                            )
                          :
                          // Sinon, afficher un bouton gris avec "Plein"
                          ButtonFiled(
                              text: 'Plein',
                              handlerPress: () {}, // Aucun action ici
                              color: Colors.grey,
                            ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> ShowBottomSheetPayment(
      BuildContext context, Programme programme,
      {Function? customFunction}) {
    DataBloc<List<TypePaiement>> typePaiementPushBloc =
        DataBloc<List<TypePaiement>>(
            (response) => TypePaiement.fromJsonList(response),
            TypePaiement.getEndpoint(isPagination: false),
            isGraphQl: true,
            isPagination: false,
            attributeToGet: TypePaiement.shrinkedAttributs())
          ..add(RefreshDataEvent(filter: {'showatwebsite': 'true'}));

    return showModalBottomSheet(
        context: context,
        builder: (BuildContext currentContext) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(spacingConstant),
                      topRight: Radius.circular(spacingConstant))),
              child: Padding(
                padding: const EdgeInsets.all(spacingConstant),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 2,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(spacingConstant))),
                        ),
                      ),
                      const SizedBox(
                        height: spacingConstant,
                      ),
                      Center(
                        child: Text(
                          'Payer par '.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: spacingConstant,
                      ),
                      Center(
                        child: Text(
                          "Montant : ${Helpers.formatNumber(programme.professeurPratique?.pratique?.prixSeance)} FCFA TTC",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      BlocBasedWidget<List<TypePaiement>>(
                        customDataBloc: typePaiementPushBloc,
                        // filter: currentFilter,
                        filter: const {'showatwebsite': 'true'},
                        useInfiniteScroller: true,
                        customWidget: (state) {
                          List<TypePaiement> typePaiements = state.data;
                          return Column(children: [
                            const SizedBox(
                              height: spacingConstant,
                            ),
                            Wrap(spacing: 10, runSpacing: 10, children: [
                              ...buildTypePaiementList(
                                  currentContext, typePaiements, programme),
                            ]),
                          ]);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _showMoreLigneCredit(BuildContext context, lignecredit) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          content: const SizedBox(
            // width: double.maxFinite,
            child: Text(
              "Solde insuffisant merci d'approvisionner votre compte",
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(bottom: 15),
          actions: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LigneCreditPage()),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Text(
                  'Approvisionner mon compte',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> buildTypePaiementList(BuildContext parentContext,
      List<TypePaiement> typePaiements, Programme programme) {
    late PostApiBloc reservationPostBloc;
    reservationPostBloc = PostApiBloc();

    // print("HOHOHGL ${currentElt}");

    reserverCours({required Map<String, dynamic> parameters}) {
      if (isProcessing) return;
      setState(() => isProcessing = true);

      reservationPostBloc.add(
          PostApiMakeCall(endpoint: 'reservation', parameters: parameters));
    }

    return [
      ...typePaiements.map((toElement) {
        return BlocBuilder<AuthenticationBloc<Utilisateur>,
            AuthenticationState<Utilisateur>>(builder: (context, authState) {
          AuthenticationStatus currentStatus = authState.status;
          Utilisateur? user = authState.user;
          switch (currentStatus) {
            case AuthenticationStatus.authenticated:
              return BlocConsumer(
                bloc: reservationPostBloc,
                listener: (context, state) {
                  print("MESSAGE RESE ${currentElt} ");
                  if (currentElt == toElement.id) {
                    if (state is PostApiSuccess || state is PostApiFailure) {
                      setState(() => isProcessing = false);
                    }
                    if (state is PostApiSuccess) {
                      Navigator.of(parentContext).pop();
                      Navigator.of(context).pop();
                      if (state.data != null &&
                          state.data["bictorys_link"] != null) {
                        launchUrl(
                            Uri.parse(state.data["bictorys_link"].toString()));
                      } else {
                        TopDialogNotification.show(context,
                            message: "${state.message}", isError: false);
                      }
                    }
                    if (state is PostApiFailure) {
                      print("MESSAGE RESE ${state.message} ");
                      ScaffoldMessenger.of(parentContext).hideCurrentSnackBar();
                      TopDialogNotification.show(context,
                          message: "${state.message}", isError: true);
                    }
                  }
                },
                builder: (BuildContext context, postBlocState) {
                  return AnimatedGestureButton(
                    animate: currentElt == toElement.id &&
                        postBlocState is PostApiProcessing,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentElt = null;
                            currentElt = toElement.id;
                            print(currentElt);
                          });
                          Map<String, dynamic> parameters = {
                            "programme": programme.id,
                            "client": user?.id,
                            "from_site": true,
                            "from_mobile": true,
                            "platform": Platform.isAndroid ? "Android" : "Ios",
                            "mode_paiement_id": toElement.id,
                          };
                          var montant = programme
                              .professeurPratique?.pratique?.prixSeance;

                          print({
                            " le prix progame : ${montant} et le solde : ${user?.solde}"
                          });
                          print(toElement!.soldeDisponible!.toInt() <
                              montant!.toInt());

                          // (toElement.isLigneCredit == true &&
                          //         user?.solde.toInt() < montant)
                          (toElement.isLigneCredit == true &&
                                  toElement!.soldeDisponible!.toInt() <
                                      montant!.toInt())
                              ? _showMoreLigneCredit(context, toElement)
                              : reserverCours(parameters: parameters);
                        },
                        child: Opacity(
                          opacity: isProcessing ? 0.5 : 1,
                          child: IgnorePointer(
                            ignoring: isProcessing,
                            child: TypePaiementCard(typePaiement: toElement),
                          ),
                        )),
                  );
                },
              );
            case AuthenticationStatus.unknown:
            case AuthenticationStatus.unauthenticated:
            case AuthenticationStatus.failure:
              return const SizedBox();
          }
        });
      }).toList(),
    ];
  }
}

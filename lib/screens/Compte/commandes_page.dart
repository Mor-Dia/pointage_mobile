import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yogivida_mobile/components/TopDialogNotification.dart';
import 'package:yogivida_mobile/components/animated_gesture_detector.dart';
import 'package:yogivida_mobile/components/card_commande.dart';
import 'package:yogivida_mobile/components/type_paiement_card.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/models/type_paiement_model.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:yogivida_mobile/components/please_login_widget.dart';
import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';
import 'package:yogivida_mobile/services/post_api_bloc.dart';

import '../../services/api/models/commande_model.dart';

class CommandesPage extends StatefulWidget {
  const CommandesPage({super.key});

  @override
  State<CommandesPage> createState() => _CommandesPageState();
}

class _CommandesPageState extends State<CommandesPage> {
  late DataBloc<List<Commande>> commandeBloc;
  Map<String, dynamic> globalFilter = {"count": 10};

  bool isProcessing = false;

  @override
  void initState() {
    commandeBloc = DataBloc<List<Commande>>(
        (response) => Commande.fromJsonList(response),
        Commande.getEndpoint(isPagination: true),
        isGraphQl: true,
        isPagination: true,
        attributeToGet: Commande.shrinkedAttributs());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: greyColorL, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: SvgPicture.asset('assets/icons/back.svg'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mes commandes',
              style: GoogleFonts.arimo(
                color: const Color(0xff15274d),
                fontSize: titreConstant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
          color: Colors.white,
          child: BlocBuilder<AuthenticationBloc<Utilisateur>,
              AuthenticationState<Utilisateur>>(builder: (context, authState) {
            AuthenticationStatus currentStatus = authState.status;
            int? clientId = authState.user?.id;
            switch (currentStatus) {
              case AuthenticationStatus.authenticated:
                return BlocBasedWidget<List<Commande>>(
                  customDataBloc: commandeBloc,
                  filter: {...globalFilter, "client_id": clientId},
                  useInfiniteScroller: true,
                  customWidget: (state) {
                    List<Commande> commandes = state.data;

                    if (commandes == null || commandes.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                          // Centre le texte horizontalement
                          child: Text(
                            "Vous n'avez aucune commande",
                            style: GoogleFonts.arimo(
                              color: primaryColor,
                              fontSize: titreConstant,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        const SizedBox(
                          height: spacingConstant,
                        ),
                        ...commandes.asMap().entries.map((entry) {
                          final index = entry.key;
                          final toElement = entry.value;

                          return CardCommande(
                            commande: toElement,
                            onDelete: () {
                              setState(() {
                                commandes.removeAt(index);
                              });
                            },
                            onShowPaymentSheet: () {
                              ShowBottomSheetPayment(context, toElement, []);
                            },
                          );
                        }).toList(),
                      ],
                    );
                  },
                );
              case AuthenticationStatus.unknown:
              case AuthenticationStatus.unauthenticated:
              case AuthenticationStatus.failure:
                return const Center(child: PleaseLoginWidget());
            }
          })),
    );
  }

  Future<dynamic> ShowBottomSheetPayment(BuildContext context,
      Commande? commande, List<TypePaiement> typePaiements) {
    DataBloc<List<TypePaiement>> typePaiementPushBloc =
        DataBloc<List<TypePaiement>>(
            (response) => TypePaiement.fromJsonList(response),
            TypePaiement.getEndpoint(isPagination: false),
            isGraphQl: true,
            isPagination: false,
            attributeToGet: TypePaiement.shrinkedAttributs())
          ..add(RefreshDataEvent(filter: {
            'showatwebsite': 'true',
            // 'showatwebsiteNotLC': 'true'
          }));

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
                      if (typePaiements.isEmpty)
                        BlocBasedWidget<List<TypePaiement>>(
                          customDataBloc: typePaiementPushBloc,
                          filter: const {
                            'showatwebsite': 'true',
                            // 'showatwebsiteNotLC': 'true'
                          },
                          useInfiniteScroller: true,
                          customWidget: (state) {
                            List<TypePaiement> typePaiements = state.data;
                            return Column(children: [
                              const SizedBox(
                                height: spacingConstant,
                              ),
                              Wrap(spacing: 10, runSpacing: 10, children: [
                                ...buildTypePaiementList(currentContext,
                                    typePaiements, commande?.total, commande),
                              ]),
                            ]);
                          },
                        ),
                      if (typePaiements.isNotEmpty)
                        Wrap(spacing: 10, runSpacing: 10, children: [
                          ...buildTypePaiementList(currentContext,
                              typePaiements, commande?.total, commande),
                        ]),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<Widget> buildTypePaiementList(BuildContext parentContext,
      List<TypePaiement> typePaiements, montant, Commande? commande) {
    late PostApiBloc lcPostBloc;
    lcPostBloc = PostApiBloc();
    dynamic currentElt;

    List<int?> panier_produit_id = (commande?.venteProduits ?? [])
        .map((panierProduit) => panierProduit.id)
        .toList();

    print("HOHOHGL panier ${panier_produit_id}");

    buyCommande({required Map<String, dynamic> parameters}) {
      if (isProcessing) return;
      setState(() => isProcessing = true);

      print("BUY commande  ${parameters.toString()}");
      lcPostBloc.add(
          PostApiMakeCall(endpoint: 'commande_client', parameters: parameters));
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
                bloc: lcPostBloc,
                listener: (context, state) {
                  if (currentElt == toElement.id) {
                    if (state is PostApiSuccess || state is PostApiFailure) {
                      setState(() => isProcessing = false);
                    }
                    if (state is PostApiSuccess) {
                      print("NEW STATE PostApiSuccess  ${state.message}");
                      if (state.data != null &&
                          state.data["bictorys_link"] != null) {
                        Navigator.of(parentContext).pop();
                        Navigator.of(context).pop();
                        launchUrl(
                            Uri.parse(state.data["bictorys_link"].toString()));
                        commandeBloc.add(FetchDataEvent(
                            filter: {...globalFilter, "client_id": user?.id}));
                      } else {
                        Navigator.of(parentContext).pop();
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CommandesPage()));
                        TopDialogNotification.show(context,
                            message: "${state.message}", isError: false);
                      }

                      // lcBloc.add(FetchDataEvent(loadNewData: true));
                    }
                    if (state is PostApiFailure) {
                      print("NEW STATE PostApiFailure  ${state.message}");
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
                          });
                          // Map<String, dynamic> parameters = {
                          //   "montant": commande?.total,
                          //   "client": user?.id,
                          //   "from_site": true,
                          //   "from_mobile": true,
                          //   "etat": false,
                          //   "typelignecredit": 2,
                          //   "type_paiement": toElement.id,
                          //   "platform": Platform.isAndroid ? "Android" : "Ios",
                          // };

                          Map<String, dynamic> parameters = {
                            "panier_produit_id": panier_produit_id ?? null,
                            "client_id": user?.id,
                            "token": user?.token,
                            "email": user?.email ?? null,
                            "politique_retour": true,
                            "from_site": true,
                            "from_mobile": true,
                            "platform": Platform.isAndroid ? "Android" : "Ios",
                            "type_paiement_id": toElement.id,
                            "adresse": '',
                            "montant": commande?.total,
                            "zone_livraison_id":
                                commande?.zoneLivraison!.id ?? 1,
                          };

                          if (commande != null) {
                            parameters["id"] =
                                commande.id; // 🔥 relance paiement
                          }

                          buyCommande(parameters: parameters);
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

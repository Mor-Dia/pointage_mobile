import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/CardProduitPanier.dart';
import 'package:yogivida_mobile/components/InputFiled.dart';
import 'package:yogivida_mobile/components/TopDialogNotification.dart';
import 'package:yogivida_mobile/components/animated_gesture_detector.dart';
import 'package:yogivida_mobile/components/type_paiement_card.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';
import 'package:yogivida_mobile/services/api/models/panier_model.dart';
import 'package:yogivida_mobile/services/api/models/type_paiement_model.dart';
import 'package:yogivida_mobile/services/api/models/zone_livraison_model.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/panierBloc/panier_bloc_bloc.dart';
import 'package:yogivida_mobile/components/please_login_widget.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';
import 'package:yogivida_mobile/services/post_api_bloc.dart';

import '../../core/utils/helpers.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({super.key});

  @override
  State<PanierPage> createState() => _PanierState();
}

class _PanierState extends State<PanierPage> {
  List<PanierPProduit>? _panier;

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthenticationBloc<Utilisateur>>();
    Utilisateur? user = authBloc.state.user;

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
                'Mon panier',
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
            child: BlocConsumer<PanierBlocBloc, PanierBlocState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (user == null) {
                    return const PleaseLoginWidget();
                  }

                  if (state is PanierLoaded) {
                    _panier = state.panier.panierProduit;
                  }

                  if (_panier == null || _panier!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        // Centre le texte horizontalement
                        child: Text(
                          'Votre panier est vide.',
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
                      Expanded(
                        child: Stack(
                          children: [
                            ListView(
                              shrinkWrap: true,
                              children: ((state is PanierLoaded)
                                      ? state.panier.panierProduit!
                                      : _panier!)
                                  .map((toElement) =>
                                      CardProduitPanier(data: toElement))
                                  .toList(),
                            ),
                            if (state is PanierLoading)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.white.withOpacity(0.7),
                                  child: const Center(
                                      // child: CircularProgressIndicator()
                                      child: Loader1(size: 8)),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      if ((state is PanierLoaded) &&
                          state.panier.total != 0) ...[
                        Text(
                          'TOTAL : ${Helpers.formatNumber(state.panier.total)} FCFA TTC',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: titreConstant,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8.0),
                            child: ButtonFiled(
                              text: 'Finaliser la commande',
                              handlerPress: () {
                                ShowBottomSheetCommande(context, state.panier);
                              },
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 40),
                    ],
                  );
                })));
  }

  dynamic currentElt;

  List<Widget> buildTypePaiementList(
      BuildContext parentContext,
      List<TypePaiement> typePaiements,
      Panier panier,
      selectedZoneLivraison,
      adresse) {
    late PostApiBloc panierPostBloc;
    panierPostBloc = PostApiBloc();

    List<int?> panier_produit_id =
        panier.panierProduit!.map((panierProduit) => panierProduit.id).toList();

    print("HOHOHGL panier ${panier_produit_id} -- ${selectedZoneLivraison}");

    print(
        "HOHOHGL panier getPrixZoneLivraison -- ${panier.total} -- ${selectedZoneLivraison} -- ${adresse.text.trim()}");

    savePanier({required Map<String, dynamic> parameters}) {
      panierPostBloc.add(
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
                bloc: panierPostBloc,
                listener: (context, state) {
                  print("MESSAGE success state ${state} ");
                  if (currentElt == toElement.id) {
                    if (state is PostApiSuccess) {
                      // Navigator.of(parentContext).pop();
                      // Navigator.of(context).pop();

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
                          if (selectedZoneLivraison == null) {
                            TopDialogNotification.show(context,
                                message:
                                    "Veuillez sélectionner une zone de livraison.",
                                isError: true);
                            return;
                          }
                          setState(() {
                            currentElt = null;
                            currentElt = toElement.id;
                            print(currentElt);
                          });
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
                            "adresse": adresse.text.trim() ?? '',
                            "montant": panier.total! +
                                (selectedZoneLivraison!.prix?.toInt() ?? 0),
                            "zone_livraison_id": selectedZoneLivraison!.id ?? 1,
                          };
                          print("ici les parameters ${parameters}");

                          savePanier(parameters: parameters);
                        },
                        child: TypePaiementCard(typePaiement: toElement)),
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

  Future<dynamic> ShowBottomSheetCommande(BuildContext context, Panier panier) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        DataBloc<List<TypePaiement>> typePaiementPushBloc =
            DataBloc<List<TypePaiement>>(
                (response) => TypePaiement.fromJsonList(response),
                TypePaiement.getEndpoint(isPagination: false),
                isGraphQl: true,
                isPagination: false,
                attributeToGet: TypePaiement.shrinkedAttributs())
              ..add(RefreshDataEvent(filter: {
                'showatwebsite': 'true',
                'showatwebsiteNotLC': 'true'
              }));

        DataBloc<List<ZoneLivraison>> zoneLivraisonBloc =
            DataBloc<List<ZoneLivraison>>(
          (response) => ZoneLivraison.fromJsonList(response),
          ZoneLivraison.getEndpoint(isPagination: false),
          isGraphQl: true,
          isPagination: false,
          attributeToGet: ZoneLivraison.shrinkedAttributs(),
        );

        // List? zone_livraison;
        ZoneLivraison? selectedZoneLivraison;
        TextEditingController adresseController =
            TextEditingController(text: '');

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(spacingConstant),
                    topRight: Radius.circular(spacingConstant),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(spacingConstant),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 2,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(spacingConstant)),
                          ),
                        ),
                      ),
                      const SizedBox(height: spacingConstant),

                      const Text(
                        "Finaliser la commande",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                      const SizedBox(height: spacingConstant),

                      // Bloc Auth
                      BlocBuilder<AuthenticationBloc<Utilisateur>,
                          AuthenticationState<Utilisateur>>(
                        builder: (context, authState) {
                          Utilisateur? user = authState.user;

                          TextEditingController nom_completController =
                              TextEditingController(
                                  text: user?.nom_complet ?? '');

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Informations du client",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Inputfiled(
                                type: 'text',
                                text: "Nom complet",
                                controller: nom_completController,
                                error: '',
                              ),
                              const SizedBox(height: 8),
                              Inputfiled(
                                type: 'text',
                                text: "Adresse",
                                controller: adresseController,
                                error: '',
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Zone de livraison
                      const Text("Zone de livraison",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),

                      BlocBasedWidget<List<ZoneLivraison>>(
                        customDataBloc: zoneLivraisonBloc,
                        filter: const {'showatwebsite': 'true'},
                        useInfiniteScroller: true,
                        customWidget: (state) {
                          List<ZoneLivraison> zones = state.data;

                          return DropdownButton<ZoneLivraison>(
                            isExpanded: true,
                            value: selectedZoneLivraison,
                            hint: const Text("Sélectionner une zone"),
                            items: zones.map((zone) {
                              return DropdownMenuItem<ZoneLivraison>(
                                value: zone,
                                child: Text(zone.designation ?? ""),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setModalState(() {
                                selectedZoneLivraison = newValue;
                              });
                              if (kDebugMode) {
                                print(
                                    "Zone sélectionnée : $selectedZoneLivraison");
                              }
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 8),
                      // 💰 Récapitulatif du montant
                      const Text(
                        "Récapitulatif commande",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Sous-total :"),
                                Text(Helpers.formatNumber(panier.total!.toString())),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Tarif livraison :"),
                                Text(Helpers.formatNumber((selectedZoneLivraison != null ? selectedZoneLivraison!.prix : 0).toString())),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total commande :",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  (Helpers.formatNumber((panier.total?.toInt() ?? 0) +
                                          (selectedZoneLivraison?.prix
                                                  ?.toInt() ??
                                              0))
                                      .toString()),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Type de paiement
                      const Text("Type de paiement",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),

                      BlocBasedWidget<List<TypePaiement>>(
                        customDataBloc: typePaiementPushBloc,
                        filter: const {
                          'showatwebsite': 'true',
                          // 'showatwebsiteNotLC': 'true'
                        },
                        useInfiniteScroller: true,
                        customWidget: (state) {
                          List<TypePaiement> typePaiements = state.data;
                          return Column(
                            children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  ...buildTypePaiementList(
                                      context,
                                      typePaiements,
                                      panier,
                                      selectedZoneLivraison,
                                      adresseController),
                                ],
                              ),
                              const SizedBox(
                                height: spacingConstant,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

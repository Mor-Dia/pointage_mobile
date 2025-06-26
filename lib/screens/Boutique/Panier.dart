import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/components/ButtonField.dart';
import 'package:yogivida_mobile/components/CardProduitPanier.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/core/models/user_model.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';
import 'package:yogivida_mobile/services/api/models/panier_model.dart';
import 'package:yogivida_mobile/services/api/models/type_paiement_model.dart';
import 'package:yogivida_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/panierBloc/panier_bloc_bloc.dart';
import 'package:yogivida_mobile/components/please_login_widget.dart';
import 'package:yogivida_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

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
                                      child: CircularProgressIndicator()),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      if ((state is PanierLoaded) &&
                          state.panier.total != 0) ...[
                        Text(
                          'TOTAL TTC : ${Helpers.formatNumber(state.panier.total)}',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: titreConstant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 40),
                    ],
                  );
                })));
  }
}

Future<dynamic> ShowBottomSheetCommande(BuildContext context, Panier panier) {
  // Controllers pour les champs de saisie
  TextEditingController prenomController =
      // TextEditingController(text: panier.client.prenom);
      TextEditingController(text: "panier.client.prenom");
  TextEditingController nomController =
      TextEditingController(text: "panier.client.nom");
  TextEditingController adresseController =
      TextEditingController(text: "panier.client.adresse");

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Permet d'éviter le débordement clavier
    builder: (BuildContext context) {
      DataBloc<List<TypePaiement>> typePaiementPushBloc =
          DataBloc<List<TypePaiement>>(
              (response) => TypePaiement.fromJsonList(response),
              TypePaiement.getEndpoint(isPagination: false),
              isGraphQl: true,
              isPagination: false,
              attributeToGet: TypePaiement.shrinkedAttributs());

      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Gère le clavier
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
              mainAxisSize: MainAxisSize.min, // S'ajuste au contenu
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Indicateur de swipe pour fermer
                Center(
                  child: Container(
                    height: 2,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: greyColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(spacingConstant)),
                    ),
                  ),
                ),
                const SizedBox(height: spacingConstant),

                const Text(
                  "Finaliser la commande",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                const SizedBox(height: spacingConstant),

                // ✅ Informations du client
                const Text("Informations du client",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: prenomController,
                      decoration: const InputDecoration(labelText: "Prénom"),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextFormField(
                      controller: nomController,
                      decoration: const InputDecoration(labelText: "Nom"),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: adresseController,
                  decoration: const InputDecoration(labelText: "Adresse"),
                ),
                const Divider(height: spacingConstant),

                // ✅ Sélection de la zone de livraison
                const Text("Zone de livraison",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                // DropdownButton<String>(
                //   value: "panier.zoneLivraison",
                //   onChanged: (newValue) {
                //     print(newValue);
                //     // panier.zoneLivraison = newValue!;
                //   },
                //   items: [
                //     "Zone 1",
                //     "Zone 2",
                //     "Zone 3"
                //   ] // Remplace par tes vraies zones
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
                const Divider(height: spacingConstant),

                // ✅ Type de paiement
                const Text("Type de paiement",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                BlocBasedWidget<List<TypePaiement>>(
                  customDataBloc: typePaiementPushBloc,
                  filter: const {'showatwebsite': 'true'},
                  useInfiniteScroller: true,
                  customWidget: (state) {
                    List<TypePaiement> typePaiements = state.data;
                    print("typePaiements $typePaiements");
                    return Column(
                      children: typePaiements.map((paiement) {
                        return RadioListTile<TypePaiement>(
                          title: Text(paiement?.designation.toString() ?? ""),
                          value: paiement,
                          groupValue: paiement,
                          onChanged: (TypePaiement? newPaiement) {
                            // panier.typePaiement = newPaiement!;
                            print(newPaiement);
                          },
                        );
                      }).toList(),
                    );
                  },
                ),

                const SizedBox(height: spacingConstant),

                // ✅ Bouton de finalisation
                Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.50,
                    ),
                    child: ButtonFiled(
                      text: 'Finaliser la commande',
                      handlerPress: () {
                        // Mettre à jour les valeurs avant validation
                        // panier.client.prenom = prenomController.text;
                        // panier.client.nom = nomController.text;
                        // panier.client.adresse = adresseController.text;

                        // Logique pour valider la commande
                      },
                    ),
                  ),
                ),
                const SizedBox(height: spacingConstant),
              ],
            ),
          ),
        ),
      );
    },
  );
}

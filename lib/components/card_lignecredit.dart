import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yogivida_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:yogivida_mobile/services/post_api_bloc.dart';

import '../constant.dart';
import '../core/utils/helpers.dart';
import '../services/api/models/ligne_credit_model.dart';

class CardLignecredit extends StatelessWidget {
  final LigneCredit ligneCredit;
  final VoidCallback? onDelete;

  final VoidCallback? onShowPaymentSheet; // <-- callback pour ouvrir le bottom sheet


  const CardLignecredit({super.key, required this.ligneCredit, this.onDelete, this.onShowPaymentSheet});

  @override
  Widget build(BuildContext context) {
    late PostApiBloc lcPostBloc;
    lcPostBloc = PostApiBloc();
    bool isDeleting = false;

    deleteLigneCredit({required Map<String, dynamic> parameters}) {
      print("Delete LIGNE CREDIT  ${parameters.toString()}");
      isDeleting = true;
      lcPostBloc.add(PostApiMakeCall(
          endpoint: 'lignecreditfront/${parameters["id"]}',
          parameters: parameters,
          isDeletion: true));
    }

    return BlocListener<PostApiBloc, PostApiState>(
      bloc: lcPostBloc,
      listener: (context, state) {
        if (state is PostApiSuccess) {
          if (isDeleting) {
            print("✅ Suppression réussie → on supprime la carte");
            onDelete?.call(); // 🔥 suppression visuelle
          } else {
            print("✅ Paiement réussi");
          }
        }
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: greyColorL))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: spacingConstant / 2),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: spacingConstant / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "${ligneCredit.dateFr}",
                  style: const TextStyle(
                      fontSize: 13,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                                const SizedBox(height: 2),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Montant : ${Helpers.formatNumber(ligneCredit.montant)} FCFA TTC",
                        style: const TextStyle(
                            fontSize: 13,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    if (ligneCredit.etat == true)
                      Text(
                          "Solde : ${Helpers.formatNumber(ligneCredit.solde)} FCFA TTC",
                          style: const TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                              fontWeight: FontWeight.bold)),
                    if (ligneCredit.etat == false)
                      Row(
                        children: [
                          // Bouton relancer paiement
                          GestureDetector(
                            onTap : onShowPaymentSheet,
                            child: Container(
                              height: 35,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: successColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/lc.svg',
                                    width: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Bouton supprimer
                          GestureDetector(
                            onTap: () {
                              Map<String, dynamic> parameters = {
                                "id": ligneCredit.id,
                              };
                              deleteLigneCredit(parameters: parameters);
                            },
                            child: Container(
                              height: 35,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/trash.svg',
                                    width: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yogivida_mobile/screens/Compte/ligne_credit_page.dart';

import '../constant.dart';
import '../core/utils/helpers.dart';
import '../services/api/models/ligne_credit_model.dart';


class CardLignecredit extends StatelessWidget {
  final LigneCredit ligneCredit;
  const CardLignecredit({super.key, required this.ligneCredit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(width: 1, color: greyColorL)
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spacingConstant),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: spacingConstant),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${Helpers.formatNumber(ligneCredit.solde)} XOF",
                      style: const TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  Text(ligneCredit.etat == true ? "Payé" : "En cours")
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "${ligneCredit.dateFr}",
                style: const TextStyle(
                    fontSize: 10,
                    color: greyColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

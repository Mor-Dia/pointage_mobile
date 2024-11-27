import 'package:flutter/material.dart';
import 'package:yogivida_mobile/screens/Compte/ligne_credit_page.dart';

import '../constant.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${ligneCredit.solde} XOF / ${ligneCredit.montant} XOF",
                  style: const TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.bold
                  )
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

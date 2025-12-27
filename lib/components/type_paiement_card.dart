import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pointage_mobile/core/utils/Capitalized.dart';

import '../constant.dart';
import '../core/utils/helpers.dart';
import '../services/api/models/type_paiement_model.dart';

class TypePaiementCard extends StatelessWidget {
  final TypePaiement typePaiement;

  const TypePaiementCard({super.key, required this.typePaiement});

  @override
  Widget build(BuildContext context) {
    return
     Container(
      decoration: BoxDecoration(
          // color: primaryColor,
          border: Border.all(width: 1, color: primaryColor),
          // border: Border.all(width: 1, color: greyColorL),
          borderRadius: const BorderRadius.all(Radius.circular(spacingConstant))),
      child: Padding(
        padding: const EdgeInsets.all(spacingConstant),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "${typePaiement.designation?.toCapitalized}",
                style: const TextStyle(color: primaryColor,fontWeight: FontWeight.bold)
                // style: const TextStyle(color: greyColorL)
            ),
            const Spacer(),
            Visibility(
              visible: typePaiement.isLigneCredit ?? false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'Solde actuel',
                      style: TextStyle(
                          color: primaryColor, fontSize: 12)
                  ),
                  Text(
                      "${Helpers.formatNumber(typePaiement.soldeDisponible)} FCFA TTC",
                      style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

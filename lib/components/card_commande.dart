import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/services/api/models/commande_model.dart';

import '../constant.dart';

class CardCommande extends StatelessWidget {
  final Commande commande;

  const CardCommande({
    super.key,
    required this.commande,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: greyColor))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: spacingConstant, horizontal: spacingConstant),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "N° ${commande.id ?? ''}",
                ),
                Text(
                  "${commande.total ?? ""}${" xof"}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  commande.createdAtFr ?? "",
                  style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff838282),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  commande.displayetat ?? "",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: getDisplayColor(commande.displayetat ?? "")
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Container(
                //   height: 30,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: primaryColor,
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         SvgPicture.asset('assets/icons/cadit.svg'),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         Text(
                //           'Ajouter au panier',
                //           overflow: TextOverflow.ellipsis,
                //           style: GoogleFonts.arimo(
                //             color: Colors.white,
                //             fontSize: MediaQuery.of(context).size.width * 0.030,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   width: 10,
                // ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: primaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Voir les détails',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: MediaQuery.of(context).size.width * 0.030,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

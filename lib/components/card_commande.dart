import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogivida_mobile/services/api/models/commande_model.dart';

import '../constant.dart';
import '../core/utils/helpers.dart';

class CardCommande extends StatelessWidget {
  final Commande commande;

  const CardCommande({
    super.key,
    required this.commande,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetails(context),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: greyColor))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: spacingConstant, horizontal: spacingConstant),
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
                    "${Helpers.formatNumber(commande.total)} FCFA TTC",
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
                    commande.etat_paiement ?? "",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: getDisplayColor(
                            commande.color_etat_paiement ?? "")),
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Ouvre un BottomSheet avec le détail de la commande ---
  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          maxChildSize: 0.95,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Détails de la commande N°${commande.id}",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "Date : ${commande.createdAtFr ?? ''}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${commande.etat_paiement ?? ''}",
                    style: TextStyle(
                      color:
                          getDisplayColor(commande.color_etat_paiement ?? ''),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 30),

                  // --- Liste des produits ---
                  if (commande.venteProduits != null &&
                      commande.venteProduits!.isNotEmpty)
                    ...commande.venteProduits!.map((vente) {
                      final produit = vente.produit;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image du produit
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: produit?.image != null
                                  ? Image.network(
                                      produit!.image!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[300],
                                      child:
                                          const Icon(Icons.image_not_supported),
                                    ),
                            ),
                            const SizedBox(width: 10),
                            // Détails du produit
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    produit?.designation ?? 'Produit inconnu',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Quantité : ${vente.quantite ?? 1}",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${Helpers.formatNumber(vente.total)} FCFA",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  else
                    const Center(
                      child: Text(
                        "Aucun produit trouvé pour cette commande.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                  const Divider(height: 20),
                  if (commande.zoneLivraison != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Zone de livraison : ${commande.zoneLivraison?.designation ?? ''}", style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              "${Helpers.formatNumber(commande.zoneLivraison?.prix)} FCFA",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total TTC :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${Helpers.formatNumber(commande.total)} FCFA",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

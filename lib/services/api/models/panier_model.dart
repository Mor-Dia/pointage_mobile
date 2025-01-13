import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';
import 'package:yogivida_mobile/services/api/models/taille_model.dart';

part 'panier_model.freezed.dart';
part 'panier_model.g.dart';

@freezed
class Panier with _$Panier {
  const Panier._();
  const factory Panier({
    int? id, // Identifiant unique pour la commande ou le panier
    int? total, // Montant total de la commande
    @JsonKey(name: 'panier_produit')
    List<PanierPProduit>? panierProduit, // Liste des produits du panier
  }) = _PanierP;

  factory Panier.fromJson(Map<String, dynamic> json) => _$PanierFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Panier> data = [];
    try {
      if (kDebugMode) {}

      for (var result in json) {
        data.add(Panier.fromJson(result as Map<String, dynamic>));
      }
      if (kDebugMode) {}
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs() {
    return "id,total,panier_produit{id,qte,prix,total,produit{id,designation,image,prix,en_promo,pourcentage_promo,prix_avant_promo,prix_avant_promo_siteweb_fr,prix_apres_promo_siteweb_fr,}}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "panierspaginated" : "paniers";
  }
}

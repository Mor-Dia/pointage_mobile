import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/models/panierProduit_model.dart';
import 'package:yogivida_mobile/services/api/models/taille_model.dart';

part 'panier_model.freezed.dart';
part 'panier_model.g.dart';

@freezed
class PanierP with _$PanierP {
  const PanierP._();
  const factory PanierP({
    int? id, // Identifiant unique pour la commande ou le panier
    int? total, // Montant total de la commande
    @JsonKey(name: 'panier_produit')
    List<PanierPProduit>? panierProduit, // Liste des produits du panier
  }) = _PanierP;

  factory PanierP.fromJson(Map<String, dynamic> json) =>
      _$PanierPFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<PanierP> data = [];
    try {
      if (kDebugMode) {}

      for (var result in json) {
        data.add(PanierP.fromJson(result as Map<String, dynamic>));
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

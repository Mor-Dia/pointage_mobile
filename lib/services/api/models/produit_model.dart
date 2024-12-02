import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/constant.dart';
import 'package:yogivida_mobile/services/api/models/taille_model.dart';

part 'produit_model.freezed.dart';
part 'produit_model.g.dart';

@freezed
class Produit with _$Produit {
  const Produit._();
  const factory Produit({
    int? id,
    String? designation,
    bool? favoris,
    String? description,
    int? marqueId,
    String? marqueDesignation,
    @JsonKey(name: "produit_tailles") List<Taille>? produitTailles,
    @JsonKey(name: "prix_site_web_fr") String? prixSiteWebFr,
    String? image,
    double? prix,
    int? familleProduitId,
    String? familleProduitDesignation,
  }) = _Produit;

  factory Produit.fromJson(Map<String, dynamic> json) =>
      _$ProduitFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Produit> data = [];
    try {
      if (kDebugMode) {}

      for (var result in json) {
        data.add(Produit.fromJson(result as Map<String, dynamic>));
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
    return "id,en_promo,favoris,pourcentage_promo,prix_avant_promo,prix_avant_promo_siteweb_fr,prix_apres_promo_siteweb_fr,prix_apres_promo,prix_avant_promo,favoris,designation,description,marque_id,marque{id,designation},produit_tailles{id,taille_id,taille{id,designation,abreviation}},image,prix,prix_site_web,prix_site_web_fr,famille_produit_id,famille_produit{id,designation},current_quantity";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "produitspaginated" : "produits";
  }
}

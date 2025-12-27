import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/services/api/models/produit_model.dart';
import 'package:pointage_mobile/services/api/models/taille_model.dart';

part 'favoris_model.freezed.dart';
part 'favoris_model.g.dart';

@freezed
class Favoris with _$Favoris {
  const Favoris._();
  const factory Favoris({
    List<Produit>? produits,
  }) = _Favoris;

  factory Favoris.fromJson(Map<String, dynamic> json) => _$FavorisFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Produit> data = [];

    try {
      if (kDebugMode) {}

      for (var result in json) {
        data.add(Produit.fromJson(result['produits'] as Map<String, dynamic>));
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
    return "produits{id,en_promo,favoris,pourcentage_promo,prix_avant_promo,prix_avant_promo_siteweb_fr,prix_apres_promo_siteweb_fr,prix_apres_promo,prix_avant_promo,favoris,designation,description,marque_id,marque{id,designation},produit_tailles{id,taille_id,taille{id,designation,abreviation}},image,prix,prix_site_web,prix_site_web_fr,famille_produit_id,famille_produit{id,designation},current_quantity}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "favorispaginated" : "favoris";
  }
}

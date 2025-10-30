import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/produit_model.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';
import 'package:yogivida_mobile/services/api/models/souscription_model.dart';
import 'package:yogivida_mobile/services/api/models/zone_livraison_model.dart';

part 'commande_model.freezed.dart';
part 'commande_model.g.dart';

@freezed
class Commande with _$Commande {
  const Commande._();
  const factory Commande({
    int? id,
    dynamic? total,
    String? displaycoloretat,
    String? displayetat,
    String? etat_paiement,
    String? color_etat_paiement,
    @JsonKey(name: "created_at_fr")String? createdAtFr,
    @JsonKey(name: "vente_produits") List<VenteProduit>? venteProduits,
    @JsonKey(name: "zone_livraison") ZoneLivraison? zoneLivraison,


  }) = _Commande;

  factory Commande.fromJson(Map<String, dynamic> json)  => _$CommandeFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<Commande> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(Commande.fromJson(result as Map<String, dynamic>));
      }
      if (kDebugMode) {
      }
    } catch(error, stacktrace){
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs () {
    return "id,total,color_etat_paiement,etat_paiement,created_at_fr,displayetat,displaycoloretat,zone_livraison{id,designation,prix},vente_produits{id,quantite,total,produit{id,designation,image,prix,en_promo,pourcentage_promo,prix_avant_promo,prix_avant_promo_siteweb_fr,prix_apres_promo_siteweb_fr}}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "ventespaginated" : "ventes";
  }
  
}

/// ======= Modèle VenteProduit =======
@freezed
class VenteProduit with _$VenteProduit {
  const VenteProduit._();

  const factory VenteProduit({
    int? id,
    int? quantite,
    dynamic? total,
    Produit? produit,
  }) = _VenteProduit;

  factory VenteProduit.fromJson(Map<String, dynamic> json) =>
      _$VenteProduitFromJson(json);
}

/// ======= Modèle ZoneLivraison =======
@freezed
class ZoneLivraison with _$ZoneLivraison {
  const ZoneLivraison._();

  const factory ZoneLivraison({
    int? id,
    String? designation,
    dynamic? prix,
  }) = _ZoneLivraison;

  factory ZoneLivraison.fromJson(Map<String, dynamic> json) =>
      _$ZoneLivraisonFromJson(json);
}
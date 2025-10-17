import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';
import 'package:yogivida_mobile/services/api/models/souscription_model.dart';

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
    return "id,total,color_etat_paiement,etat_paiement,created_at_fr,displayetat,displaycoloretat";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "ventespaginated" : "ventes";
  }
}
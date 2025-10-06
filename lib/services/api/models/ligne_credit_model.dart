import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';
import 'package:yogivida_mobile/services/api/models/souscription_model.dart';
import 'package:yogivida_mobile/services/api/models/type_lignecredit_model.dart';
import 'package:yogivida_mobile/services/api/models/type_paiement_model.dart';

part 'ligne_credit_model.freezed.dart';
part 'ligne_credit_model.g.dart';

@freezed
class LigneCredit with _$LigneCredit {
  const LigneCredit._();
  const factory LigneCredit({
    int? id,
    dynamic? solde,
    dynamic? montant,
    dynamic? from_site,
    bool? etat,
    @JsonKey(name: "created_at_fr")String? createdAtFr,
    @JsonKey(name: "type_paiement")TypePaiement? typePaiement,
    @JsonKey(name: "type_ligne_credit")TypeLigneCredit? typeLigneCredit,
    @JsonKey(name: "date_fr")String? dateFr,
  }) = _LigneCredit;

  factory LigneCredit.fromJson(Map<String, dynamic> json)  => _$LigneCreditFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<LigneCredit> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(LigneCredit.fromJson(result as Map<String, dynamic>));
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
    return "id,montant,solde,etat,from_site,date_fr,code,created_at_fr,type_paiement{id,designation},type_ligne_credit{designation}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "lignecreditspaginated" : "lignecredits";
  }

}
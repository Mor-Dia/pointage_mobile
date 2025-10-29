import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class Utilisateur with _$Utilisateur {
  const Utilisateur._();
  const factory Utilisateur({
    int? id,
    String? nom,
    String? prenom,
    String? email,
    String? token,
    String? nom_complet,
    String? telephone,
    dynamic ca_souscription,
    @JsonKey(name: "current_credit") dynamic solde,
    @JsonKey(name: "type_personne_id") int? typePersonne,
  }) = _Utilisateur;

  factory Utilisateur.fromJson(Map<String, dynamic> json) =>
      _$UtilisateurFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Utilisateur> data = [];
    try {
      for (var result in json) {
        data.add(Utilisateur.fromJson(result as Map<String, dynamic>));
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs() {
    return "id,nom_complet,token,nom,prenom,type_personne_id,email,image,telephone,nb_souscription,nb_vente,nb_reservation,ca_bon,created_at_fr,current_credit";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "clientspaginated" : "clients";
  }
}

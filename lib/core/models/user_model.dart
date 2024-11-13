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
    dynamic ca_souscription,
  }) = _Utilisateur;

  factory Utilisateur.fromJson(Map<String, dynamic> json)  => _$UtilisateurFromJson(json);

}
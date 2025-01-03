// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UtilisateurImpl _$$UtilisateurImplFromJson(Map<String, dynamic> json) =>
    _$UtilisateurImpl(
      id: (json['id'] as num?)?.toInt(),
      nom: json['nom'] as String?,
      prenom: json['prenom'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      nom_complet: json['nom_complet'] as String?,
      telephone: json['telephone'] as String?,
      ca_souscription: json['ca_souscription'],
      solde: json['current_credit'],
      typePersonne: (json['type_personne_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UtilisateurImplToJson(_$UtilisateurImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'email': instance.email,
      'token': instance.token,
      'nom_complet': instance.nom_complet,
      'telephone': instance.telephone,
      'ca_souscription': instance.ca_souscription,
      'current_credit': instance.solde,
      'type_personne_id': instance.typePersonne,
    };

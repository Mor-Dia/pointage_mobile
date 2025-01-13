// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professeur_pratique_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfesseurPratiqueImpl _$$ProfesseurPratiqueImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfesseurPratiqueImpl(
      id: (json['id'] as num?)?.toInt(),
      professeur: json['professeur'] == null
          ? null
          : Professeur.fromJson(json['professeur'] as Map<String, dynamic>),
      pratique: json['pratique'] == null
          ? null
          : Pratique.fromJson(json['pratique'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProfesseurPratiqueImplToJson(
        _$ProfesseurPratiqueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'professeur': instance.professeur,
      'pratique': instance.pratique,
    };

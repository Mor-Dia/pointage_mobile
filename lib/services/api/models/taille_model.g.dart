// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taille_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaillProperties _$TaillPropertiesFromJson(Map<String, dynamic> json) =>
    TaillProperties(
      (json['id'] as num).toInt(),
      json['designation'] as String,
      json['abreviation'] as String,
    );

Map<String, dynamic> _$TaillPropertiesToJson(TaillProperties instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'abreviation': instance.abreviation,
    };

Taille _$TailleFromJson(Map<String, dynamic> json) => Taille(
      (json['taille_id'] as num).toInt(),
      TaillProperties.fromJson(json['taille'] as Map<String, dynamic>),
      (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$TailleToJson(Taille instance) => <String, dynamic>{
      'id': instance.id,
      'taille_id': instance.taille_id,
      'taille': instance.taille,
    };

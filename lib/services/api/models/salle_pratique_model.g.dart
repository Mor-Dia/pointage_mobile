// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salle_pratique_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SallePratiqueImpl _$$SallePratiqueImplFromJson(Map<String, dynamic> json) =>
    _$SallePratiqueImpl(
      id: (json['id'] as num?)?.toInt(),
      salle: json['salle'] == null
          ? null
          : Salle.fromJson(json['salle'] as Map<String, dynamic>),
      pratique: json['pratique'] == null
          ? null
          : Pratique.fromJson(json['pratique'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SallePratiqueImplToJson(_$SallePratiqueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'salle': instance.salle,
      'pratique': instance.pratique,
    };

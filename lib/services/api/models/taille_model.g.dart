// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taille_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaillPropertiesImpl _$$TaillPropertiesImplFromJson(
        Map<String, dynamic> json) =>
    _$TaillPropertiesImpl(
      id: (json['id'] as num).toInt(),
      designation: json['designation'] as String,
      abreviation: json['abreviation'] as String,
    );

Map<String, dynamic> _$$TaillPropertiesImplToJson(
        _$TaillPropertiesImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'abreviation': instance.abreviation,
    };

_$TailleImpl _$$TailleImplFromJson(Map<String, dynamic> json) => _$TailleImpl(
      id: (json['id'] as num).toInt(),
      taille_id: (json['taille_id'] as num).toInt(),
      taille: TaillProperties.fromJson(json['taille'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TailleImplToJson(_$TailleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taille_id': instance.taille_id,
      'taille': instance.taille,
    };

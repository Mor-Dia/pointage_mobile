// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_from_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserFromApiImpl _$$UserFromApiImplFromJson(Map<String, dynamic> json) =>
    _$UserFromApiImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nom_complet: json['nom_complet'] as String?,
    );

Map<String, dynamic> _$$UserFromApiImplToJson(_$UserFromApiImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nom_complet': instance.nom_complet,
    };

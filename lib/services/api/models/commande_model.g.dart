// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commande_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommandeImpl _$$CommandeImplFromJson(Map<String, dynamic> json) =>
    _$CommandeImpl(
      id: (json['id'] as num?)?.toInt(),
      total: json['total'],
      displaycoloretat: json['displaycoloretat'] as String?,
      displayetat: json['displayetat'] as String?,
      createdAtFr: json['created_at_fr'] as String?,
    );

Map<String, dynamic> _$$CommandeImplToJson(_$CommandeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'displaycoloretat': instance.displaycoloretat,
      'displayetat': instance.displayetat,
      'created_at_fr': instance.createdAtFr,
    };

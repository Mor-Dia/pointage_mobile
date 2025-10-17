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
      etat_paiement: json['etat_paiement'] as String?,
      color_etat_paiement: json['color_etat_paiement'] as String?,
      createdAtFr: json['created_at_fr'] as String?,
    );

Map<String, dynamic> _$$CommandeImplToJson(_$CommandeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'displaycoloretat': instance.displaycoloretat,
      'displayetat': instance.displayetat,
      'etat_paiement': instance.etat_paiement,
      'color_etat_paiement': instance.color_etat_paiement,
      'created_at_fr': instance.createdAtFr,
    };

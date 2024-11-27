// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ligne_credit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LigneCreditImpl _$$LigneCreditImplFromJson(Map<String, dynamic> json) =>
    _$LigneCreditImpl(
      id: (json['id'] as num?)?.toInt(),
      solde: json['solde'],
      montant: json['montant'],
      createdAtFr: json['created_at_fr'] as String?,
      typePaiement: json['type_paiement'] == null
          ? null
          : TypePaiement.fromJson(
              json['type_paiement'] as Map<String, dynamic>),
      typeLigneCredit: json['type_ligne_credit'] == null
          ? null
          : TypeLigneCredit.fromJson(
              json['type_ligne_credit'] as Map<String, dynamic>),
      dateFr: json['date_fr'] as String?,
    );

Map<String, dynamic> _$$LigneCreditImplToJson(_$LigneCreditImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'solde': instance.solde,
      'montant': instance.montant,
      'created_at_fr': instance.createdAtFr,
      'type_paiement': instance.typePaiement,
      'type_ligne_credit': instance.typeLigneCredit,
      'date_fr': instance.dateFr,
    };

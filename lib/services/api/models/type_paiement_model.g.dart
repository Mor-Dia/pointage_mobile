// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_paiement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TypePaiementImpl _$$TypePaiementImplFromJson(Map<String, dynamic> json) =>
    _$TypePaiementImpl(
      id: (json['id'] as num?)?.toInt(),
      designation: json['designation'] as String?,
      soldeDisponible: (json['solde_disponible'] as num?)?.toDouble(),
      isLigneCredit: json['is_ligne_credit'] as bool?,
    );

Map<String, dynamic> _$$TypePaiementImplToJson(_$TypePaiementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'solde_disponible': instance.soldeDisponible,
      'is_ligne_credit': instance.isLigneCredit,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_livraison_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ZoneLivraisonImpl _$$ZoneLivraisonImplFromJson(Map<String, dynamic> json) =>
    _$ZoneLivraisonImpl(
      id: (json['id'] as num?)?.toInt(),
      designation: json['designation'] as String?,
      prix: (json['prix'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ZoneLivraisonImplToJson(_$ZoneLivraisonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'prix': instance.prix,
    };

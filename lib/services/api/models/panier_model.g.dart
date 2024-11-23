// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panier_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PanierPImpl _$$PanierPImplFromJson(Map<String, dynamic> json) =>
    _$PanierPImpl(
      id: (json['id'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      panierProduit: (json['panier_produit'] as List<dynamic>?)
          ?.map((e) => PanierPProduit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PanierPImplToJson(_$PanierPImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'panier_produit': instance.panierProduit,
    };

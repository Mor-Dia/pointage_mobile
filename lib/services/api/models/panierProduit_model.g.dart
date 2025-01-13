// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panierProduit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PanierPProduitImpl _$$PanierPProduitImplFromJson(Map<String, dynamic> json) =>
    _$PanierPProduitImpl(
      id: (json['id'] as num?)?.toInt(),
      qte: (json['qte'] as num?)?.toInt(),
      prix: (json['prix'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      produit: json['produit'] == null
          ? null
          : Produit.fromJson(json['produit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PanierPProduitImplToJson(
        _$PanierPProduitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qte': instance.qte,
      'prix': instance.prix,
      'total': instance.total,
      'produit': instance.produit,
    };

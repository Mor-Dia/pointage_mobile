// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProduitImpl _$$ProduitImplFromJson(Map<String, dynamic> json) =>
    _$ProduitImpl(
      id: (json['id'] as num?)?.toInt(),
      designation: json['designation'] as String?,
      description: json['description'] as String?,
      marqueId: (json['marqueId'] as num?)?.toInt(),
      marqueDesignation: json['marqueDesignation'] as String?,
      produitTailles: json['produitTailles'] as List<dynamic>?,
      image: json['image'] as String?,
      prix: (json['prix'] as num?)?.toDouble(),
      prixSiteWebFr: (json['prixSiteWebFr'] as num?)?.toDouble(),
      familleProduitId: (json['familleProduitId'] as num?)?.toInt(),
      familleProduitDesignation: json['familleProduitDesignation'] as String?,
    );

Map<String, dynamic> _$$ProduitImplToJson(_$ProduitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'description': instance.description,
      'marqueId': instance.marqueId,
      'marqueDesignation': instance.marqueDesignation,
      'produitTailles': instance.produitTailles,
      'image': instance.image,
      'prix': instance.prix,
      'prixSiteWebFr': instance.prixSiteWebFr,
      'familleProduitId': instance.familleProduitId,
      'familleProduitDesignation': instance.familleProduitDesignation,
    };

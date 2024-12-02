// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProduitImpl _$$ProduitImplFromJson(Map<String, dynamic> json) =>
    _$ProduitImpl(
      id: (json['id'] as num?)?.toInt(),
      designation: json['designation'] as String?,
      favoris: json['favoris'] as bool?,
      description: json['description'] as String?,
      marqueId: (json['marqueId'] as num?)?.toInt(),
      marqueDesignation: json['marqueDesignation'] as String?,
      produitTailles: (json['produit_tailles'] as List<dynamic>?)
          ?.map((e) => Taille.fromJson(e as Map<String, dynamic>))
          .toList(),
      prixSiteWebFr: json['prix_site_web_fr'] as String?,
      image: json['image'] as String?,
      prix: (json['prix'] as num?)?.toDouble(),
      familleProduitId: (json['familleProduitId'] as num?)?.toInt(),
      familleProduitDesignation: json['familleProduitDesignation'] as String?,
    );

Map<String, dynamic> _$$ProduitImplToJson(_$ProduitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'favoris': instance.favoris,
      'description': instance.description,
      'marqueId': instance.marqueId,
      'marqueDesignation': instance.marqueDesignation,
      'produit_tailles': instance.produitTailles,
      'prix_site_web_fr': instance.prixSiteWebFr,
      'image': instance.image,
      'prix': instance.prix,
      'familleProduitId': instance.familleProduitId,
      'familleProduitDesignation': instance.familleProduitDesignation,
    };

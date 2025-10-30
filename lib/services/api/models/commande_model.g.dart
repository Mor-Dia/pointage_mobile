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
      venteProduits: (json['vente_produits'] as List<dynamic>?)
          ?.map((e) => VenteProduit.fromJson(e as Map<String, dynamic>))
          .toList(),
      zoneLivraison: json['zone_livraison'] == null
          ? null
          : ZoneLivraison.fromJson(
              json['zone_livraison'] as Map<String, dynamic>),
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
      'vente_produits': instance.venteProduits,
      'zone_livraison': instance.zoneLivraison,
    };

_$VenteProduitImpl _$$VenteProduitImplFromJson(Map<String, dynamic> json) =>
    _$VenteProduitImpl(
      id: (json['id'] as num?)?.toInt(),
      quantite: (json['quantite'] as num?)?.toInt(),
      total: json['total'],
      produit: json['produit'] == null
          ? null
          : Produit.fromJson(json['produit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VenteProduitImplToJson(_$VenteProduitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantite': instance.quantite,
      'total': instance.total,
      'produit': instance.produit,
    };

_$ZoneLivraisonImpl _$$ZoneLivraisonImplFromJson(Map<String, dynamic> json) =>
    _$ZoneLivraisonImpl(
      id: (json['id'] as num?)?.toInt(),
      designation: json['designation'] as String?,
      prix: json['prix'],
    );

Map<String, dynamic> _$$ZoneLivraisonImplToJson(_$ZoneLivraisonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'prix': instance.prix,
    };

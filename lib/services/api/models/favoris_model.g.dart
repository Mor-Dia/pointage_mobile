// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoris_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavorisImpl _$$FavorisImplFromJson(Map<String, dynamic> json) =>
    _$FavorisImpl(
      produits: (json['produits'] as List<dynamic>?)
          ?.map((e) => Produit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FavorisImplToJson(_$FavorisImpl instance) =>
    <String, dynamic>{
      'produits': instance.produits,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pratique_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PratiqueImpl _$$PratiqueImplFromJson(Map<String, dynamic> json) =>
    _$PratiqueImpl(
      id: (json['id'] as num?)?.toInt(),
      favoris: json['favoris'] as bool?,
      designation: json['designation'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      descriptionEn: json['description_en'] as String?,
      typePratique: json['type_pratique'] == null
          ? null
          : TypePratique.fromJson(
              json['type_pratique'] as Map<String, dynamic>),
      ca_souscription: json['ca_souscription'],
    );

Map<String, dynamic> _$$PratiqueImplToJson(_$PratiqueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'favoris': instance.favoris,
      'designation': instance.designation,
      'image': instance.image,
      'description': instance.description,
      'description_en': instance.descriptionEn,
      'type_pratique': instance.typePratique,
      'ca_souscription': instance.ca_souscription,
    };

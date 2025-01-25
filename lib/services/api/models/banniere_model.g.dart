// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banniere_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BanniereImpl _$$BanniereImplFromJson(Map<String, dynamic> json) =>
    _$BanniereImpl(
      id: (json['id'] as num?)?.toInt(),
      designation: json['designation'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$BanniereImplToJson(_$BanniereImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'image': instance.image,
    };

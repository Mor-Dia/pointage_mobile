// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SouscriptionImpl _$$SouscriptionImplFromJson(Map<String, dynamic> json) =>
    _$SouscriptionImpl(
      id: (json['id'] as num?)?.toInt(),
      client: json['client'] == null
          ? null
          : UserFromApi.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SouscriptionImplToJson(_$SouscriptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
    };

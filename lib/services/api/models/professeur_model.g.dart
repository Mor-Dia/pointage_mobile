// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professeur_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfesseurImpl _$$ProfesseurImplFromJson(Map<String, dynamic> json) =>
    _$ProfesseurImpl(
      id: (json['id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : UserFromApi.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProfesseurImplToJson(_$ProfesseurImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
    };

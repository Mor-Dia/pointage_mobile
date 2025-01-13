// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreferenceImpl _$$PreferenceImplFromJson(Map<String, dynamic> json) =>
    _$PreferenceImpl(
      id: (json['id'] as num?)?.toInt(),
      parametre: json['parametre'],
      valeur: json['valeur'],
      valeurText: json['valeur_text'],
    );

Map<String, dynamic> _$$PreferenceImplToJson(_$PreferenceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parametre': instance.parametre,
      'valeur': instance.valeur,
      'valeur_text': instance.valeurText,
    };

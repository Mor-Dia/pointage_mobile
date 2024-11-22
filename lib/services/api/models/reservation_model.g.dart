// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationImpl _$$ReservationImplFromJson(Map<String, dynamic> json) =>
    _$ReservationImpl(
      id: (json['id'] as num?)?.toInt(),
      displayetat: json['displayetat'] as String?,
      displaycoloretat: json['displaycoloretat'] as String?,
      enAttente: json['en_attente'] as String?,
      createdAtFr: json['created_at_fr'] as String?,
      programme: json['programme'] == null
          ? null
          : Programme.fromJson(json['programme'] as Map<String, dynamic>),
      souscription: json['souscription'] == null
          ? null
          : Souscription.fromJson(json['souscription'] as Map<String, dynamic>),
      ca_souscription: json['ca_souscription'],
    );

Map<String, dynamic> _$$ReservationImplToJson(_$ReservationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayetat': instance.displayetat,
      'displaycoloretat': instance.displaycoloretat,
      'en_attente': instance.enAttente,
      'created_at_fr': instance.createdAtFr,
      'programme': instance.programme,
      'souscription': instance.souscription,
      'ca_souscription': instance.ca_souscription,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationpush_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationPushImpl _$$NotificationPushImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationPushImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      content: json['content'] as String?,
      isRead: json['is_read'] as bool?,
      dataType: json['data_type'] as String?,
      dataId: (json['data_id'] as num?)?.toInt(),
      dateEmissionFr: json['date_emission_fr'] as String?,
    );

Map<String, dynamic> _$$NotificationPushImplToJson(
        _$NotificationPushImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'is_read': instance.isRead,
      'data_type': instance.dataType,
      'data_id': instance.dataId,
      'date_emission_fr': instance.dateEmissionFr,
    };

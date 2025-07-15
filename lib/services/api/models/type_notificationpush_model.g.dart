// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_notificationpush_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TypeNotificationPushImpl _$$TypeNotificationPushImplFromJson(
        Map<String, dynamic> json) =>
    _$TypeNotificationPushImpl(
      id: (json['id'] as num?)?.toInt(),
      designation: json['designation'] as String?,
      description: json['description'] as String?,
      isAllowed: json['is_allowed'] as bool?,
    );

Map<String, dynamic> _$$TypeNotificationPushImplToJson(
        _$TypeNotificationPushImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'designation': instance.designation,
      'description': instance.description,
      'is_allowed': instance.isAllowed,
    };

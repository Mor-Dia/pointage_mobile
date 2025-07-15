import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_notificationpush_model.freezed.dart';
part 'type_notificationpush_model.g.dart';

@freezed
class TypeNotificationPush with _$TypeNotificationPush {
  const TypeNotificationPush._();
  const factory TypeNotificationPush({
    int? id,
    String? designation,
    String? description,
    @JsonKey(name: "is_allowed")bool? isAllowed,
  }) = _TypeNotificationPush;

  factory TypeNotificationPush.fromJson(Map<String, dynamic> json)  => _$TypeNotificationPushFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<TypeNotificationPush> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(TypeNotificationPush.fromJson(result as Map<String, dynamic>));
      }
      if (kDebugMode) {
      }
    } catch(error, stacktrace){
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs () {
    return "id,designation,description,is_allowed";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "typenotificationpushspaginated" : "typenotificationpushs";
  }
}
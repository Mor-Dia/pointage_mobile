import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';
import 'package:yogivida_mobile/services/api/models/souscription_model.dart';

part 'notificationpush_model.freezed.dart';
part 'notificationpush_model.g.dart';

@freezed
class NotificationPush with _$NotificationPush {
  const NotificationPush._();
  const factory NotificationPush({
    int? id,
    String? title,
    String? description,
    String? content,
    @JsonKey(name: "is_read") bool? isRead,
    @JsonKey(name: "data_type") String? dataType,
    @JsonKey(name: "data_id")int? dataId,
    @JsonKey(name: "date_emission_fr")String? dateEmissionFr,
  }) = _NotificationPush;

  factory NotificationPush.fromJson(Map<String, dynamic> json)  => _$NotificationPushFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<NotificationPush> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(NotificationPush.fromJson(result as Map<String, dynamic>));
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
    return "id,title,is_read,description,content,date_emission_fr";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "notificationpushspaginated" : "notificationpushs";
  }
}
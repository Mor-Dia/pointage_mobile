import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'studio_model.freezed.dart';
part 'studio_model.g.dart';

@freezed
class Studio with _$Studio {
  const Studio._();
  const factory Studio({
    int? id,
    String? designation,
  }) = _Studio;

  factory Studio.fromJson(Map<String, dynamic> json) => _$StudioFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Studio> data = [];
    try {
      if (kDebugMode) {}

      for (var result in json) {
        data.add(Studio.fromJson(result as Map<String, dynamic>));
      }
      if (kDebugMode) {}
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs() {
    return "id,designation";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "studiospaginated" : "studios";
  }
}

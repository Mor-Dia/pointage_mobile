import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banniere_model.freezed.dart';
part 'banniere_model.g.dart';

@freezed
class Banniere with _$Banniere {
  const Banniere._();
  const factory Banniere({
    int? id,
    String? designation,
    String? image,
  }) = _Banniere;

  factory Banniere.fromJson(Map<String, dynamic> json) =>
      _$BanniereFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Banniere> data = [];
    try {
      if (kDebugMode) {}

      for (var result in json) {
        data.add(Banniere.fromJson(result as Map<String, dynamic>));
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
    return "id,designation,image";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "bannierespaginated" : "bannieres";
  }
}

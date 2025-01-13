import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'famille_model.freezed.dart';
part 'famille_model.g.dart';

@freezed
class Famille with _$Famille {
  const Famille._();
  const factory Famille({
    int? id,
    String? designation,
  }) = _Famille;

  factory Famille.fromJson(Map<String, dynamic> json) =>
      _$FamilleFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Famille> data = [];
    try {
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(Famille.fromJson(result as Map<String, dynamic>));
      }
      if (kDebugMode) {
      }
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
    return isPagination ? "familleproduitspaginated" : "familleproduits";
  }
}

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/type_pratique_model.dart';

part 'pratique_model.freezed.dart';
part 'pratique_model.g.dart';

@freezed
class Pratique with _$Pratique {
  const Pratique._();
  const factory Pratique({
    int? id,
    bool? favoris,
    String? designation,
    String? image,
    String? description,
    @JsonKey(name: "description_en") String? descriptionEn,
    @JsonKey(name: "type_pratique") TypePratique? typePratique,
    dynamic ca_souscription,
  }) = _Pratique;

  factory Pratique.fromJson(Map<String, dynamic> json) =>
      _$PratiqueFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Pratique> data = [];
    try {
      if (kDebugMode) {}

      for (var result in json) {
        data.add(Pratique.fromJson(result as Map<String, dynamic>));
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
    return "id,favoris,image,designation,description,description_en,type_pratique_id,type_pratique{id,designation}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "pratiquespaginated" : "pratiques";
  }
}

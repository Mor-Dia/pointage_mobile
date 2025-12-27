import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pointage_mobile/services/api/models/pratique_model.dart';
import 'package:pointage_mobile/services/api/models/salle_model.dart';

part 'salle_pratique_model.freezed.dart';
part 'salle_pratique_model.g.dart';

@freezed
class SallePratique with _$SallePratique {
  const SallePratique._();
  const factory SallePratique({
    int? id,
    Salle? salle,
    Pratique? pratique,
  }) = _SallePratique;

  factory SallePratique.fromJson(Map<String, dynamic> json)  => _$SallePratiqueFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<SallePratique> data = [];
    try{
      for (var result in json) {
        data.add(SallePratique.fromJson(result as Map<String, dynamic>));
      }
    } catch(error, stacktrace){
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs () {
    return "id,favoris,designation,image,description,description_en,type_pratique_id,type_pratique{id,designation}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "pratiquespaginated" : "pratiques";
  }
}
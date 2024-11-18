import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/type_pratique_model.dart';

part 'salle_model.freezed.dart';
part 'salle_model.g.dart';

@freezed
class Salle with _$Salle {
  const Salle._();
  const factory Salle({
    int? id,
    String? designation,
  }) = _Salle;

  factory Salle.fromJson(Map<String, dynamic> json)  => _$SalleFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<Salle> data = [];
    try{
      if (kDebugMode) {
        print("DOC DATA RESPONSE $json");
      }

      for (var result in json) {
        data.add(Salle.fromJson(result as Map<String, dynamic>));
      }
      if (kDebugMode) {
        print("DOC DATA RESPONSE TRANSFORMED $data");
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
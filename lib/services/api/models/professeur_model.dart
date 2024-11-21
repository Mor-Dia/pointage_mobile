import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/type_pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/user_from_api_model.dart';

part 'professeur_model.freezed.dart';
part 'professeur_model.g.dart';

@freezed
class Professeur with _$Professeur {
  const Professeur._();
  const factory Professeur({
    int? id,
    UserFromApi? user,
  }) = _Professeur;

  factory Professeur.fromJson(Map<String, dynamic> json)  => _$ProfesseurFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<Professeur> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(Professeur.fromJson(result as Map<String, dynamic>));
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
    return "id,favoris,designation,image,description,description_en,type_pratique_id,type_pratique{id,designation}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "pratiquespaginated" : "pratiques";
  }
}
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pointage_mobile/services/api/models/pratique_model.dart';
import 'package:pointage_mobile/services/api/models/professeur_model.dart';
part 'professeur_pratique_model.freezed.dart';
part 'professeur_pratique_model.g.dart';
@freezed
class ProfesseurPratique with _$ProfesseurPratique {
  const ProfesseurPratique._();
  const factory ProfesseurPratique({
    int? id,
    Professeur? professeur,
    Pratique? pratique,
  }) = _ProfesseurPratique;

  factory ProfesseurPratique.fromJson(Map<String, dynamic> json)  => _$ProfesseurPratiqueFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<ProfesseurPratique> data = [];
    try{
      for (var result in json) {
        data.add(ProfesseurPratique.fromJson(result as Map<String, dynamic>));
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
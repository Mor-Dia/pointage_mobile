import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/type_pratique_model.dart';

part 'preference_model.freezed.dart';
part 'preference_model.g.dart';

@freezed
class Preference with _$Preference {
  const Preference._();
  const factory Preference({
    int? id,
    dynamic? parametre,
    dynamic? valeur,
    @JsonKey(name: "valeur_text")dynamic? valeurText,
  }) = _Preference;

  factory Preference.fromJson(Map<String, dynamic> json)  => _$PreferenceFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<Preference> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(Preference.fromJson(result as Map<String, dynamic>));
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
    return "id,parametre,valeur,valeur_text";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "preferencespaginated" : "preferences";
  }
}
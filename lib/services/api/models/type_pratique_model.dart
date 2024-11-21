import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_pratique_model.freezed.dart';
part 'type_pratique_model.g.dart';

@freezed
class TypePratique with _$TypePratique {
  const TypePratique._();
  const factory TypePratique({
    int? id,
    String? designation,
  }) = _TypePratique;

  factory TypePratique.fromJson(Map<String, dynamic> json)  => _$TypePratiqueFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<TypePratique> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(TypePratique.fromJson(result as Map<String, dynamic>));
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
    return "id,designation";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "typepratiquespaginated" : "typepratiques";
  }
}
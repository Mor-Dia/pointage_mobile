import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_lignecredit_model.freezed.dart';
part 'type_lignecredit_model.g.dart';

@freezed
class TypeLigneCredit with _$TypeLigneCredit {
  const TypeLigneCredit._();
  const factory TypeLigneCredit({
    int? id,
    String? designation,
  }) = _TypeLigneCredit;

  factory TypeLigneCredit.fromJson(Map<String, dynamic> json)  => _$TypeLigneCreditFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<TypeLigneCredit> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(TypeLigneCredit.fromJson(result as Map<String, dynamic>));
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
    return isPagination ? "typelignecreditspaginated" : "typelignecredits";
  }
}
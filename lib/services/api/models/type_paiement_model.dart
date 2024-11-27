import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_paiement_model.freezed.dart';
part 'type_paiement_model.g.dart';

@freezed
class TypePaiement with _$TypePaiement {
  const TypePaiement._();
  const factory TypePaiement({
    int? id,
    String? designation,
  }) = _TypePaiement;

  factory TypePaiement.fromJson(Map<String, dynamic> json)  => _$TypePaiementFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<TypePaiement> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(TypePaiement.fromJson(result as Map<String, dynamic>));
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
    return isPagination ? "typepaiementspaginated" : "typepaiements";
  }
}
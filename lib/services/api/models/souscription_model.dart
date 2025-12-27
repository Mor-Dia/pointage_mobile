import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pointage_mobile/services/api/models/user_from_api_model.dart';

part 'souscription_model.freezed.dart';
part 'souscription_model.g.dart';

@freezed
class Souscription with _$Souscription {
  const Souscription._();
  const factory Souscription({
    int? id,
    UserFromApi? client,
  }) = _Souscription;

  factory Souscription.fromJson(Map<String, dynamic> json)  => _$SouscriptionFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<Souscription> data = [];
    try{
      if (kDebugMode) {
      }

      for (var result in json) {
        data.add(Souscription.fromJson(result as Map<String, dynamic>));
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
    return "id,client{id,nom_complet}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "souscriptionspaginated" : "souscriptions";
  }
}
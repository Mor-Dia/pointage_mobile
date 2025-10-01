import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone_livraison_model.freezed.dart';
part 'zone_livraison_model.g.dart';

@freezed
class ZoneLivraison with _$ZoneLivraison {
  const ZoneLivraison._();
  const factory ZoneLivraison({
    int? id,
    String? designation,
    double? prix,
  }) = _ZoneLivraison;

  factory ZoneLivraison.fromJson(Map<String, dynamic> json) =>
      _$ZoneLivraisonFromJson(json);

  static List<ZoneLivraison> fromJsonList(List<dynamic> json) {
    List<ZoneLivraison> data = [];
    try {
      for (var result in json) {
        data.add(ZoneLivraison.fromJson(result as Map<String, dynamic>));
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static String shrinkedAttributs() {
    return "id,designation,prix";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "zonelivraisonpaginated" : "zonelivraisons";
  }
}

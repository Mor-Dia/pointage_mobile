import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/programme_model.dart';
import 'package:yogivida_mobile/services/api/models/souscription_model.dart';

part 'reservation_model.freezed.dart';
part 'reservation_model.g.dart';

@freezed
class Reservation with _$Reservation {
  const Reservation._();
  const factory Reservation({
    int? id,
    String? displayetat,
    String? displaycoloretat,
    @JsonKey(name: "en_attente") String? enAttente,
    @JsonKey(name: "created_at_fr") String? createdAtFr,
    Programme? programme,
    Souscription? souscription,
    dynamic ca_souscription,
  }) = _Reservation;

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  static fromJsonList(List<dynamic> json) {
    List<Reservation> data = [];
    try {
      if (kDebugMode) {}

      for (var result in json) {
        data.add(Reservation.fromJson(result as Map<String, dynamic>));
      }
      if (kDebugMode) {}
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs() {
    return "id,etat,displayetat,displaycoloretat,with_ligne_credit,en_attente,created_at_fr,programme{id,etat,salle_pratique{salle{designation,zone{designation}}},date_fr,heure_debut,heure_fin,professeur_pratique{id,professeur_id,pratique{designation},professeur{id,user{name}},pratique_id}},souscription{id,client{id,nom_complet}}";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "reservationspaginated" : "reservations";
  }
}

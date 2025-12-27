import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pointage_mobile/services/api/models/professeur_pratique_model.dart';
import 'package:pointage_mobile/services/api/models/salle_pratique_model.dart';
part 'programme_model.freezed.dart';
part 'programme_model.g.dart';

@freezed
class Programme with _$Programme {
  const Programme._();
  const factory Programme({
    int? id,
    String? displaycoloretat,
    String? displayetat,
    @JsonKey(name: "date_fr") String? dateFr,
    @JsonKey(name: "etat") String? etat,
    String? duration,
    @JsonKey(name: "file_attente") bool? fileAttente,
    @JsonKey(name: "file_attente_display") String? fileAttenteDisplay,
    @JsonKey(name: "file_attente_color") String? fileAttenteColor,
    @JsonKey(name: "heure_debut") String? heureDebut,
    @JsonKey(name: "heure_fin") String? heureFin,
    @JsonKey(name: "professeur_pratique")
    ProfesseurPratique? professeurPratique,
    @JsonKey(name: "salle_pratique") SallePratique? sallePratique,
  }) = _Programme;

  factory Programme.fromJson(Map<String, dynamic> json) =>
      _$ProgrammeFromJson(json);

  String displayState() {
    if (fileAttente == true) {
      return "ouvert";
    }
    return "fermé";
  }

  static fromJsonList(List<dynamic> json) {
    List<Programme> data = [];
    try {
      for (var result in json) {
        data.add(Programme.fromJson(result as Map<String, dynamic>));
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs() {
    return "id,file_attente,file_attente_color,file_attente_display,duration,date_fr,heure_debut,heure_fin,etat,salle_pratique{id,salle{id,designation}},professeur_pratique{id,professeur{id,user{name}},pratique{id,designation,prix_seance}},displayetat,displaycoloretat";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "programmespaginated" : "programmes";
  }
}

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/professeur_pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/salle_pratique_model.dart';
part 'programme_model.freezed.dart';
part 'programme_model.g.dart';
// id,date,file_attente,date_fr,date_fr_day,heure_debut,heure_fin,etat,salle_pratique{id,salle_id,salle{id,designation}},professeur_pratique{id,professeur_id,pratique{designation},professeur{id,user{name}},pratique_id},contrat{id},programme_langues{id,langue_id,langue{id,designation}},programme_niveaus{id,niveau_id,niveau{id,designation}},type_personne{id},reservations{id},displayetat,displaycoloretat,user{name,image}}}}
@freezed
class Programme with _$Programme {
  const Programme._();
  const factory Programme({
    int? id,
    String? displaycoloretat,
    String? displayetat,
    @JsonKey(name: "date_fr")String? dateFr,
    @JsonKey(name: "heure_debut")String? heureDebut,
    @JsonKey(name: "heure_fin")String? heureFin,
    @JsonKey(name: "professeur_pratique")ProfesseurPratique? professeurPratique,
    @JsonKey(name: "salle_pratique")SallePratique? sallePratique,
  }) = _Programme;

  factory Programme.fromJson(Map<String, dynamic> json)  => _$ProgrammeFromJson(json);

  static fromJsonList(List <dynamic>json){
    List<Programme> data = [];
    try{
      for (var result in json) {
        data.add(Programme.fromJson(result as Map<String, dynamic>));
      }
    } catch(error, stacktrace){
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING $error $stacktrace");
      }
    }
    return data;
  }

  static shrinkedAttributs () {
    return "id,date_fr,heure_debut,heure_fin,etat,salle_pratique{id,salle{id,designation}},professeur_pratique{id,professeur{id,user{name}},pratique{id,designation}},displayetat,displaycoloretat";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "programmespaginated" : "programmes";
  }
}
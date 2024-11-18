import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yogivida_mobile/services/api/models/pratique_model.dart';
import 'package:yogivida_mobile/services/api/models/professeur_model.dart';
part 'professeur_pratique_model.freezed.dart';
part 'professeur_pratique_model.g.dart';
// id,date,file_attente,date_fr,date_fr_day,heure_debut,heure_fin,etat,salle_pratique{id,salle_id,salle{id,designation}},professeur_pratique{id,professeur_id,pratique{designation},professeur{id,user{name}},pratique_id},contrat{id},programme_langues{id,langue_id,langue{id,designation}},programme_niveaus{id,niveau_id,niveau{id,designation}},type_personne{id},reservations{id},displayetat,displaycoloretat,user{name,image}}}}
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
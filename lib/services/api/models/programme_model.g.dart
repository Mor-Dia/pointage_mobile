// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgrammeImpl _$$ProgrammeImplFromJson(Map<String, dynamic> json) =>
    _$ProgrammeImpl(
      id: (json['id'] as num?)?.toInt(),
      displaycoloretat: json['displaycoloretat'] as String?,
      displayetat: json['displayetat'] as String?,
      dateFr: json['date_fr'] as String?,
      etat: json['etat'] as String?,
      duration: json['duration'] as String?,
      fileAttente: json['file_attente'] as bool?,
      fileAttenteDisplay: json['file_attente_display'] as String?,
      fileAttenteColor: json['file_attente_color'] as String?,
      heureDebut: json['heure_debut'] as String?,
      heureFin: json['heure_fin'] as String?,
      professeurPratique: json['professeur_pratique'] == null
          ? null
          : ProfesseurPratique.fromJson(
              json['professeur_pratique'] as Map<String, dynamic>),
      sallePratique: json['salle_pratique'] == null
          ? null
          : SallePratique.fromJson(
              json['salle_pratique'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProgrammeImplToJson(_$ProgrammeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displaycoloretat': instance.displaycoloretat,
      'displayetat': instance.displayetat,
      'date_fr': instance.dateFr,
      'etat': instance.etat,
      'duration': instance.duration,
      'file_attente': instance.fileAttente,
      'file_attente_display': instance.fileAttenteDisplay,
      'file_attente_color': instance.fileAttenteColor,
      'heure_debut': instance.heureDebut,
      'heure_fin': instance.heureFin,
      'professeur_pratique': instance.professeurPratique,
      'salle_pratique': instance.sallePratique,
    };

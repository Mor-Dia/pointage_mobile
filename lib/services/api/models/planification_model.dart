import 'package:flutter/foundation.dart';

class PlanificationPersonnel {
  final int? id;
  final String? nom;
  final String? prenom;
  final String? email;
  final String? displayText;

  PlanificationPersonnel({
    this.id,
    this.nom,
    this.prenom,
    this.email,
    this.displayText,
  });

  factory PlanificationPersonnel.fromJson(Map<String, dynamic> json) {
    return PlanificationPersonnel(
      id: json['id'] as int?,
      nom: json['nom'] as String?,
      prenom: json['prenom'] as String?,
      email: json['email'] as String?,
      displayText: json['display_text'] as String?,
    );
  }
}

class PlanificationProjet {
  final int? id;
  final String? nom;

  PlanificationProjet({
    this.id,
    this.nom,
  });

  factory PlanificationProjet.fromJson(Map<String, dynamic> json) {
    return PlanificationProjet(
      id: json['id'] as int?,
      nom: json['nom'] as String?,
    );
  }
}

class PlanificationEpic {
  final int? id;
  final String? nom;

  PlanificationEpic({
    this.id,
    this.nom,
  });

  factory PlanificationEpic.fromJson(Map<String, dynamic> json) {
    return PlanificationEpic(
      id: json['id'] as int?,
      nom: json['nom'] as String?,
    );
  }
}

class PlanificationFonctionnalite {
  final int? id;
  final String? nom;
  final String? statut; // 'en_cours' ou 'cloturee'

  PlanificationFonctionnalite({
    this.id,
    this.nom,
    this.statut,
  });

  factory PlanificationFonctionnalite.fromJson(Map<String, dynamic> json) {
    return PlanificationFonctionnalite(
      id: json['id'] as int?,
      nom: json['nom'] as String?,
      statut: json['statut'] as String?,
    );
  }
}

class PlanificationTache {
  final int? id;
  final String? nom;
  final String? duree; // Durée au format HH:MM:SS depuis la base de données
  final String? statut; // 'en_cours' ou 'terminee'

  PlanificationTache({
    this.id,
    this.nom,
    this.duree,
    this.statut,
  });

  factory PlanificationTache.fromJson(Map<String, dynamic> json) {
    return PlanificationTache(
      id: json['id'] as int?,
      nom: json['nom'] as String?,
      duree: json['duree'] as String?,
      statut: json['statut'] as String?,
    );
  }
}

class PlanificationDetail {
  final int? id;
  final String? day;
  final String? description;
  final PlanificationProjet? projet;
  final PlanificationEpic? epic;
  final PlanificationFonctionnalite? fonctionnalite;
  final List<PlanificationTache>? taches;

  PlanificationDetail({
    this.id,
    this.day,
    this.description,
    this.projet,
    this.epic,
    this.fonctionnalite,
    this.taches,
  });

  factory PlanificationDetail.fromJson(Map<String, dynamic> json) {
    List<PlanificationTache> tachesList = [];
    if (json['taches'] != null) {
      final tachesJson = json['taches'] as List<dynamic>;
      tachesList =
          tachesJson.map((t) => PlanificationTache.fromJson(t)).toList();
    }

    return PlanificationDetail(
      id: json['id'] as int?,
      day: json['day'] as String?,
      description: json['description'] as String?,
      projet: json['projet'] != null
          ? PlanificationProjet.fromJson(json['projet'])
          : null,
      epic: json['epic'] != null
          ? PlanificationEpic.fromJson(json['epic'])
          : null,
      fonctionnalite: json['fonctionnalite'] != null
          ? PlanificationFonctionnalite.fromJson(json['fonctionnalite'])
          : null,
      taches: tachesList,
    );
  }
}

class Planification {
  final int? id;
  final String? dateDebut;
  final String? dateFin;
  final String? dateDebutFr;
  final String? dateFinFr;
  final dynamic personnelId; // Accepte int ou String
  final PlanificationPersonnel? personnel;
  final String? status; // 'en_cours' ou 'cloturee'
  final int? nombreTache;
  final int? nombreProjet;
  final List<PlanificationDetail> details;

  Planification({
    this.id,
    this.dateDebut,
    this.dateFin,
    this.dateDebutFr,
    this.dateFinFr,
    this.personnelId,
    this.personnel,
    this.status,
    this.nombreTache,
    this.nombreProjet,
    this.details = const [],
  });

  factory Planification.fromJson(Map<String, dynamic> json) {
    List<PlanificationDetail> detailsList = [];
    if (json['details'] != null) {
      final detailsJson = json['details'] as List<dynamic>;
      detailsList = detailsJson
          .map((detail) => PlanificationDetail.fromJson(detail))
          .toList();
    }

    return Planification(
      id: json['id'] as int?,
      dateDebut: json['date_debut'] as String?,
      dateFin: json['date_fin'] as String?,
      dateDebutFr: json['date_debut_fr'] as String?,
      dateFinFr: json['date_fin_fr'] as String?,
      personnelId: json['personnel_id'], // Accepte int ou String
      personnel: json['personnel'] != null
          ? PlanificationPersonnel.fromJson(json['personnel'])
          : null,
      status: json['status'] as String?, // 'en_cours' ou 'cloturee'
      nombreTache: json['nombre_tache'] as int?,
      nombreProjet: json['nombre_projet'] as int?,
      details: detailsList,
    );
  }

  static List<Planification> fromJsonList(List<dynamic> json) {
    List<Planification> data = [];
    try {
      for (var result in json) {
        data.add(Planification.fromJson(result as Map<String, dynamic>));
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING PLANIFICATIONS: $error $stacktrace");
      }
    }
    return data;
  }
}

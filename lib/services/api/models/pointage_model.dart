import 'package:flutter/foundation.dart';

class PointageDetail {
  final int? id;
  final String? date;
  final String? heureArrive;
  final String? heureDepart;
  final bool? retard;
  final bool? absence;
  final bool? justificatif;
  final String? description;
  final int? motifspointageId;

  PointageDetail({
    this.id,
    this.date,
    this.heureArrive,
    this.heureDepart,
    this.retard,
    this.absence,
    this.justificatif,
    this.description,
    this.motifspointageId,
  });

  factory PointageDetail.fromJson(Map<String, dynamic> json) {
    return PointageDetail(
      id: json['id'] as int?,
      date: json['date'] as String?,
      heureArrive: json['heure_arrive'] as String?,
      heureDepart: json['heure_depart'] as String?,
      retard: json['retard'] as bool? ?? false,
      absence: json['absence'] as bool? ?? false,
      justificatif: json['justificatif'] as bool? ?? false,
      description: json['description'] as String?,
      motifspointageId: json['motifspointage_id'] as int?,
    );
  }
}

class PointagePersonnel {
  final int? id;
  final String? nom;
  final String? prenom;
  final String? nomComplet;

  PointagePersonnel({
    this.id,
    this.nom,
    this.prenom,
    this.nomComplet,
  });

  factory PointagePersonnel.fromJson(Map<String, dynamic> json) {
    return PointagePersonnel(
      id: json['id'] as int?,
      nom: json['nom'] as String?,
      prenom: json['prenom'] as String?,
      nomComplet: json['nom_complet'] as String?,
    );
  }
}

class Pointage {
  final int? id;
  final String? date;
  final String? createdAt;
  final String? createdAtFr;
  final int? tempsAuBureau;
  final int? personnelId;
  final PointagePersonnel? personnel;
  final List<PointageDetail> details;

  // Champs legacy pour compatibilité (premier détail)
  String? get heureArrive =>
      details.isNotEmpty ? details.first.heureArrive : null;
  String? get heureDepart =>
      details.isNotEmpty ? details.first.heureDepart : null;
  bool? get retard => details.isNotEmpty ? details.first.retard : null;
  bool? get absence => details.isNotEmpty ? details.first.absence : null;
  String? get raison => null;
  bool? get justificatif =>
      details.isNotEmpty ? details.first.justificatif : null;
  String? get description =>
      details.isNotEmpty ? details.first.description : null;
  int? get userId => personnelId;
  String? get updatedAt => null;

  Pointage({
    this.id,
    this.date,
    this.createdAt,
    this.createdAtFr,
    this.tempsAuBureau,
    this.personnelId,
    this.personnel,
    this.details = const [],
  });

  factory Pointage.fromJson(Map<String, dynamic> json) {
    return Pointage(
      id: json['id'] as int?,
      date: json['date'] as String?,
      createdAt: json['created_at'] as String?,
      createdAtFr: json['created_at_fr'] as String?,
      tempsAuBureau: json['temps_au_bureau'] is String
          ? int.tryParse(json['temps_au_bureau'])
          : json['temps_au_bureau'] as int?,
      personnelId: json['personnel_id'] as int?,
      personnel: json['personnel'] != null
          ? PointagePersonnel.fromJson(json['personnel'])
          : null,
      details: json['details'] != null
          ? (json['details'] as List)
              .map((d) => PointageDetail.fromJson(d))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'created_at': createdAt,
      'created_at_fr': createdAtFr,
      'temps_au_bureau': tempsAuBureau,
      'personnel_id': personnelId,
      'personnel': personnel != null
          ? {
              'id': personnel!.id,
              'nom': personnel!.nom,
              'prenom': personnel!.prenom,
              'nom_complet': personnel!.nomComplet,
            }
          : null,
      'details': details
          .map((d) => {
                'id': d.id,
                'date': d.date,
                'heure_arrive': d.heureArrive,
                'heure_depart': d.heureDepart,
                'retard': d.retard,
                'absence': d.absence,
                'justificatif': d.justificatif,
                'description': d.description,
                'motifspointage_id': d.motifspointageId,
              })
          .toList(),
    };
  }

  static List<Pointage> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Pointage.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static String shrinkedAttributs() {
    return "id,date,heure_arrive,heure_depart,retard,absence,raison,justificatif,description,user_id,created_at,updated_at";
  }

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "pointagespaginated" : "pointages";
  }

  // Méthode helper pour vérifier si le pointage est en cours (pas encore de départ)
  bool get estEnCours {
    return heureDepart == null ||
        heureDepart == "00:00:00" ||
        heureDepart!.isEmpty;
  }

  // Méthode helper pour calculer la durée
  String get duree {
    if (heureArrive == null || estEnCours) return "--:--";

    try {
      final arrive = _parseTime(heureArrive!);
      final depart = _parseTime(heureDepart!);

      final duration = depart.difference(arrive);
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;

      return "${hours}h ${minutes}m";
    } catch (e) {
      return "--:--";
    }
  }

  DateTime _parseTime(String time) {
    final parts = time.split(':');
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
      parts.length > 2 ? int.parse(parts[2]) : 0,
    );
  }

  // Formater l'heure au format HH:MM
  String? formatHeure(String? heure) {
    if (heure == null || heure.isEmpty || heure == "00:00:00") return null;
    final parts = heure.split(':');
    if (parts.length >= 2) {
      return "${parts[0]}:${parts[1]}";
    }
    return heure;
  }
}

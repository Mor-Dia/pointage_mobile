import 'package:flutter/foundation.dart';

class Statistique {
  // Statistiques du jour
  final double? pourcentageJour;
  final int? joursTravailles;
  final int? joursRestants;
  
  // Statistiques des heures
  final double? heuresPointees;
  final double? objectifMensuel;
  final double? moyenneJour;
  
  // Nombre total de tâches
  final int? totalTaches;

  const Statistique({
    this.pourcentageJour,
    this.joursTravailles,
    this.joursRestants,
    this.heuresPointees,
    this.objectifMensuel,
    this.moyenneJour,
    this.totalTaches,
  });

  factory Statistique.fromJson(Map<String, dynamic> json) {
    return Statistique(
      pourcentageJour: (json['pourcentage_jour'] as num?)?.toDouble(),
      joursTravailles: json['jours_travailles'] as int?,
      joursRestants: json['jours_restants'] as int?,
      heuresPointees: (json['heures_pointees'] as num?)?.toDouble(),
      objectifMensuel: (json['objectif_mensuel'] as num?)?.toDouble(),
      moyenneJour: (json['moyenne_jour'] as num?)?.toDouble(),
      totalTaches: json['total_taches'] as int?,
    );
  }

  static Statistique fromJsonSingle(dynamic json) {
    try {
      return Statistique.fromJson(json as Map<String, dynamic>);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING STATISTIQUE $error $stacktrace");
      }
      // Retourner des statistiques par défaut en cas d'erreur
      return const Statistique(
        pourcentageJour: 92,
        joursTravailles: 18,
        joursRestants: 6,
        heuresPointees: 132,
        objectifMensuel: 160,
        moyenneJour: 7.15,
        totalTaches: 27,
      );
    }
  }

  static String getEndpoint() {
    return "dashboard/statistiques";
  }

  Map<String, dynamic> toJson() {
    return {
      'pourcentage_jour': pourcentageJour,
      'jours_travailles': joursTravailles,
      'jours_restants': joursRestants,
      'heures_pointees': heuresPointees,
      'objectif_mensuel': objectifMensuel,
      'moyenne_jour': moyenneJour,
      'total_taches': totalTaches,
    };
  }
}

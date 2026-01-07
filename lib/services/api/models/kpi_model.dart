/// Modèle pour les données du personnel dans la réponse KPI
class KpiPersonnel {
  final int id;
  final String nom;
  final String prenom;
  final String email;

  KpiPersonnel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  String get displayText => '$prenom $nom';

  factory KpiPersonnel.fromJson(Map<String, dynamic> json) {
    return KpiPersonnel(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

/// Modèle pour les données KPI (semaine, mois, année)
class KpiData {
  final int nombreTotalFonctionnalites;
  final double tauxReouverture;
  final double tauxRespectDelais;
  final double totalHeuresPerdues;
  final int nombreAbsences;
  final int nombreRetards;
  final KpiPersonnel? personnel;
  final String periode; // 'semaine', 'mois', 'annee'

  KpiData({
    required this.nombreTotalFonctionnalites,
    required this.tauxReouverture,
    required this.tauxRespectDelais,
    required this.totalHeuresPerdues,
    required this.nombreAbsences,
    required this.nombreRetards,
    this.personnel,
    required this.periode,
  });

  /// Factory pour créer un KpiData depuis JSON
  factory KpiData.fromJson(Map<String, dynamic> json, String periode) {
    return KpiData(
      nombreTotalFonctionnalites: json['nombre_total_fonctionnalites'] ?? 0,
      tauxReouverture: _parseDouble(json['taux_reouverture']),
      tauxRespectDelais: _parseDouble(json['taux_respect_delais']),
      totalHeuresPerdues: _parseDouble(json['total_heures_perdues']),
      nombreAbsences: json['nombre_absences'] ?? 0,
      nombreRetards: json['nombre_retards'] ?? 0,
      personnel: json['personnel'] != null
          ? KpiPersonnel.fromJson(json['personnel'])
          : null,
      periode: periode,
    );
  }

  /// Helper pour parser les valeurs numériques qui peuvent être int ou double
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  /// Formate le taux de réouverture en pourcentage (ex: 75.5%)
  String get tauxReouvertureFormatted =>
      '${tauxReouverture.toStringAsFixed(1)}%';

  /// Formate le taux de respect des délais en pourcentage (ex: 44.4%)
  String get tauxRespectDelaisFormatted =>
      '${tauxRespectDelais.toStringAsFixed(1)}%';

  /// Formate les heures perdues (ex: 0.07h)
  String get totalHeuresPerduesFormatted =>
      '${totalHeuresPerdues.toStringAsFixed(2)}h';
}

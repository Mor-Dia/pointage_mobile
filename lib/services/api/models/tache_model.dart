import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Tache {
  final int? id;
  final String? titre;
  final String? description;
  final String? date;
  final String? dateFr;
  final String? status;
  final String? lienTest;
  final String? lienProd;
  final int? nombreCollaborateurs;
  final String? createdAt;
  final String? updatedAt;

  const Tache({
    this.id,
    this.titre,
    this.description,
    this.date,
    this.dateFr,
    this.status,
    this.lienTest,
    this.lienProd,
    this.nombreCollaborateurs,
    this.createdAt,
    this.updatedAt,
  });

  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
      id: json['id'] as int?,
      titre: json['titre'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
      dateFr: json['date_fr'] as String?,
      status: json['status'] as String?,
      lienTest: json['lien_test'] as String?,
      lienProd: json['lien_prod'] as String?,
      nombreCollaborateurs: json['nombre_collaborateurs'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  static List<Tache> fromJsonList(List<dynamic> json) {
    List<Tache> data = [];
    try {
      for (var result in json) {
        data.add(Tache.fromJson(result as Map<String, dynamic>));
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("ERROR WHILE TRANSFORMING TACHE $error $stacktrace");
      }
    }
    return data;
  }

  String getStatusLabel() {
    switch (status) {
      case "en_cours":
        return "En cours";
      case "terminee":
      case "clôturée":
        return "Terminée";
      case "en_attente":
        return "En attente";
      default:
        return "Inconnu";
    }
  }

  Color getStatusColor() {
    switch (status) {
      case "en_cours":
        return const Color(0xFFFEF3C7);
      case "terminee":
      case "clôturée":
        return const Color(0xFFE5E7EB);
      case "en_attente":
        return const Color(0xFFDCFCE7);
      default:
        return const Color(0xFFF3F4F6);
    }
  }

  Color getStatusTextColor() {
    switch (status) {
      case "en_cours":
        return const Color(0xFFD97706);
      case "terminee":
      case "clôturée":
        return const Color(0xFF6B7280);
      case "en_attente":
        return const Color(0xFF059669);
      default:
        return const Color(0xFF6B7280);
    }
  }

  bool isEnCours() => status == "en_cours";
  bool isTerminee() => status == "terminee" || status == "clôturée";
  bool isEnAttente() => status == "en_attente";
  bool canBeClosed() => isEnCours();

  static String getEndpoint({bool isPagination = true}) {
    return isPagination ? "tachespaginated" : "taches";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'date': date,
      'date_fr': dateFr,
      'status': status,
      'lien_test': lienTest,
      'lien_prod': lienProd,
      'nombre_collaborateurs': nombreCollaborateurs,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

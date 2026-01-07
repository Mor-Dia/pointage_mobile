import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import 'api/models/kpi_model.dart';

class KpiService {
  /// Récupère les KPI de la semaine en cours
  Future<KpiData> getKpiSemaine() async {
    try {
      // Récupérer le token et l'email de l'utilisateur connecté
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      // Extraire l'email depuis userinfos
      String? personnelEmail;
      final userinfosString = prefs.getString('userinfos');
      if (userinfosString != null && userinfosString.isNotEmpty) {
        try {
          final userinfos = json.decode(userinfosString);
          personnelEmail = userinfos['data']?['email'];
        } catch (e) {
          print('❌ Erreur lors du décodage de userinfos: $e');
        }
      }

      print('🔄 Récupération des KPI de la semaine pour: $personnelEmail');

      // Construire l'URI avec le paramètre personnel_email
      Uri uri = Uri.parse('${BASE_URL}kpi-semaine');
      if (personnelEmail != null && personnelEmail.isNotEmpty) {
        uri = uri.replace(queryParameters: {
          'personnel_email': personnelEmail,
        });
      }

      print('   depuis: $uri');

      // Appel API
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
      );

      print('📡 Statut réponse KPI semaine: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Vérifier le format de la réponse
        if (jsonResponse['success'] == true && jsonResponse['kpi'] != null) {
          // Fusionner kpi et personnel dans un seul objet pour le modèle
          final dataForModel = <String, dynamic>{
            ...(jsonResponse['kpi'] as Map<String, dynamic>),
            'personnel': jsonResponse['personnel'],
          };
          final kpiData = KpiData.fromJson(dataForModel, 'semaine');
          print(
              '✅ KPI semaine récupéré: ${kpiData.nombreTotalFonctionnalites} fonctionnalités');
          return kpiData;
        } else {
          throw Exception('Format de réponse invalide');
        }
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erreur lors de la récupération des KPI semaine: $e');
      rethrow;
    }
  }

  /// Récupère les KPI du mois spécifié
  /// [mois] : numéro du mois (1-12), par défaut le mois en cours
  /// [annee] : année (ex: 2026), par défaut l'année en cours
  Future<KpiData> getKpiMois({int? mois, int? annee}) async {
    try {
      // Récupérer le token et l'email de l'utilisateur connecté
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      // Extraire l'email depuis userinfos
      String? personnelEmail;
      final userinfosString = prefs.getString('userinfos');
      if (userinfosString != null && userinfosString.isNotEmpty) {
        try {
          final userinfos = json.decode(userinfosString);
          personnelEmail = userinfos['data']?['email'];
        } catch (e) {
          print('❌ Erreur lors du décodage de userinfos: $e');
        }
      }

      // Utiliser le mois/année actuel si non spécifié
      final now = DateTime.now();
      final moisParam = mois ?? now.month;
      final anneeParam = annee ?? now.year;

      print(
          '🔄 Récupération des KPI du mois $moisParam/$anneeParam pour: $personnelEmail');

      // Construire l'URI avec les paramètres
      Uri uri = Uri.parse('${BASE_URL}kpi-mois');
      final queryParams = <String, String>{
        'mois': moisParam.toString(),
        'annee': anneeParam.toString(),
      };
      if (personnelEmail != null && personnelEmail.isNotEmpty) {
        queryParams['personnel_email'] = personnelEmail;
      }
      uri = uri.replace(queryParameters: queryParams);

      print('   depuis: $uri');

      // Appel API
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
      );

      print('📡 Statut réponse KPI mois: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Vérifier le format de la réponse
        if (jsonResponse['success'] == true && jsonResponse['kpi'] != null) {
          // Fusionner kpi et personnel dans un seul objet pour le modèle
          final dataForModel = <String, dynamic>{
            ...(jsonResponse['kpi'] as Map<String, dynamic>),
            'personnel': jsonResponse['personnel'],
          };
          final kpiData = KpiData.fromJson(dataForModel, 'mois');
          print(
              '✅ KPI mois récupéré: ${kpiData.nombreTotalFonctionnalites} fonctionnalités');
          return kpiData;
        } else {
          throw Exception('Format de réponse invalide');
        }
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erreur lors de la récupération des KPI mois: $e');
      rethrow;
    }
  }

  /// Récupère les KPI de l'année spécifiée
  /// [annee] : année (ex: 2026), par défaut l'année en cours
  Future<KpiData> getKpiAnnee({int? annee}) async {
    try {
      // Récupérer le token et l'email de l'utilisateur connecté
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      // Extraire l'email depuis userinfos
      String? personnelEmail;
      final userinfosString = prefs.getString('userinfos');
      if (userinfosString != null && userinfosString.isNotEmpty) {
        try {
          final userinfos = json.decode(userinfosString);
          personnelEmail = userinfos['data']?['email'];
        } catch (e) {
          print('❌ Erreur lors du décodage de userinfos: $e');
        }
      }

      // Utiliser l'année actuelle si non spécifié
      final now = DateTime.now();
      final anneeParam = annee ?? now.year;

      print(
          '🔄 Récupération des KPI de l\'année $anneeParam pour: $personnelEmail');

      // Construire l'URI avec les paramètres
      Uri uri = Uri.parse('${BASE_URL}kpi-annee');
      final queryParams = <String, String>{
        'annee': anneeParam.toString(),
      };
      if (personnelEmail != null && personnelEmail.isNotEmpty) {
        queryParams['personnel_email'] = personnelEmail;
      }
      uri = uri.replace(queryParameters: queryParams);

      print('   depuis: $uri');

      // Appel API
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
      );

      print('📡 Statut réponse KPI année: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Vérifier le format de la réponse
        if (jsonResponse['success'] == true && jsonResponse['kpi'] != null) {
          // Fusionner kpi et personnel dans un seul objet pour le modèle
          final dataForModel = <String, dynamic>{
            ...(jsonResponse['kpi'] as Map<String, dynamic>),
            'personnel': jsonResponse['personnel'],
          };
          final kpiData = KpiData.fromJson(dataForModel, 'annee');
          print(
              '✅ KPI année récupéré: ${kpiData.nombreTotalFonctionnalites} fonctionnalités');
          return kpiData;
        } else {
          throw Exception('Format de réponse invalide');
        }
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erreur lors de la récupération des KPI année: $e');
      rethrow;
    }
  }

  /// Récupère tous les KPI en une seule fois (semaine, mois, année)
  Future<Map<String, KpiData>> getAllKpis({int? mois, int? annee}) async {
    try {
      // Récupérer les 3 KPI en parallèle
      final results = await Future.wait([
        getKpiSemaine(),
        getKpiMois(mois: mois, annee: annee),
        getKpiAnnee(annee: annee),
      ]);

      return {
        'semaine': results[0],
        'mois': results[1],
        'annee': results[2],
      };
    } catch (e) {
      print('❌ Erreur lors de la récupération de tous les KPI: $e');
      rethrow;
    }
  }
}

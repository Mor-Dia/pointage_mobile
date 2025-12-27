import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import 'api/models/planification_model.dart';

class PlanificationService {
  /// Récupère la liste des planifications depuis le backend
  Future<List<Planification>> getPlanifications() async {
    try {
      // Récupérer le token et l'email de l'utilisateur connecté
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      // Extraire l'email depuis userinfos pour filtrer les planifications
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

      print('🔄 Récupération des planifications pour: $personnelEmail');

      // Construire l'URI avec le paramètre personnel_email si disponible
      Uri uri = Uri.parse('${BASE_URL}planifications-mobile');
      if (personnelEmail != null && personnelEmail.isNotEmpty) {
        uri = uri.replace(queryParameters: {
          'personnel_email': personnelEmail,
        });
      }

      print('   🌐 Planifications depuis: $uri');

      // Appel API
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true', // Nécessaire pour ngrok
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
      );

      print('📡 Statut réponse planifications: ${response.statusCode}');
      print('📄 Corps réponse planifications: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Vérifier le format de la réponse
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final List<dynamic> planificationsJson = jsonResponse['data'];

          // Convertir directement avec le modèle
          final planifications = Planification.fromJsonList(planificationsJson);

          print('✅ ${planifications.length} planifications récupérées');
          return planifications;
        } else {
          throw Exception('Format de réponse invalide');
        }
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erreur lors de la récupération des planifications: $e');
      rethrow;
    }
  }
}
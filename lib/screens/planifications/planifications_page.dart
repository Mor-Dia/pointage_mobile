import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../constant.dart';
import '../../services/api/models/planification_model.dart';
import '../../services/planification_service.dart';

class PlanificationsPage extends StatefulWidget {
  const PlanificationsPage({Key? key}) : super(key: key);

  @override
  State<PlanificationsPage> createState() => _PlanificationsPageState();
}

class _PlanificationsPageState extends State<PlanificationsPage> {
  final TextEditingController _searchController = TextEditingController();
  final PlanificationService _planificationService = PlanificationService();

  // Future pour charger les données
  late Future<List<Planification>> _planificationsFuture;
  int _planificationsCount = 0;

  @override
  void initState() {
    super.initState();
    print('🚀 Initialisation de l\'écran Planifications');
    _planificationsFuture = _loadPlanifications();
  }

  Future<List<Planification>> _loadPlanifications() async {
    print('📋 Chargement des planifications...');
    final planifications = await _planificationService.getPlanifications();
    setState(() {
      // Compter le nombre total de détails dans toutes les planifications
      _planificationsCount = planifications.fold<int>(
        0,
        (sum, planification) => sum + planification.details.length,
      );
    });
    print('✅ ${planifications.length} planifications chargées avec $_planificationsCount détails');
    return planifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header personnalisé
            _buildHeader(),
            
            // Contenu principal
            Expanded(
              child: FutureBuilder<List<Planification>>(
                future: _planificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/planning.svg',
                            width: 80,
                            height: 80,
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Erreur de chargement',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Impossible de récupérer vos planifications',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _planificationsFuture = _loadPlanifications();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Réessayer'),
                          ),
                        ],
                      ),
                    );
                  }

                  final planifications = snapshot.data ?? [];

                  if (planifications.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/planning.svg',
                            width: 80,
                            height: 80,
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Aucune planification',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Vous n\'avez aucune planification pour le moment',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        _planificationsFuture = _loadPlanifications();
                      });
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: planifications.length,
                      itemBuilder: (context, index) {
                        final planification = planifications[index];
                        return _buildPlanificationCard(planification);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/planning.svg',
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Mes Planifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_planificationsCount tâches',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanificationCard(Planification planification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header de la planification
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Planification #${planification.id}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (planification.dateDebutFr != null && planification.dateFinFr != null)
                        Text(
                          'Du ${planification.dateDebutFr} au ${planification.dateFinFr}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${planification.details.length} tâches',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Détails de la planification
          if (planification.details.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...planification.details.map((detail) => _buildDetailItem(detail)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(PlanificationDetail detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(
            width: 4,
            color: primaryColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Projet
          if (detail.projet?.nom != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.folder,
                    size: 16,
                    color: Color(0xFF666666),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      detail.projet!.nom!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Epic (s'il existe)
          if (detail.epic?.nom != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.timeline,
                    size: 14,
                    color: Color(0xFF888888),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Epic: ${detail.epic!.nom}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),

          // Fonctionnalité (en vert comme demandé)
          if (detail.fonctionnalite?.nom != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.extension,
                    size: 14,
                    color: Color(0xFF4CAF50), // Vert pour les fonctionnalités
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      detail.fonctionnalite!.nom!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4CAF50), // Vert pour les fonctionnalités
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Tâches (en noir comme demandé)
          if (detail.taches != null && detail.taches!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 14,
                      color: Color(0xFF333333), // Noir pour les tâches
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Tâches:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333), // Noir pour les tâches
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ...detail.taches!.map((tache) => Padding(
                  padding: const EdgeInsets.only(left: 22, bottom: 2),
                  child: Text(
                    '• ${tache.nom}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF333333), // Noir pour les tâches
                    ),
                  ),
                )),
              ],
            ),

          // Description
          if (detail.description != null && detail.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                detail.description!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
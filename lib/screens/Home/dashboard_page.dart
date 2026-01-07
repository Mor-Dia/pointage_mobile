import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:pointage_mobile/core/models/user_model.dart';
import 'package:pointage_mobile/services/authentication_bloc/authentication_bloc.dart';
import '../../services/kpi_service.dart';
import '../../services/api/models/kpi_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final KpiService _kpiService = KpiService();

  KpiData? _kpiSemaine;
  KpiData? _kpiMois;
  KpiData? _kpiAnnee;

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadKpis();
  }

  /// Charge tous les KPI (semaine, mois, année)
  Future<void> _loadKpis() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final kpis = await _kpiService.getAllKpis();

      setState(() {
        _kpiSemaine = kpis['semaine'];
        _kpiMois = kpis['mois'];
        _kpiAnnee = kpis['annee'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors du chargement des statistiques: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadKpis,
                            child: const Text('Réessayer'),
                          ),
                        ],
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _loadKpis,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header avec avatar, nom et notification
                            _buildHeader(),
                            const SizedBox(height: 24),

                            // KPI Semaine
                            if (_kpiSemaine != null)
                              _buildKpiCard(_kpiSemaine!, 'Cette Semaine',
                                  Icons.calendar_today, Colors.blue),
                            const SizedBox(height: 16),

                            // KPI Mois
                            if (_kpiMois != null)
                              _buildKpiCard(_kpiMois!, 'Ce Mois',
                                  Icons.calendar_month, Colors.green),
                            const SizedBox(height: 16),

                            // KPI Année
                            if (_kpiAnnee != null)
                              _buildKpiCard(_kpiAnnee!, 'Cette Année',
                                  Icons.date_range, Colors.orange),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<AuthenticationBloc<Utilisateur>,
        AuthenticationState<Utilisateur>>(
      builder: (context, state) {
        // Récupérer le nom de l'utilisateur connecté
        String userName = 'Utilisateur';

        if (state.status == AuthenticationStatus.authenticated &&
            state.user != null) {
          if (state.user!.nom_complet != null &&
              state.user!.nom_complet!.isNotEmpty) {
            userName = state.user!.nom_complet!;
          } else if (state.user!.prenom != null && state.user!.nom != null) {
            userName = '${state.user!.prenom} ${state.user!.nom}';
          } else {
            userName = state.user!.email ?? 'Utilisateur';
          }

          // Extraire le prénom pour le salut
          final prenom = state.user!.prenom ?? userName.split(' ').first;
          userName = prenom;
        }

        return Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 32, color: Colors.grey[600]),
            ),
            const SizedBox(width: 12),
            // Nom
            Expanded(
              child: Text(
                'Salut, $userName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),
            // Icône notification
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                'assets/icons/notification1.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2D3748),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Construit une carte KPI avec toutes les statistiques
  Widget _buildKpiCard(KpiData kpi, String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de la carte
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // Nombre total de fonctionnalités
            _buildKpiRow(
              icon: Icons.functions,
              label: 'Total fonctionnalités',
              value: kpi.nombreTotalFonctionnalites.toString(),
              color: Colors.blue,
            ),
            const SizedBox(height: 12),

            // Taux de réouverture
            _buildKpiRow(
              icon: Icons.refresh,
              label: 'Taux de réouverture',
              value: kpi.tauxReouvertureFormatted,
              color: kpi.tauxReouverture > 50 ? Colors.red : Colors.orange,
            ),
            const SizedBox(height: 12),

            // Taux de respect des délais
            _buildKpiRow(
              icon: Icons.check_circle,
              label: 'Respect des délais',
              value: kpi.tauxRespectDelaisFormatted,
              color: kpi.tauxRespectDelais > 70 ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 12),

            // Total heures perdues
            _buildKpiRow(
              icon: Icons.access_time,
              label: 'Heures perdues',
              value: kpi.totalHeuresPerduesFormatted,
              color: kpi.totalHeuresPerdues > 0 ? Colors.red : Colors.grey,
            ),
            const SizedBox(height: 12),

            // Nombre d'absences
            _buildKpiRow(
              icon: Icons.event_busy,
              label: 'Absences',
              value: kpi.nombreAbsences.toString(),
              color: kpi.nombreAbsences > 0 ? Colors.orange : Colors.grey,
            ),
            const SizedBox(height: 12),

            // Nombre de retards
            _buildKpiRow(
              icon: Icons.schedule,
              label: 'Retards',
              value: kpi.nombreRetards.toString(),
              color: kpi.nombreRetards > 0 ? Colors.red : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  /// Ligne de statistique avec icône, label et valeur
  Widget _buildKpiRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

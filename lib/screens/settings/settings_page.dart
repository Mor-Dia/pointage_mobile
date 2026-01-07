import 'package:flutter/material.dart';
import '../../services/kpi_service.dart';
import '../../services/api/models/kpi_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
      appBar: AppBar(
        title: const Text('Statistiques'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadKpis,
            tooltip: 'Actualiser',
          ),
        ],
      ),
      body: _isLoading
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
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      // En-tête
                      const Text(
                        'Mes Performances',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Suivez vos indicateurs de performance',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
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
          ],
        ),
      ),
    );
  }

  /// Construit une ligne de KPI avec icône, label et valeur
  Widget _buildKpiRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

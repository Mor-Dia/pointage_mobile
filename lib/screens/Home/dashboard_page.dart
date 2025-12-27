import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:pointage_mobile/core/models/user_model.dart';
import 'package:pointage_mobile/services/authentication_bloc/authentication_bloc.dart';
import 'package:pointage_mobile/services/pointage_service.dart';
import 'package:pointage_mobile/services/api/models/pointage_model.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PointageService _pointageService = PointageService();
  List<Pointage> _pointages = [];
  bool _isLoading = true;
  String _selectedPeriod = 'semaine'; // 'semaine' ou 'mois'

  @override
  void initState() {
    super.initState();
    _loadPointages();
  }

  Future<void> _loadPointages() async {
    try {
      setState(() => _isLoading = true);
      final pointages = await _pointageService.getPointages();
      setState(() {
        _pointages = pointages;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Erreur chargement pointages: $e');
      setState(() => _isLoading = false);
    }
  }

  // Calculer les statistiques
  Map<String, dynamic> _calculateStats() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonth = DateTime(now.year, now.month, 1);

    int retardsSemaine = 0;
    int absencesSemaine = 0;
    int retardsMois = 0;
    int absencesMois = 0;

    for (var pointage in _pointages) {
      if (pointage.date == null) continue;
      final date = DateTime.parse(pointage.date!);

      for (var detail in pointage.details) {
        if (detail.retard == true) {
          if (date.isAfter(startOfWeek)) retardsSemaine++;
          if (date.isAfter(startOfMonth)) retardsMois++;
        }
        if (detail.absence == true) {
          if (date.isAfter(startOfWeek)) absencesSemaine++;
          if (date.isAfter(startOfMonth)) absencesMois++;
        }
      }
    }

    // TEMPORAIRE : Utiliser toujours les données de démo pour la présentation
    // Quand vous aurez de vrais pointages avec retards, commentez ce bloc
    return {
      'retardsSemaine': 3,
      'absencesSemaine': 2,
      'retardsMois': 3,
      'absencesMois': 2,
    };

    /* VERSION AVEC DONNÉES RÉELLES (à décommenter plus tard)
    // Si pas de données réelles, utiliser des données de démo (comme dans la maquette)
    if (retardsSemaine == 0 && absencesSemaine == 0 && 
        retardsMois == 0 && absencesMois == 0) {
      return {
        'retardsSemaine': 3,
        'absencesSemaine': 2,
        'retardsMois': 3,
        'absencesMois': 2,
      };
    }

    return {
      'retardsSemaine': retardsSemaine,
      'absencesSemaine': absencesSemaine,
      'retardsMois': retardsMois,
      'absencesMois': absencesMois,
    };
    */
  }

  // Calculer les données d'efficience par jour
  List<Map<String, dynamic>> _calculateEfficienceData() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    
    List<Map<String, dynamic>> weekData = [];
    final daysOfWeek = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
    
    // Données de démonstration (similaires à la maquette)
    final demoData = [
      {'raites': 56, 'rouvertes': 39},  // Lundi
      {'raites': 64, 'rouvertes': 80},  // Mardi
      {'raites': 76, 'rouvertes': 15},  // Mercredi
      {'raites': 78, 'rouvertes': 17},  // Jeudi
      {'raites': 70, 'rouvertes': 65},  // Vendredi
      {'raites': 37, 'rouvertes': 15},  // Samedi
    ];
    
    for (int i = 0; i < 6; i++) {
      final date = startOfWeek.add(Duration(days: i));
      final pointagesOfDay = _pointages.where((p) {
        if (p.date == null) return false;
        final pDate = DateTime.parse(p.date!);
        return pDate.year == date.year && 
               pDate.month == date.month && 
               pDate.day == date.day;
      }).toList();

      // Compter les pointages à l'heure (sans retard ni absence)
      int raitesCount = 0;
      for (var p in pointagesOfDay) {
        for (var d in p.details) {
          if (d.retard == false && d.absence == false) {
            raitesCount++;
          }
        }
      }
      
      // Compter les retards
      int rouvertesCount = 0;
      for (var p in pointagesOfDay) {
        for (var d in p.details) {
          if (d.retard == true) {
            rouvertesCount++;
          }
        }
      }

      // Si pas de données réelles, utiliser les données de démo
      // Sinon utiliser les données réelles
      int raitesValue;
      int rouvertesValue;
      
      if (raitesCount == 0 && rouvertesCount == 0) {
        // Pas de données réelles, utiliser les données de démo
        raitesValue = demoData[i]['raites']!;
        rouvertesValue = demoData[i]['rouvertes']!;
      } else {
        // Utiliser les données réelles
        raitesValue = raitesCount;
        rouvertesValue = rouvertesCount;
      }

      weekData.add({
        'day': daysOfWeek[i],
        'raites': raitesValue,
        'rouvertes': rouvertesValue,
      });
    }
    
    return weekData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadPointages,
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

                        // Section Retards - Absences
                        _buildRetardsAbsencesSection(),
                        const SizedBox(height: 24),

                        // Section Efficience
                        _buildEfficienceSection(),
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
        String subtitle = 'Bienvenu mr le lead front';
        
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
            // Nom et sous-titre
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Salut, $userName',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
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
                color: const Color(0xFF2D3748),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRetardsAbsencesSection() {
    final stats = _calculateStats();
    final isWeek = _selectedPeriod == 'semaine';
    final retards = isWeek ? stats['retardsSemaine'] : stats['retardsMois'];
    final absences = isWeek ? stats['absencesSemaine'] : stats['absencesMois'];

    // Calcul des dates pour l'affichage
    final now = DateTime.now();
    String dateRange;
    String monthRange;
    
    if (isWeek) {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      dateRange = 'Du ${startOfWeek.day} - Aujourd\'hui';
    } else {
      dateRange = 'Du 01 Décembre - Aujourd\'hui';
    }
    
    monthRange = 'Du 01 Décembre - Aujourd\'hui';

    // Calculer les pourcentages (sur une base de 30 jours de travail)
    final totalDaysWeek = 5; // 5 jours de travail par semaine
    final totalDaysMonth = 22; // ~22 jours de travail par mois
    final retardPercentage = isWeek 
        ? (retards / totalDaysWeek * 100).round()
        : (retards / totalDaysMonth * 100).round();
    final absencePercentage = isWeek
        ? (absences / totalDaysWeek * 100).round()
        : (absences / totalDaysMonth * 100).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre avec icône filtre
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/notification1.svg',
                width: 20,
                height: 20,
                color: const Color(0xFF2D3748),
              ),
              const SizedBox(width: 8),
              const Text(
                'Retards - Absences',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sélecteur de période
          Row(
            children: [
              _buildPeriodChip('Cette semaine', 'semaine'),
              const SizedBox(width: 12),
              _buildPeriodChip('Ce mois', 'mois'),
            ],
          ),
          const SizedBox(height: 16),

          // Date range
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Color(0xFF14B8A6)),
              const SizedBox(width: 6),
              Text(
                dateRange,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF14B8A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Statistiques
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  label: '$retards retards',
                  color: const Color(0xFFFBBF24),
                  borderColor: const Color(0xFFFBBF24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  label: '$absences absences',
                  color: const Color(0xFFEF4444),
                  borderColor: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Section "Ce mois"
          const Row(
            children: [
              Icon(Icons.access_time_filled, size: 16, color: Color(0xFF14B8A6)),
              SizedBox(width: 6),
              Text(
                'Ce mois',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF14B8A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Color(0xFF14B8A6)),
              const SizedBox(width: 6),
              Text(
                monthRange,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF14B8A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Pourcentages mensuels
          Row(
            children: [
              Expanded(
                child: _buildPercentageCard(
                  percentage: '$retardPercentage%',
                  backgroundColor: const Color(0xFFFEF3C7),
                  textColor: const Color(0xFFD97706),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPercentageCard(
                  percentage: '$absencePercentage%',
                  backgroundColor: const Color(0xFFFEE2E2),
                  textColor: const Color(0xFFDC2626),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodChip(String label, String value) {
    final isSelected = _selectedPeriod == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPeriod = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF14B8A6) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: const Color(0xFF14B8A6),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF14B8A6),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required Color color,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildPercentageCard({
    required String percentage,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        percentage,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildEfficienceSection() {
    final efficienceData = _calculateEfficienceData();
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final dateRange = 'Du ${startOfWeek.day} - Aujourd\'hui';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre avec icône filtre
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bar_chart.svg',
                width: 20,
                height: 20,
                color: const Color(0xFF2D3748),
              ),
              const SizedBox(width: 8),
              const Text(
                'Efficience',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Sélecteur de période
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF14B8A6), width: 1),
            ),
            child: const Text(
              'Cette semaine',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF14B8A6),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Date range
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Color(0xFF14B8A6)),
              const SizedBox(width: 6),
              Text(
                dateRange,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF14B8A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Graphique en barres
          _buildBarChart(efficienceData),
          const SizedBox(height: 16),

          // Légende
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Raites dans les délais', const Color(0xFF10B981)),
              const SizedBox(width: 20),
              _buildLegendItem('Rouvertes', const Color(0xFFFBBF24)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<Map<String, dynamic>> data) {
    final maxValue = data.fold<int>(
      0,
      (prev, item) => [prev, item['raites'] as int, item['rouvertes'] as int]
          .reduce((a, b) => a > b ? a : b),
    );

    // Si maxValue est 0, utiliser 100 comme valeur par défaut pour éviter division par zéro
    final safeMaxValue = maxValue > 0 ? maxValue : 100;

    // Calculer les intervalles pour l'axe Y (0, 20, 40, 60, 80, 100)
    final yAxisLabels = [100, 80, 60, 40, 20, 0];

    return SizedBox(
      height: 220, // Réduit pour éviter l'overflow
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Axe Y (labels verticaux à gauche avec ligne verticale)
          SizedBox(
            width: 35,
            child: Stack(
              children: [
                // Ligne verticale
                Positioned(
                  right: 0,
                  top: 10,
                  bottom: 22,
                  child: Container(
                    width: 1,
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                // Labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10), // Espace pour les valeurs au-dessus des barres
                    ...yAxisLabels.map((label) => Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            '$label',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                      ),
                    )).toList(),
                    const SizedBox(height: 22), // Espace pour les labels des jours
                  ],
                ),
              ],
            ),
          ),
          // Zone des barres avec ligne de base
          Expanded(
            child: Stack(
              children: [
                // Ligne horizontale en bas (axe X)
                Positioned(
                  bottom: 22, // Position juste au-dessus des labels des jours
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 1,
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                // Barres avec labels
                Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: data.map((dayData) {
                          return _buildBarGroup(
                            day: dayData['day'],
                            raites: dayData['raites'],
                            rouvertes: dayData['rouvertes'],
                            maxValue: safeMaxValue,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarGroup({
    required String day,
    required int raites,
    required int rouvertes,
    required int maxValue,
  }) {
    // Éviter division par zéro et valeurs NaN
    // Hauteur maximale réduite à 100px pour s'adapter au nouveau conteneur
    final raitesHeight = raites > 0 
        ? (maxValue > 0 ? (raites / maxValue * 100).toDouble().clamp(4.0, 100.0) : 4.0)
        : 0.0;
    final rouvertesHeight = rouvertes > 0 
        ? (maxValue > 0 ? (rouvertes / maxValue * 100).toDouble().clamp(4.0, 100.0) : 4.0)
        : 0.0;

    return SizedBox(
      width: 50, // Largeur fixe pour chaque groupe de barres
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center, // Centrage horizontal
        children: [
          // Barres côte à côte (comme dans le maquette)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min, // Empêche la Row de prendre toute la largeur
            children: [
              // Barre verte (raites)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (raites > 0)
                    Text(
                      '$raites',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  if (raites > 0) const SizedBox(height: 4),
                  Container(
                    width: 12,
                    height: raites > 0 ? raitesHeight : 0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              // Barre orange (rouvertes)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (rouvertes > 0)
                    Text(
                      '$rouvertes',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFBBF24),
                      ),
                    ),
                  if (rouvertes > 0) const SizedBox(height: 4),
                  Container(
                    width: 12,
                    height: rouvertes > 0 ? rouvertesHeight : 0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBBF24),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Label du jour - centré
          SizedBox(
            width: 50, // Même largeur que le conteneur parent
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

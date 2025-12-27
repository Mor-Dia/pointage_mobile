import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../constant.dart';
import '../../services/api/models/pointage_model.dart';
import '../../services/pointage_service.dart';

class PointagesPageNew extends StatefulWidget {
  const PointagesPageNew({Key? key}) : super(key: key);

  @override
  State<PointagesPageNew> createState() => _PointagesPageNewState();
}

class _PointagesPageNewState extends State<PointagesPageNew> {
  final TextEditingController _searchController = TextEditingController();
  final PointageService _pointageService = PointageService();

  // Future pour charger les données
  late Future<List<Pointage>> _pointagesFuture;
  int _pointagesCount = 0;

  @override
  void initState() {
    super.initState();
    _pointagesFuture = _loadPointages();
  }

  Future<List<Pointage>> _loadPointages() async {
    final pointages = await _pointageService.getPointages();
    setState(() {
      // Compter le nombre total de détails dans tous les pointages
      _pointagesCount = pointages.fold<int>(
        0,
        (sum, pointage) => sum + pointage.details.length,
      );
    });
    return pointages;
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

            // Barre de recherche
            _buildSearchBar(),

            // Liste des pointages avec FutureBuilder
            Expanded(
              child: FutureBuilder<List<Pointage>>(
                future: _pointagesFuture,
                builder: (context, snapshot) {
                  // État de chargement
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff4DB8AC),
                      ),
                    );
                  }

                  // État d'erreur
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Erreur de chargement',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              '${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _pointagesFuture =
                                    _pointageService.getPointages();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff4DB8AC),
                            ),
                            child: const Text('Réessayer'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Données chargées
                  final pointages = snapshot.data ?? [];

                  if (pointages.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun pointage',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Titre du mois
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          _formatMonthYear(DateTime.now()),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      // Cartes de pointages
                      ...pointages
                          .map((pointage) => _buildPointageCard(pointage)),
                    ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Icône empreinte + Titre
          SvgPicture.asset(
            'assets/icons/famicons_finger-print.svg',
            width: 28,
            height: 28,
            colorFilter: const ColorFilter.mode(
              Colors.black87,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Pointage',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          // Badge compteur
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: greyColorL,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$_pointagesCount',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const Spacer(),
          // Icône notification
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/notification.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.black87,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher par Date, Heure',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
                filled: true,
                fillColor: greyColorL,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff4DB8AC), // Couleur turquoise
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                // TODO: Implémenter la recherche
              },
              icon: SvgPicture.asset(
                'assets/icons/loupe.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointageCard(Pointage pointage) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Afficher TOUS les détails
            if (pointage.details.isNotEmpty) ...[
              ...pointage.details.map((detail) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ligne 1 : Date à gauche + Heures à droite 
                      Row(
                        children: [
                          // Date à gauche
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/bar_chart.svg',
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  Colors.grey[600]!,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                detail.date != null && detail.date!.isNotEmpty
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(DateTime.parse(detail.date!))
                                    : DateFormat('dd/MM/yyyy')
                                        .format(DateTime.parse(pointage.date!)),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Heures à droite
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Heure d'arrivée
                              Row(
                                children: [
                                  Text(
                                    detail.heureArrive != null
                                        ? (pointage.formatHeure(
                                                detail.heureArrive) ??
                                            '--:--')
                                        : '--:--',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset(
                                    'assets/icons/flag1.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              // Heure de départ
                              Row(
                                children: [
                                  Text(
                                    detail.heureDepart != null
                                        ? (pointage.formatHeure(
                                                detail.heureDepart) ??
                                            '--:--')
                                        : '--:--',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset(
                                    'assets/icons/flag2.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Ligne 2 : Description (ou "--" si vide)
                      Text(
                        detail.description != null &&
                                detail.description!.isNotEmpty
                            ? detail.description!
                            : '--',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Ligne 3 : Badges
                      Row(
                        children: [
                          _buildBadge(
                            'Retard',
                            detail.retard == true,
                            const Color.fromARGB(255, 198, 4, 43),
                          ),
                          const SizedBox(width: 8),
                          _buildBadge(
                            'Absence',
                            detail.absence == true,
                            const Color.fromRGBO(7, 164, 146, 1),
                          ),
                          const Spacer(),
                          _buildBadge(
                            'Justificatif',
                            detail.justificatif == true,
                            const Color(0xff4DB8AC),
                          ),
                        ],
                      ),

                      // Séparateur entre les détails (sauf pour le dernier)
                      if (detail != pointage.details.last)
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Divider(height: 1),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ] else ...[
              const SizedBox(height: 12),
              Text(
                'Aucun détail disponible',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, bool isActive, Color activeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? activeColor.withOpacity(0.15) : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isActive ? activeColor : Colors.grey[500],
        ),
      ),
    );
  }

  // Fonction pour formater le mois avec majuscule
  String _formatMonthYear(DateTime date) {
    final formatted = DateFormat('MMMM yyyy', 'fr_FR').format(date);
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

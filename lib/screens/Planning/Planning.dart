import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../../services/planification_service.dart';
import '../../services/api/models/planification_model.dart';
import '../../constant.dart';
import 'tache_timer_modal.dart';

class Planning extends StatefulWidget {
  final int id;

  const Planning({Key? key, required this.id}) : super(key: key);

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  final PlanificationService _planificationService = PlanificationService();
  List<Planification> _planifications = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Suivi du temps des tâches
  final Map<int, Duration> _tachesDurees = {}; // tacheId -> durée
  final Map<int, bool> _tachesEnCours = {}; // tacheId -> en cours

  // Système d'onglets
  int _selectedTab = 0; // 0 = Tâches en cours, 1 = Tâches clôturées

  // Tâches et fonctionnalités terminées
  final Set<int> _tachesTerminees = {}; // IDs des tâches terminées
  final Set<int> _fonctionnalitesTerminees =
      {}; // IDs des fonctionnalités terminées

  // Timer pour le refresh automatique (optionnel)
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _chargerPlanifications();

    // Auto-refresh toutes les 30 secondes (optionnel - décommenter si besoin)
    // _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
    //   if (mounted && !_isLoading) {
    //     _chargerPlanifications();
    //   }
    // });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _chargerPlanifications() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final planifications = await _planificationService.getPlanifications();
      if (!mounted) return;

      setState(() {
        _planifications = planifications;

        // Charger les statuts terminés depuis l'API
        _tachesTerminees.clear();
        _fonctionnalitesTerminees.clear();

        for (var planification in planifications) {
          for (var detail in planification.details) {
            // Charger les fonctionnalités clôturées
            if (detail.fonctionnalite?.id != null &&
                detail.fonctionnalite?.statut == 'cloturee') {
              _fonctionnalitesTerminees.add(detail.fonctionnalite!.id!);
            }

            // Charger les tâches terminées
            if (detail.taches != null) {
              for (var tache in detail.taches!) {
                if (tache.id != null && tache.statut == 'terminee') {
                  _tachesTerminees.add(tache.id!);
                }
              }
            }
          }
        }

        print(
            '✅ Chargé ${_tachesTerminees.length} tâches terminées et ${_fonctionnalitesTerminees.length} fonctionnalités clôturées depuis l\'API');
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  int _getTotalTaches() {
    int total = 0;
    for (var planification in _planifications) {
      for (var detail in planification.details) {
        total += detail.taches?.length ?? 0;
      }
    }
    return total;
  }

  // Filtrer les planifications selon l'onglet actif
  List<Planification> _getFiltredPlanifications() {
    return _planifications
        .map((planification) {
          // Filtrer les détails selon l'onglet
          final detailsFiltres = planification.details
              .map((detail) {
                // Filtrer les tâches selon l'onglet
                final tachesFiltrees = detail.taches?.where((tache) {
                  final estTacheTerminee = _tachesTerminees.contains(tache.id);

                  if (_selectedTab == 0) {
                    // Onglet "Toutes les tâches" : afficher les tâches NON terminées
                    return !estTacheTerminee;
                  } else {
                    // Onglet "Tâches clôturées" : afficher les tâches terminées
                    return estTacheTerminee;
                  }
                }).toList();

                // Ne garder le detail que s'il a des tâches filtrées
                if (tachesFiltrees != null && tachesFiltrees.isNotEmpty) {
                  return PlanificationDetail(
                    id: detail.id,
                    projet: detail.projet,
                    epic: detail.epic,
                    fonctionnalite: detail.fonctionnalite,
                    taches: tachesFiltrees,
                  );
                }
                return null;
              })
              .whereType<PlanificationDetail>()
              .toList();

          // Retourner une planification avec les détails filtrés
          return Planification(
            id: planification.id,
            dateDebut: planification.dateDebut,
            dateFin: planification.dateFin,
            dateDebutFr: planification.dateDebutFr,
            dateFinFr: planification.dateFinFr,
            personnelId: planification.personnelId,
            personnel: planification.personnel,
            status: planification.status,
            nombreTache: planification.nombreTache,
            nombreProjet: planification.nombreProjet,
            details: detailsFiltres,
          );
        })
        .where((p) => p.details.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalTaches = _getTotalTaches();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/taches_icon.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF2D3748),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Total tâches du mois',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$totalTaches',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // Action pour les notifications
                    },
                  ),
                ],
              ),
            ),

            // Onglets "Tâches du jour" / "Tâches clôturées"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedTab == 0
                            ? const Color(0xFF4DB8AC)
                            : Colors.grey[300],
                        foregroundColor:
                            _selectedTab == 0 ? Colors.white : Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Tâches en cours',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedTab == 1
                            ? const Color(0xFF4DB8AC)
                            : Colors.grey[300],
                        foregroundColor:
                            _selectedTab == 1 ? Colors.white : Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Tâches clôturées',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Contenu principal
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 48, color: Colors.red),
                              const SizedBox(height: 16),
                              Text('Erreur: $_errorMessage'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _chargerPlanifications,
                                child: const Text('Réessayer'),
                              ),
                            ],
                          ),
                        )
                      : _planifications.isEmpty
                          ? const Center(
                              child: Text('Aucune planification trouvée'),
                            )
                          : RefreshIndicator(
                              onRefresh: _chargerPlanifications,
                              child: () {
                                final planificationsFiltrees =
                                    _getFiltredPlanifications();

                                if (planificationsFiltrees.isEmpty) {
                                  return ListView(
                                    padding: const EdgeInsets.all(16.0),
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 50),
                                            Icon(
                                              _selectedTab == 0
                                                  ? Icons.task_alt
                                                  : Icons.check_circle_outline,
                                              size: 64,
                                              color: Colors.grey[400],
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              _selectedTab == 0
                                                  ? 'Aucune tâche en cours'
                                                  : 'Aucune tâche clôturée',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return ListView.builder(
                                  padding: const EdgeInsets.all(16.0),
                                  itemCount: planificationsFiltrees.length,
                                  itemBuilder: (context, index) {
                                    return _buildPlanificationCard(
                                        planificationsFiltrees[index]);
                                  },
                                );
                              }(),
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanificationCard(Planification planification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec dates
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 16, color: Color(0xFF6B7280)),
                const SizedBox(width: 8),
                Text(
                  'Du ${planification.dateDebutFr} au ${planification.dateFinFr}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Liste des détails de planification
            ...planification.details.map((detail) {
              return _buildPlanificationDetail(detail);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanificationDetail(PlanificationDetail detail) {
    // Calculer le temps total des tâches de cette fonctionnalité
    Duration tempsTotal = Duration.zero;
    if (detail.taches != null) {
      for (var tache in detail.taches!) {
        final dureeSauvegardee = _parseDuree(tache.duree);
        if (dureeSauvegardee != null) {
          tempsTotal += dureeSauvegardee;
        }
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Projet (EN VERT)
          Row(
            children: [
              const Icon(Icons.folder, size: 16, color: Color(0xFF4CAF50)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  detail.projet?.nom ?? 'Projet',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4CAF50), // VERT pour le projet
                  ),
                ),
              ),
            ],
          ),

          // Fonctionnalité avec icône œil et bouton Démarrer
          if (detail.fonctionnalite?.nom != null &&
              detail.fonctionnalite!.nom!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carte cliquable de la fonctionnalité
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _ouvrirDetailsFonctionnalite(detail),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detail.fonctionnalite!.nom!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D3748),
                                    ),
                                  ),
                                  if (tempsTotal.inSeconds > 0) ...[
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.timer,
                                          size: 14,
                                          color: Color(0xFF4CAF50),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _formatDuration(tempsTotal),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF4CAF50),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.remove_red_eye,
                              size: 20,
                              color: Color(0xFF4DB8AC),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Bouton Démarrer/Clôturer sous la fonctionnalité
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedTab == 1) {
                        // Si dans l'onglet clôturé, ne rien faire (déjà terminé)
                        return;
                      }

                      // Utiliser la première tâche de la fonctionnalité
                      if (detail.taches != null && detail.taches!.isNotEmpty) {
                        final premiereTache = detail.taches!.first;
                        _ouvrirChronometro(premiereTache, detail);
                      } else {
                        // Si pas de tâches, créer une tâche globale
                        final tacheFonctionnalite = PlanificationTache(
                          id: detail.fonctionnalite?.id,
                          nom: detail.fonctionnalite?.nom ?? 'Fonctionnalité',
                        );
                        _ouvrirChronometro(tacheFonctionnalite, detail);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedTab == 1
                          ? Colors.grey[400]
                          : const Color(0xFF4DB8AC),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _selectedTab == 1 ? 'Clôturer' : 'Démarrer',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // Méthode pour ouvrir les détails d'une fonctionnalité dans un bottom sheet
  void _ouvrirDetailsFonctionnalite(PlanificationDetail detail) {
    // Calculer le temps total
    Duration tempsTotal = Duration.zero;
    if (detail.taches != null) {
      for (var tache in detail.taches!) {
        final dureeSauvegardee = _parseDuree(tache.duree);
        if (dureeSauvegardee != null) {
          tempsTotal += dureeSauvegardee;
        }
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        detail.fonctionnalite?.nom ?? 'Fonctionnalité',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                    ),
                    if (tempsTotal.inSeconds > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4DB8AC).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _formatDuration(tempsTotal),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4DB8AC),
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    // Bouton de fermeture
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF6B7280)),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              // Label "Tâches"
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.list, size: 18, color: Color(0xFF4DB8AC)),
                    SizedBox(width: 8),
                    Text(
                      'Tâches',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4DB8AC),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Liste des tâches
              Expanded(
                child: detail.taches == null || detail.taches!.isEmpty
                    ? const Center(
                        child: Text('Aucune tâche disponible'),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: detail.taches!.length,
                        itemBuilder: (context, index) {
                          final tache = detail.taches![index];
                          if (tache.nom == null) return const SizedBox();

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xFFE5E7EB)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    tache.nom!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2D3748),
                                    ),
                                  ),
                                ),
                                // Bouton "Terminer" avec checkmark
                                ElevatedButton(
                                  onPressed: _selectedTab == 1
                                      ? null
                                      : () async {
                                          if (tache.id != null) {
                                            // Mettre à jour le statut dans le backend
                                            await _mettreAJourStatutTache(
                                                tache.id!, 'terminee');

                                            // _chargerPlanifications() est déjà appelé dans _mettreAJourStatutTache()
                                            // donc pas besoin de setState() ici
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _selectedTab == 1
                                        ? Colors.grey[400]
                                        : const Color(0xFF4DB8AC),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        'Terminer',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(Icons.check, size: 14),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              // Bouton "Tout terminer"
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedTab == 1
                        ? null
                        : () async {
                            // Marquer toutes les tâches comme terminées dans le backend
                            if (detail.taches != null) {
                              for (var tache in detail.taches!) {
                                if (tache.id != null) {
                                  // Appel direct sans recharger à chaque fois
                                  try {
                                    await http.post(
                                      Uri.parse(
                                          '${BASE_URL}taches/${tache.id}/statut'),
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Accept': 'application/json',
                                      },
                                      body: json.encode({'statut': 'terminee'}),
                                    );
                                  } catch (e) {
                                    print('❌ Erreur tâche ${tache.id}: $e');
                                  }
                                }
                              }
                            }

                            // Marquer la fonctionnalité comme clôturée dans le backend
                            if (detail.fonctionnalite?.id != null) {
                              try {
                                await http.post(
                                  Uri.parse(
                                      '${BASE_URL}fonctionnalites/${detail.fonctionnalite!.id}/statut'),
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Accept': 'application/json',
                                  },
                                  body: json.encode({'statut': 'cloturee'}),
                                );
                              } catch (e) {
                                print('❌ Erreur fonctionnalité: $e');
                              }
                            }

                            // Recharger les planifications UNE SEULE FOIS à la fin
                            await _chargerPlanifications();

                            // Fermer le bottom sheet (vérifier que le context est valide)
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedTab == 1
                          ? Colors.grey[400]
                          : const Color(0xFF4DB8AC),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Tout terminer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour ouvrir le chronomètre d'une tâche
  void _ouvrirChronometro(
      PlanificationTache tache, PlanificationDetail detail) {
    // Récupérer la durée sauvegardée ou la durée en cours
    final dureeSauvegardee = _parseDuree(tache.duree);
    final dureeInitiale = _tachesDurees[tache.id] ?? dureeSauvegardee;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TacheTimerModal(
        tacheTitre: tache.nom ?? 'Tâche',
        tacheId: tache.id,
        initialDuration: dureeInitiale, // Passer la durée initiale
        onSaveDuration: (duration) {
          setState(() {
            if (tache.id != null) {
              _tachesDurees[tache.id!] = duration;
              _tachesEnCours[tache.id!] = false;
            }
          });

          // Sauvegarder la durée dans le backend en utilisant l'ID du détail
          _sauvegarderDureeTache(detail.id, tache.id, duration);
        },
      ),
    );
  }

  // Méthode pour formater la durée
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    if (duration.inHours > 0) {
      return '${duration.inHours}h ${twoDigits(duration.inMinutes.remainder(60))}min';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}min';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  // Méthode pour convertir une durée HH:MM:SS en Duration
  Duration? _parseDuree(String? dureeString) {
    if (dureeString == null || dureeString.isEmpty) return null;

    try {
      final parts = dureeString.split(':');
      if (parts.length != 3) return null;

      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1]);
      final seconds = int.parse(parts[2]);

      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } catch (e) {
      print('❌ Erreur parsing durée: $e');
      return null;
    }
  }

  // Méthode pour sauvegarder la durée dans le backend
  Future<void> _sauvegarderDureeTache(
      int? detailId, int? tacheId, Duration duration) async {
    if (detailId == null) {
      print('❌ ID du détail de planification manquant');
      return;
    }

    try {
      // Convertir la durée en format HH:MM:SS
      final heures = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      final secondes = duration.inSeconds.remainder(60);
      final dureeFormatee =
          '${heures.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secondes.toString().padLeft(2, '0')}';

      print(
          '💾 Sauvegarde de la durée pour la tâche $tacheId (détail $detailId): $dureeFormatee');

      // Appeler la nouvelle API pour sauvegarder la durée effectuée
      final response = await http.post(
        Uri.parse('${BASE_URL}planification-detail/$detailId/duree-effectue'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'duree_effectue': dureeFormatee}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('✅ Durée sauvegardée avec succès: ${data['message']}');

        // Recharger les planifications pour mettre à jour l'affichage
        await _chargerPlanifications();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Durée sauvegardée: ${_formatDuration(duration)}'),
              backgroundColor: const Color(0xFF4CAF50),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        print('❌ Erreur serveur: ${response.statusCode}');
        throw Exception('Erreur lors de la sauvegarde');
      }
    } catch (e) {
      print('❌ Erreur lors de la sauvegarde: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la sauvegarde'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Méthode pour mettre à jour le statut d'une tâche dans le backend
  Future<void> _mettreAJourStatutTache(int tacheId, String statut) async {
    try {
      print('📤 Mise à jour statut tâche $tacheId: $statut');

      final response = await http.post(
        Uri.parse('${BASE_URL}taches/$tacheId/statut'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'statut': statut}),
      );

      if (response.statusCode == 200) {
        print('✅ Statut tâche mis à jour avec succès');

        // Recharger les planifications pour mettre à jour l'UI
        await _chargerPlanifications();
      } else {
        print('❌ Erreur serveur statut tâche: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erreur mise à jour statut tâche: $e');
    }
  }

  // Méthode pour mettre à jour le statut d'une fonctionnalité dans le backend
  Future<void> _mettreAJourStatutFonctionnalite(
      int fonctionnaliteId, String statut) async {
    try {
      print('📤 Mise à jour statut fonctionnalité $fonctionnaliteId: $statut');

      final response = await http.post(
        Uri.parse('${BASE_URL}fonctionnalites/$fonctionnaliteId/statut'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'statut': statut}),
      );

      if (response.statusCode == 200) {
        print('✅ Statut fonctionnalité mis à jour avec succès');

        // Recharger les planifications pour mettre à jour l'UI
        await _chargerPlanifications();
      } else {
        print('❌ Erreur serveur statut fonctionnalité: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erreur mise à jour statut fonctionnalité: $e');
    }
  }
}

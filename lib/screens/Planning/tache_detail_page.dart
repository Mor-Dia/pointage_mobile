import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class TacheDetailPage extends StatefulWidget {
  final String titre;
  final String duree;
  final Function(Duration)? onToutTerminer;
  final bool isReadOnly;
  final DateTime? tempsDepart;

  const TacheDetailPage({
    Key? key,
    required this.titre,
    required this.duree,
    this.onToutTerminer,
    this.isReadOnly = false,
    this.tempsDepart,
  }) : super(key: key);

  @override
  State<TacheDetailPage> createState() => _TacheDetailPageState();
}

class _TacheDetailPageState extends State<TacheDetailPage> {
  Timer? _timer;
  Duration _tempsEcoule = Duration.zero;

  // Liste des sous-tâches avec leur statut
  final List<Map<String, dynamic>> _sousTaches = [
    {
      'titre': 'Concevoir l\'interface du tableau de bord',
      'termine': false,
    },
    {
      'titre': 'Afficher les tâches du jour',
      'termine': false,
    },
    {
      'titre': 'Intégrer la vue (heures du mois)',
      'termine': false,
    },
    {
      'titre': 'Connecter les données du collaborateur via l\'API',
      'termine': false,
    },
    {
      'titre': 'Mettre en place les filtres',
      'termine': false,
    },
    {
      'titre': 'Tester la performance et l\'affichage temps réel',
      'termine': false,
    },
  ];

  bool get _toutesTerminees =>
      _sousTaches.every((tache) => tache['termine'] == true);

  @override
  void initState() {
    super.initState();
    // Si une tâche a déjà été démarrée, calculer le temps écoulé et démarrer le timer
    if (widget.tempsDepart != null) {
      _tempsEcoule = DateTime.now().difference(widget.tempsDepart!);
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && widget.tempsDepart != null) {
        setState(() {
          _tempsEcoule = DateTime.now().difference(widget.tempsDepart!);
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle pour glisser le bottom sheet
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header avec bouton fermer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Détails de la tâche',
                    style: TextStyle(
                      color: Color(0xFF2D3748),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF2D3748)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildSousTachesSection(),
                    const SizedBox(height: 100), // Espace pour le bouton fixe
                  ],
                ),
              ),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.titre,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                if (widget.tempsDepart != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        size: 16,
                        color: Color(0xFF5EBAAE),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Temps écoulé: ${_formatDuration(_tempsEcoule)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5EBAAE),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF5EBAAE).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              widget.duree,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5EBAAE),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSousTachesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/taches_icon.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF5EBAAE),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Tâches',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5EBAAE),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          ..._sousTaches.asMap().entries.map((entry) {
            return _buildSousTacheItem(entry.key);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSousTacheItem(int index) {
    final tache = _sousTaches[index];
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: index < _sousTaches.length - 1
              ? const BorderSide(color: Color(0xFFF3F4F6), width: 1)
              : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                tache['titre'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _sousTaches[index]['termine'] =
                      !_sousTaches[index]['termine'];
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: tache['termine']
                      ? const Color(0xFFF3F4F6)
                      : const Color(0xFF5EBAAE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tache['termine'] ? 'Terminé' : 'Terminer',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: tache['termine']
                            ? const Color(0xFFD1D5DB)
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      tache['termine'] ? Icons.check : Icons.arrow_forward,
                      size: 14,
                      color: tache['termine']
                          ? const Color(0xFFD1D5DB)
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: !_toutesTerminees && !widget.isReadOnly
              ? () {
                  // Marquer toutes les tâches comme terminées
                  setState(() {
                    for (var tache in _sousTaches) {
                      tache['termine'] = true;
                    }
                  });

                  // Calculer la durée finale
                  final dureeFinale = widget.tempsDepart != null
                      ? DateTime.now().difference(widget.tempsDepart!)
                      : Duration.zero;

                  // Afficher une dialog avec le temps écoulé
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF5EBAAE).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.check_circle,
                                color: Color(0xFF5EBAAE),
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Tâche terminée !',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2D3748),
                                ),
                              ),
                            ),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Félicitations ! Vous avez terminé la tâche "${widget.titre}".',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF4A5568),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (widget.tempsDepart != null)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF5EBAAE).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF5EBAAE)
                                        .withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF5EBAAE),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.timer,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temps total',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF718096),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _formatDuration(dureeFinale),
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF5EBAAE),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Appeler le callback pour notifier la page parente
                              if (widget.onToutTerminer != null) {
                                widget.onToutTerminer!(dureeFinale);
                              }
                              // Retourner à la page précédente
                              Navigator.of(context).pop(true);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF5EBAAE),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Parfait !',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: !_toutesTerminees
                ? const Color(0xFF5EBAAE)
                : const Color(0xFFF3F4F6),
            disabledBackgroundColor: const Color(0xFFF3F4F6),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            minimumSize: const Size(double.infinity, 48),
          ),
          child: Text(
            'Tout terminer',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: !_toutesTerminees ? Colors.white : const Color(0xFFD1D5DB),
            ),
          ),
        ),
      ),
    );
  }
}

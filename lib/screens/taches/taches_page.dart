import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../constant.dart';

class TachesPage extends StatefulWidget {
  const TachesPage({Key? key}) : super(key: key);

  @override
  State<TachesPage> createState() => _TachesPageState();
}

class _TachesPageState extends State<TachesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Données simulées (à remplacer par DataBloc)
  List<Map<String, dynamic>> tachesEnCours = [
    {
      'id': 1,
      'titre': 'Finaliser le rapport mensuel',
      'description': 'Compléter et envoyer le rapport d\'activité de décembre',
      'priorite': 'Haute',
      'echeance': '18 Dec 2025',
      'progression': 75,
      'categorie': 'Documentation',
    },
    {
      'id': 2,
      'titre': 'Réunion avec l\'équipe projet',
      'description': 'Point hebdomadaire sur l\'avancement du projet X',
      'priorite': 'Moyenne',
      'echeance': '17 Dec 2025',
      'progression': 0,
      'categorie': 'Réunion',
    },
    {
      'id': 3,
      'titre': 'Mise à jour de la base de données',
      'description': 'Importer les nouvelles données clients',
      'priorite': 'Haute',
      'echeance': '16 Dec 2025',
      'progression': 30,
      'categorie': 'Technique',
    },
  ];

  List<Map<String, dynamic>> tachesTerminees = [
    {
      'id': 4,
      'titre': 'Formation Flutter',
      'description': 'Suivre le cours avancé sur Flutter',
      'priorite': 'Basse',
      'termineLe': '15 Dec 2025',
      'categorie': 'Formation',
    },
    {
      'id': 5,
      'titre': 'Correction des bugs',
      'description': 'Résoudre les bugs signalés par les utilisateurs',
      'priorite': 'Haute',
      'termineLe': '14 Dec 2025',
      'categorie': 'Technique',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getPrioriteColor(String priorite) {
    switch (priorite) {
      case 'Haute':
        return dangerColor;
      case 'Moyenne':
        return warningColor;
      case 'Basse':
        return successColor;
      default:
        return Colors.grey;
    }
  }

  void _showAddTacheDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nouvelle tâche',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Titre de la tâche',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Priorité',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: ['Haute', 'Moyenne', 'Basse']
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Date d\'échéance',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Ajouter la tâche via PostApiBloc
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tâche ajoutée avec succès'),
                        backgroundColor: successColor,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Ajouter la tâche',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  Widget _buildTacheCard(Map<String, dynamic> tache, bool isCompleted) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    tache['titre'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                if (!isCompleted)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          _getPrioriteColor(tache['priorite']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tache['priorite'],
                      style: TextStyle(
                        color: _getPrioriteColor(tache['priorite']),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              tache['description'],
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  tache['categorie'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Icon(
                  isCompleted ? Icons.check_circle : Icons.access_time,
                  size: 14,
                  color: isCompleted ? successColor : Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  isCompleted
                      ? 'Terminé le ${tache['termineLe']}'
                      : 'Échéance: ${tache['echeance']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isCompleted ? successColor : Colors.grey[600],
                  ),
                ),
              ],
            ),
            if (!isCompleted && tache['progression'] != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: tache['progression'] / 100,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getPrioriteColor(tache['priorite']),
                      ),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${tache['progression']}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Éditer la tâche
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Modifier'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: const BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        if (!isCompleted) {
                          tachesTerminees.add(tache);
                          tachesEnCours.remove(tache);
                        } else {
                          tachesEnCours.add(tache);
                          tachesTerminees.remove(tache);
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isCompleted
                                ? 'Tâche réactivée'
                                : 'Tâche marquée comme terminée',
                          ),
                          backgroundColor: successColor,
                        ),
                      );
                    },
                    icon: Icon(
                      isCompleted ? Icons.replay : Icons.check,
                      size: 16,
                    ),
                    label: Text(isCompleted ? 'Réactiver' : 'Terminer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isCompleted ? warningColor : successColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          'Mes Tâches',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          tabs: [
            Tab(
              text: 'En cours (${tachesEnCours.length})',
            ),
            Tab(
              text: 'Terminées (${tachesTerminees.length})',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tâches en cours
          tachesEnCours.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/taches_icon.svg',
                        width: 100,
                        height: 100,
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aucune tâche en cours',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _showAddTacheDialog,
                        icon: const Icon(Icons.add),
                        label: const Text('Ajouter une tâche'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tachesEnCours.length,
                  itemBuilder: (context, index) {
                    return _buildTacheCard(tachesEnCours[index], false);
                  },
                ),
          // Tâches terminées
          tachesTerminees.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 100,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aucune tâche terminée',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tachesTerminees.length,
                  itemBuilder: (context, index) {
                    return _buildTacheCard(tachesTerminees[index], true);
                  },
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTacheDialog,
        backgroundColor: secondColor,
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle tâche'),
      ),
    );
  }
}

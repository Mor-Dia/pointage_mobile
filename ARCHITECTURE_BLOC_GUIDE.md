# 📘 Guide d'utilisation de l'Architecture BLoC Yogivida pour Pointage

## 🎯 Vue d'ensemble

Votre application utilise déjà l'architecture BLoC de Yogivida. Cette architecture est **déjà fonctionnelle** et prête à être utilisée avec votre nouvelle API.

## 🏗️ Structure de l'architecture

```
lib/services/
├── post_api_bloc.dart          ← Pour POST/DELETE (créer, modifier, supprimer)
├── data_bloc/
│   └── bloc/
│       ├── data_bloc.dart      ← Pour GET (récupérer des données)
│       └── data_bloc_helpers.dart
└── api/
    └── actions/
        ├── postData.dart       ← Fonction POST automatique
        ├── getData.dart        ← Fonction GET automatique
        └── delData.dart        ← Fonction DELETE automatique
```

## ✅ Ce qui est déjà configuré

1. **BASE_URL** → `https://guindytechnology-solutions.com/guindy_manager_test/`
2. **Headers automatiques** → Gestion du token Bearer
3. **Gestion d'erreurs** → Messages standardisés
4. **States BLoC** → Loading, Success, Failure
5. **Pagination** → Gestion automatique

## 📖 Guide d'utilisation

### 1️⃣ Pour RÉCUPÉRER des données (GET)

#### a) Dans votre modèle (ex: Tache)

```dart
// lib/services/api/models/tache_model.dart
class Tache {
  final int id;
  final String titre;
  final String description;
  final DateTime dateDebut;
  final DateTime dateFin;
  final String statut;
  final int userId;

  Tache({
    required this.id,
    required this.titre,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
    required this.statut,
    required this.userId,
  });

  // ✅ OBLIGATOIRE : Transformer JSON → Objet
  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
      id: json['id'] ?? 0,
      titre: json['titre'] ?? '',
      description: json['description'] ?? '',
      dateDebut: DateTime.parse(json['date_debut']),
      dateFin: DateTime.parse(json['date_fin']),
      statut: json['statut'] ?? '',
      userId: json['user_id'] ?? 0,
    );
  }

  // ✅ OBLIGATOIRE : Transformer une liste JSON → Liste d'objets
  static List<Tache> fromJsonList(dynamic response) {
    List<Tache> taches = [];
    if (response is List) {
      taches = response.map((e) => Tache.fromJson(e)).toList();
    }
    return taches;
  }

  // ✅ OBLIGATOIRE : Endpoint de l'API
  static String getEndpoint({bool isPagination = false}) {
    return 'taches'; // ← Votre endpoint backend
  }

  // ✅ OPTIONNEL : Pour GraphQL (si votre API utilise GraphQL)
  static String shrinkedAttributs() {
    return '''
      id
      titre
      description
      date_debut
      date_fin
      statut
      user_id
    ''';
  }

  // ✅ OPTIONNEL : Pour envoyer des données
  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'description': description,
      'date_debut': dateDebut.toIso8601String(),
      'date_fin': dateFin.toIso8601String(),
      'statut': statut,
      'user_id': userId,
    };
  }
}
```

#### b) Dans votre écran

```dart
// lib/screens/taches/taches_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointage_mobile/services/data_bloc/bloc/data_bloc.dart';
import 'package:pointage_mobile/services/api/models/tache_model.dart';

class TachesPage extends StatefulWidget {
  const TachesPage({super.key});

  @override
  State<TachesPage> createState() => _TachesPageState();
}

class _TachesPageState extends State<TachesPage> {
  late DataBloc<List<Tache>> tacheBloc;

  @override
  void initState() {
    super.initState();
    
    // ✅ ÉTAPE 1 : Créer le BLoC
    tacheBloc = DataBloc<List<Tache>>(
      (response) => Tache.fromJsonList(response),  // Transformer les données
      Tache.getEndpoint(isPagination: true),       // Endpoint
      isGraphQl: false,                            // REST API (pas GraphQL)
      isPagination: true,                          // Avec pagination
    );

    // ✅ ÉTAPE 2 : Charger les données
    tacheBloc.add(FetchDataEvent(filter: {
      'user_id': 123,  // ← Vos filtres
      'statut': 'en_cours',
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes Tâches')),
      body: BlocBuilder<DataBloc<List<Tache>>, DataFetchState>(
        bloc: tacheBloc,
        builder: (context, state) {
          // ✅ ÉTAPE 3 : Gérer les états
          if (state is DataLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (state is DataFailure) {
            return Center(child: Text('Erreur: ${state.error}'));
          }
          
          if (state is DataSuccess<List<Tache>>) {
            List<Tache> taches = state.data ?? [];
            
            if (taches.isEmpty) {
              return Center(child: Text('Aucune tâche'));
            }
            
            return ListView.builder(
              itemCount: taches.length,
              itemBuilder: (context, index) {
                Tache tache = taches[index];
                return ListTile(
                  title: Text(tache.titre),
                  subtitle: Text(tache.description),
                  trailing: Text(tache.statut),
                );
              },
            );
          }
          
          return Center(child: Text('Aucune donnée'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Rafraîchir les données
          tacheBloc.add(RefreshDataEvent(filter: {'user_id': 123}));
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
```

### 2️⃣ Pour CRÉER/MODIFIER/SUPPRIMER des données (POST/DELETE)

```dart
// lib/screens/taches/ajouter_tache_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointage_mobile/services/post_api_bloc.dart';

class AjouterTachePage extends StatefulWidget {
  const AjouterTachePage({super.key});

  @override
  State<AjouterTachePage> createState() => _AjouterTachePageState();
}

class _AjouterTachePageState extends State<AjouterTachePage> {
  late PostApiBloc postBloc;
  final titreController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ✅ ÉTAPE 1 : Créer le BLoC
    postBloc = PostApiBloc();
  }

  void ajouterTache() {
    // ✅ ÉTAPE 2 : Envoyer les données
    postBloc.add(PostApiMakeCall(
      endpoint: 'taches',  // ← Votre endpoint
      parameters: {
        'titre': titreController.text,
        'description': descriptionController.text,
        'date_debut': DateTime.now().toIso8601String(),
        'date_fin': DateTime.now().add(Duration(days: 7)).toIso8601String(),
        'statut': 'en_cours',
        'user_id': 123,
      },
      isDeletion: false,  // ← false pour POST, true pour DELETE
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une tâche')),
      body: BlocConsumer<PostApiBloc, PostApiState>(
        bloc: postBloc,
        // ✅ ÉTAPE 3a : Listener pour les actions (navigation, messages)
        listener: (context, state) {
          if (state is PostApiSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('✅ ${state.message}')),
            );
            Navigator.pop(context);  // Retour à l'écran précédent
          }
          
          if (state is PostApiFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('❌ ${state.message}')),
            );
          }
        },
        // ✅ ÉTAPE 3b : Builder pour l'UI (loading, buttons)
        builder: (context, state) {
          bool isProcessing = state is PostApiProcessing;
          
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: titreController,
                  decoration: InputDecoration(labelText: 'Titre'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isProcessing ? null : ajouterTache,
                  child: isProcessing
                      ? CircularProgressIndicator()
                      : Text('Ajouter la tâche'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

### 3️⃣ Pour SUPPRIMER des données

```dart
void supprimerTache(int tacheId) {
  final deleteBloc = PostApiBloc();
  
  deleteBloc.add(PostApiMakeCall(
    endpoint: 'taches/$tacheId',  // ← Endpoint avec ID
    parameters: {'id': tacheId},
    isDeletion: true,  // ← IMPORTANT : true pour DELETE
  ));
  
  // Écouter la réponse
  deleteBloc.stream.listen((state) {
    if (state is PostApiSuccess) {
      print('✅ Tâche supprimée');
      // Rafraîchir la liste
      tacheBloc.add(RefreshDataEvent(filter: {'user_id': 123}));
    }
  });
}
```

## 🎨 Widget avancé : BlocBasedWidget

Yogivida a créé un widget réutilisable pour simplifier l'utilisation des BLoCs :

```dart
import 'package:pointage_mobile/services/data_bloc/presentation/bloc_based_widget.dart';

// Utilisation simplifiée
BlocBasedWidget<List<Tache>>(
  customDataBloc: tacheBloc,
  filter: {'user_id': 123},
  useInfiniteScroller: true,  // Pagination automatique
  customWidget: (state) {
    List<Tache> taches = state.data ?? [];
    
    return ListView.builder(
      itemCount: taches.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(taches[index].titre),
        );
      },
    );
  },
)
```

## 🔄 Rafraîchir les données

```dart
// Méthode 1 : RefreshDataEvent
tacheBloc.add(RefreshDataEvent(filter: {'user_id': 123}));

// Méthode 2 : FetchDataEvent
tacheBloc.add(FetchDataEvent(filter: {'user_id': 123}));
```

## 📦 Pagination automatique

```dart
DataBloc<List<Tache>>(
  (response) => Tache.fromJsonList(response),
  Tache.getEndpoint(isPagination: true),
  isPagination: true,  // ← Active la pagination
);

// Charger plus de données
tacheBloc.add(FetchDataEvent(
  filter: {'user_id': 123},
  loadNewData: true,  // ← Ajoute les données sans remplacer
));
```

## 🎯 GraphQL vs REST

### REST API (recommandé pour la nouvelle API)

```dart
DataBloc<List<Tache>>(
  (response) => Tache.fromJsonList(response),
  'taches',           // ← Endpoint simple
  isGraphQl: false,   // ← REST
  isPagination: true,
);
```

### GraphQL (si votre API utilise GraphQL)

```dart
DataBloc<List<Tache>>(
  (response) => Tache.fromJsonList(response),
  Tache.getEndpoint(isPagination: true),
  isGraphQl: true,    // ← GraphQL
  isPagination: true,
  attributeToGet: Tache.shrinkedAttributs(),  // ← Attributs à récupérer
);
```

## 🔐 Authentification automatique

Les headers (token Bearer) sont automatiquement ajoutés dans `postData.dart` et `getData.dart` :

```dart
Map<String, String>? headers = await getHeaders();
// Retourne automatiquement :
// {
//   'Authorization': 'Bearer votre_token',
//   'Content-Type': 'application/json',
//   'Accept': 'application/json',
// }
```

## 🚨 Gestion d'erreurs

Les BLoCs gèrent automatiquement les erreurs :

```dart
if (state is DataFailure) {
  print('Erreur: ${state.error}');
}

if (state is PostApiFailure) {
  print('Erreur: ${state.message}');
}
```

## 📝 Résumé des étapes

### Pour récupérer des données (GET)
1. Créer le modèle avec `fromJson`, `fromJsonList`, `getEndpoint`
2. Créer un `DataBloc<List<VotreModele>>`
3. Ajouter un `FetchDataEvent` avec filtres
4. Utiliser `BlocBuilder` pour afficher les données

### Pour créer/modifier/supprimer (POST/DELETE)
1. Créer un `PostApiBloc()`
2. Ajouter un `PostApiMakeCall` avec endpoint et parametres
3. Utiliser `BlocConsumer` pour écouter les états

## ✅ Exemple complet : Page de pointage

```dart
class PointagePage extends StatefulWidget {
  const PointagePage({super.key});

  @override
  State<PointagePage> createState() => _PointagePageState();
}

class _PointagePageState extends State<PointagePage> {
  late DataBloc<List<Pointage>> pointageBloc;
  late PostApiBloc demarrerPointageBloc;

  @override
  void initState() {
    super.initState();
    
    // BLoC pour récupérer les pointages
    pointageBloc = DataBloc<List<Pointage>>(
      (response) => Pointage.fromJsonList(response),
      'pointages',
      isGraphQl: false,
      isPagination: true,
    );
    
    // BLoC pour démarrer un pointage
    demarrerPointageBloc = PostApiBloc();
    
    // Charger les pointages
    pointageBloc.add(FetchDataEvent(filter: {'user_id': 123}));
  }

  void demarrerPointage() {
    demarrerPointageBloc.add(PostApiMakeCall(
      endpoint: 'pointages',
      parameters: {
        'user_id': 123,
        'date_debut': DateTime.now().toIso8601String(),
        'type': 'arrivee',
      },
      isDeletion: false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pointage')),
      body: Column(
        children: [
          // Bouton pour démarrer un pointage
          BlocConsumer<PostApiBloc, PostApiState>(
            bloc: demarrerPointageBloc,
            listener: (context, state) {
              if (state is PostApiSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('✅ Pointage démarré')),
                );
                // Rafraîchir la liste
                pointageBloc.add(RefreshDataEvent(filter: {'user_id': 123}));
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state is PostApiProcessing ? null : demarrerPointage,
                child: Text('Démarrer le pointage'),
              );
            },
          ),
          
          // Liste des pointages
          Expanded(
            child: BlocBuilder<DataBloc<List<Pointage>>, DataFetchState>(
              bloc: pointageBloc,
              builder: (context, state) {
                if (state is DataLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                
                if (state is DataSuccess<List<Pointage>>) {
                  List<Pointage> pointages = state.data ?? [];
                  
                  return ListView.builder(
                    itemCount: pointages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(pointages[index].type),
                        subtitle: Text(pointages[index].dateDebut.toString()),
                      );
                    },
                  );
                }
                
                return Center(child: Text('Aucun pointage'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

## 🎓 Conseils

1. **Toujours créer les BLoCs dans `initState()`**
2. **Utiliser `BlocConsumer` pour POST** (listener + builder)
3. **Utiliser `BlocBuilder` pour GET** (juste builder)
4. **Rafraîchir les données après POST** avec `RefreshDataEvent`
5. **Gérer les états Loading, Success, Failure**
6. **Ne pas oublier les filtres** dans `FetchDataEvent`

## 🆘 En cas de problème

### Erreur "null is not a subtype"
→ Vérifiez votre méthode `fromJson` et les champs nullable

### Les données ne se chargent pas
→ Vérifiez l'endpoint et les filtres
→ Vérifiez les logs dans la console

### L'authentification ne fonctionne pas
→ Vérifiez que le token est bien sauvegardé après login
→ Vérifiez `getHeaders()` dans `postData.dart`

---

**✅ Vous êtes prêt ! Votre architecture BLoC est déjà en place et fonctionnelle.**

Il suffit de :
1. Créer vos modèles avec les bonnes méthodes
2. Utiliser `DataBloc` pour GET
3. Utiliser `PostApiBloc` pour POST/DELETE
4. L'URL `BASE_URL` est déjà configurée !

#  Analyse des Endpoints Yogivida existants

##  Endpoints GraphQL trouvés dans le code

### Actuellement utilisés (à migrer vers REST)

| Modèle | Endpoint GraphQL | Nouveau REST suggéré | Fichiers utilisant |
|--------|------------------|----------------------|---------------------|
| **Pratique** | `pratiquepaginated` | `/api/pratiques` | home_page.dart, pratique_page.dart, pratique_detail.dart |
| **Programme** | `programmepaginated` | `/api/programmes` | home_page.dart |
| **TypePratique** | `type_pratiquepaginated` | `/api/types-pratiques` | home_page.dart, pratique_page.dart, type_pratique_page.dart |
| **NotificationPush** | `notificationpushpaginated` | `/api/notifications` | home_page.dart, type_notificationpush_page.dart |
| **Banniere** | `bannierepaginated` | `/api/bannieres` | home_page.dart |
| **Preference** | `preference` | `/api/preferences` | home_page.dart, LocalisationContact.dart |
| **Reservation** | `reservationpaginated` | `/api/reservations` | reservations_page.dart, reservation_detail.dart |
| **LigneCredit** | `ligne_creditpaginated` | `/api/lignes-credit` | ligne_credit_page.dart |
| **Utilisateur** | `clientspaginated` | `/api/utilisateurs` | MonCompte.dart, ligne_credit_page.dart |
| **TypePaiement** | `type_paiement` | `/api/types-paiement` | ligne_credit_page.dart |
| **Favoris** | `favorispaginated` | `/api/favoris` | favoris_page.dart |
| **Famille** | `familleproduits` | `/api/familles` | Boutique.dart |
| **Produit** | `produitpaginated` | `/api/produits` | Boutique.dart, produit_detail.dart |

---

## 🆕 Nouveaux endpoints Pointage à créer

### Pour votre nouvelle app de pointage

| Fonctionnalité | Endpoint | Méthode | Usage |
|----------------|----------|---------|-------|
| **Pointages** | `/api/pointages` | GET | Liste des pointages de l'utilisateur |
| **Pointages** | `/api/pointages` | POST | Créer un pointage (arrivée/départ) |
| **Pointages** | `/api/pointages/{id}` | GET | Détail d'un pointage |
| **Pointages** | `/api/pointages/{id}` | PUT | Modifier un pointage (admin) |
| **Pointages** | `/api/pointages/{id}` | DELETE | Supprimer un pointage (admin) |
| **Tâches** | `/api/taches` | GET | Liste des tâches |
| **Tâches** | `/api/taches` | POST | Créer une tâche |
| **Tâches** | `/api/taches/{id}` | GET | Détail d'une tâche |
| **Tâches** | `/api/taches/{id}` | PUT | Modifier une tâche |
| **Tâches** | `/api/taches/{id}` | DELETE | Supprimer une tâche |
| **Employés** | `/api/employes` | GET | Liste des employés (admin) |
| **Employés** | `/api/employes/{id}` | GET | Détail d'un employé |
| **Statistiques** | `/api/statistiques/pointages` | GET | Stats de pointage par période |
| **Statistiques** | `/api/statistiques/taches` | GET | Stats des tâches |
| **Profil** | `/api/profil` | GET | Profil de l'utilisateur connecté |
| **Profil** | `/api/profil` | PUT | Modifier le profil |

---

## 🗑️ Endpoints Yogivida à SUPPRIMER

Ces endpoints ne sont plus nécessaires pour l'app Pointage :

- ❌ `/api/pratiques` (yoga)
- ❌ `/api/programmes` (planning yoga)
- ❌ `/api/types-pratiques` (types de yoga)
- ❌ `/api/reservations` (réservations de cours)
- ❌ `/api/lignes-credit` (crédits yoga)
- ❌ `/api/bannieres` (publicités)
- ❌ `/api/favoris` (favoris pratiques)
- ❌ `/api/familles` (catégories boutique)
- ❌ `/api/produits` (produits e-commerce)

---

## 📊 Analyse de l'utilisation actuelle

### Pages utilisant le plus d'endpoints GraphQL

1. **home_page.dart** : 6 DataBloc GraphQL
   - practiceBloc, programmeBloc, notificationPushBloc, banniereBloc, typePracticeBloc, dataBloc

2. **ligne_credit_page.dart** : 3 DataBloc GraphQL
   - lcBloc, utilisateurBloc, typePaiementBloc

3. **Boutique.dart** : 2 DataBloc GraphQL
   - familleBloc, produitBloc

4. **pratique_page.dart** : 2 DataBloc GraphQL
   - practiceBloc, typePracticeBloc

5. **reservations_page.dart** : 2 DataBloc GraphQL
   - reservationBloc0, reservationBloc1

---

## 🎯 Plan d'action

### Phase 1 : Supprimer les fonctionnalités Yogivida
```bash
# Supprimer les pages non nécessaires
rm lib/screens/Home/pratique_*.dart
rm lib/screens/Home/type_pratique_*.dart
rm lib/screens/Compte/reservation*.dart
rm lib/screens/Compte/ligne_credit_page.dart
rm lib/screens/Compte/favoris_page.dart
rm lib/screens/Boutique/*.dart
rm lib/screens/planning/*.dart
```

### Phase 2 : Adapter les pages communes
- ✅ `MonCompte.dart` → Profil utilisateur
- ✅ `dashboard_page.dart` → Dashboard pointage
- ✅ `NotificationPage.dart` → Notifications (garder)

### Phase 3 : Créer les nouvelles pages Pointage
```bash
# Créer la structure
mkdir -p lib/screens/pointages
mkdir -p lib/screens/taches
mkdir -p lib/screens/statistiques
mkdir -p lib/screens/employes

# Créer les pages
touch lib/screens/pointages/pointages_page.dart
touch lib/screens/pointages/pointage_detail.dart
touch lib/screens/taches/taches_page.dart
touch lib/screens/taches/tache_detail.dart
touch lib/screens/statistiques/statistiques_page.dart
touch lib/screens/employes/employes_page.dart
```

---

## 🔄 Exemples de migration

### Avant (GraphQL - Yogivida)
```dart
practiceBloc = DataBloc<List<Pratique>>(
  (response) => Pratique.fromJsonList(response),
  Pratique.getEndpoint(isPagination: true),  // "pratiquepaginated"
  isGraphQl: true,
  isPagination: true,
  attributeToGet: Pratique.shrinkedAttributs(),
);
```

### Après (REST - Pointage)
```dart
pointageBloc = DataBloc<List<Pointage>>(
  (response) => Pointage.fromJsonList(response),
  'pointages',
  isGraphQl: false,
  isPagination: true,
);
```

---

## 📝 Questions à poser à votre ami backend

### 1. Structure des endpoints

**Question :** Les endpoints suivent-ils la convention REST standard ?
- `/api/pointages` → Liste
- `/api/pointages/{id}` → Détail
- `/api/pointages?page=2&per_page=20` → Pagination

**Ou un format personnalisé ?**
- `/api/get_pointages`
- `/api/pointage_detail/123`

### 2. Format de pagination

**Question :** Quel format pour la pagination ?

**Option A (Laravel standard):**
```json
{
  "data": [...],
  "meta": {
    "current_page": 1,
    "last_page": 10,
    "per_page": 20,
    "total": 200
  }
}
```

**Option B (Custom):**
```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "total_pages": 10,
    "count": 20
  }
}
```

### 3. Format des filtres

**Question :** Comment envoyer les filtres ?

**Query params ?**
```
GET /api/pointages?user_id=123&date_debut=2025-01-01
```

**Body POST ?**
```json
POST /api/pointages/search
{
  "filters": {
    "user_id": 123,
    "date_debut": "2025-01-01"
  }
}
```

### 4. Authentification

**Question :** Format du token dans les headers ?

```http
Authorization: Bearer TOKEN
```

ou

```http
X-Auth-Token: TOKEN
```

---

## 📞 Template d'email pour votre ami

```
Salut,

J'ai analysé toute l'architecture de l'app. Voici ce dont j'ai besoin pour finaliser la migration :

📡 **Endpoints nécessaires :**
- GET /api/pointages (liste)
- POST /api/pointages (créer)
- GET /api/taches (liste)
- POST /api/taches (créer)
- GET /api/employes (liste)
- GET /api/profil (utilisateur connecté)
- GET /api/statistiques/pointages

🔑 **Informations techniques :**
1. URL de base : ?
2. Format de pagination : ?
3. Format des erreurs : ?
4. Identifiants de test valides : ?

📄 **Si possible, envoie-moi :**
- Documentation Postman ou Swagger
- Ou exemples de requêtes curl qui fonctionnent

Merci ! 🚀
```

---

**📅 Créé le:** 16 décembre 2025  
**🔍 Analyse basée sur:** 50+ fichiers Dart  
**📊 Endpoints GraphQL trouvés:** 13  
**🆕 Nouveaux endpoints REST nécessaires:** 16  
**⏱️ Temps de migration estimé:** 2-3 heures une fois l'URL reçue

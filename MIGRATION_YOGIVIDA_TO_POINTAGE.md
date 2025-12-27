# 🔄 Guide de Migration : Yogivida (GraphQL) → Pointage (REST API)

## 📊 Résumé de l'architecture actuelle analysée

### ✅ Ce qui est DÉJÀ en place et fonctionnel :

1. **DataBloc** : Système de gestion d'état pour récupérer les données
2. **PostApiBloc** : Système pour créer/modifier/supprimer des données
3. **BlocBasedWidget** : Widget automatique pour afficher les données
4. **Authentification** : Gestion complète du login/logout
5. **Pagination automatique** : Chargement progressif des données
6. **Gestion d'erreurs** : Affichage automatique des erreurs

---

## 🔧 Changements à faire quand vous recevrez l'URL

### 1️⃣ Mettre à jour `constant.dart`

```dart
// Ligne 13 - Remplacez l'URL
const BASE_URL = 'https://NOUVELLE_URL_DE_VOTRE_AMI/';

// Ligne 8 - Confirmez l'endpoint de login (probablement correct)
const LOGIN_ENDPOINT = "api/login";
```

---

### 2️⃣ Adapter TOUS les appels DataBloc existants

**❌ ANCIEN CODE (GraphQL - Yogivida):**
```dart
practiceBloc = DataBloc<List<Pratique>>(
  (response) => Pratique.fromJsonList(response),
  Pratique.getEndpoint(isPagination: true),  // ← "pratiquepaginated"
  isGraphQl: true,                           // ← GraphQL
  isPagination: true,
  attributeToGet: Pratique.shrinkedAttributs(), // ← Query GraphQL
);
```

**✅ NOUVEAU CODE (REST - Pointage):**
```dart
practiceBloc = DataBloc<List<Pratique>>(
  (response) => Pratique.fromJsonList(response),
  'pratiques',              // ← Endpoint simple REST
  isGraphQl: false,         // ← REST API
  isPagination: true,
  // attributeToGet: SUPPRIMÉ (pas besoin pour REST)
);
```

---

### 3️⃣ Mettre à jour les modèles

**Modifiez la méthode `getEndpoint()` dans chaque modèle :**

```dart
// AVANT (GraphQL)
static String getEndpoint({required bool isPagination}) {
  return isPagination ? "pratiquepaginated" : "pratique";
}

// APRÈS (REST)
static String getEndpoint({required bool isPagination}) {
  return "pratiques"; // ← Pluriel, endpoint REST standard
}
```

---

## 📝 Liste complète des fichiers à modifier

### 🔴 PRIORITÉ HAUTE (Bloquants)

| Fichier | Ligne | Action | Détail |
|---------|-------|--------|--------|
| `lib/constant.dart` | 13 | ✅ Changer URL | Remplacer par la nouvelle URL |
| `lib/screens/auth/login_screen.dart` | 80 | ✅ Déjà fait | Envoie `email` au lieu de `login` |
| `packages/authentication_repository/` | 45-90 | ✅ Déjà fait | Gère `{"message":"..."}` |

### 🟡 PRIORITÉ MOYENNE (Endpoints à adapter)

**Tous ces fichiers utilisent `isGraphQl: true` et doivent passer à `isGraphQl: false` :**

#### 📁 `lib/screens/Home/`

1. **home_page.dart** (lignes 93-136)
   - ❌ `practiceBloc` : isGraphQl: true
   - ❌ `programmeBloc` : isGraphQl: true  
   - ❌ `notificationPushBloc` : isGraphQl: true
   - ❌ `banniereBloc` : isGraphQl: true
   - ❌ `typePracticeBloc` : isGraphQl: true
   - ❌ `dataBloc` (Preference) : isGraphQl: true

2. **pratique_page.dart** (lignes 43-59)
   - ❌ `practiceBloc` : isGraphQl: true
   - ❌ `typePracticeBloc` : isGraphQl: true

3. **pratique_detail.dart** (ligne 31)
   - ❌ `dataBloc` : isGraphQl: true

4. **type_pratique_page.dart** (ligne 25)
   - ❌ `typePracticeBloc` : isGraphQl: true

5. **dashboard_page.dart** (à vérifier)
   - Probablement des DataBloc à adapter

#### 📁 `lib/screens/Compte/`

6. **MonCompte.dart**
   - ❌ `utilisateurBloc` : isGraphQl: true

7. **reservations_page.dart** (lignes 37-48)
   - ❌ `reservationBloc0` : isGraphQl: true
   - ❌ `reservationBloc1` : isGraphQl: true

8. **reservation_detail.dart** (ligne 33)
   - ❌ `dataBloc` : isGraphQl: true

9. **ligne_credit_page.dart** (lignes 42-60)
   - ❌ `lcBloc` : isGraphQl: true
   - ❌ `utilisateurBloc` : isGraphQl: true
   - ❌ `typePaiementBloc` : isGraphQl: true

10. **favoris_page.dart** (ligne 40)
    - ❌ `favorisBloc` : isGraphQl: true

11. **type_notificationpush_page.dart** (à vérifier)
    - ❌ `typeNotificationBloc` : isGraphQl: true

12. **LocalisationContact.dart** (ligne 33)
    - ❌ `dataBloc` : isGraphQl: true

#### 📁 `lib/screens/Boutique/`

13. **Boutique.dart** (lignes 79-87)
    - ❌ `familleBloc` : isGraphQl: true
    - ❌ `produitBloc` : isGraphQl: true

14. **produit_detail.dart** (à vérifier)
    - ❌ Probablement isGraphQl: true

#### 📁 `lib/screens/planning/`

15. **Planning.dart** (à vérifier)
    - ❌ Probablement des DataBloc GraphQL

---

## 🎯 Stratégie de migration par étape

### Phase 1 : Configuration (5 minutes)
1. ✅ Attendre l'URL de votre ami
2. ✅ Mettre à jour `constant.dart`
3. ✅ Tester le login avec les vrais identifiants

### Phase 2 : Pages critiques (30 minutes)
1. ✅ `dashboard_page.dart` - Page d'accueil
2. ✅ `MonCompte.dart` - Profil utilisateur
3. ✅ Supprimer/Commenter les pages Yogivida non utilisées

### Phase 3 : Nouvelles fonctionnalités Pointage (1 heure)
1. ✅ Créer page Pointages (arrivée/départ)
2. ✅ Créer page Tâches
3. ✅ Créer page Statistiques
4. ✅ Créer page Employés (admin)

### Phase 4 : Nettoyage (30 minutes)
1. ✅ Supprimer les modèles Yogivida inutilisés
2. ✅ Supprimer les pages Boutique, Pratique, Planning
3. ✅ Nettoyer les imports inutilisés

---

## 🔥 Script de remplacement automatique

### Commande 1 : Trouver tous les `isGraphQl: true`
```bash
grep -r "isGraphQl: true" lib/
```

### Commande 2 : Remplacer automatiquement (BACKUP AVANT !)
```bash
find lib/ -name "*.dart" -exec sed -i '' 's/isGraphQl: true/isGraphQl: false/g' {} +
```

### Commande 3 : Trouver tous les `getEndpoint(isPagination:`
```bash
grep -r "getEndpoint(isPagination:" lib/
```

---

## 📦 Nouveaux endpoints à créer

### Endpoints Pointage (à demander à votre ami)

| Endpoint | Méthode | Usage |
|----------|---------|-------|
| `/api/pointages` | GET | Liste des pointages |
| `/api/pointages` | POST | Créer un pointage (arrivée/départ) |
| `/api/taches` | GET | Liste des tâches |
| `/api/taches/{id}` | GET | Détail d'une tâche |
| `/api/taches` | POST | Créer une tâche |
| `/api/taches/{id}` | PUT | Modifier une tâche |
| `/api/employes` | GET | Liste des employés (admin) |
| `/api/statistiques` | GET | Statistiques de pointage |
| `/api/profil` | GET | Profil utilisateur |

---

## 🚨 Points de vigilance

### ⚠️ Format de réponse attendu

**GraphQL (ancien):**
```json
{
  "data": {
    "pratiquepaginated": {
      "data": [...],
      "metadata": {
        "total": 100,
        "current_page": 1
      }
    }
  }
}
```

**REST (nouveau - probablement):**
```json
{
  "data": [...],
  "meta": {
    "total": 100,
    "current_page": 1
  }
}
```

### ⚠️ Pagination

Si la nouvelle API utilise un format différent pour la pagination, il faudra adapter `data_bloc.dart` ligne 115-125.

---

## ✅ Checklist de migration

### Avant de commencer
- [ ] Recevoir l'URL de l'API de votre ami
- [ ] Recevoir des identifiants de test valides
- [ ] Recevoir la liste des endpoints disponibles
- [ ] Faire un backup du projet (`git commit -am "Backup avant migration"`)

### Configuration
- [ ] Mettre à jour `BASE_URL` dans `constant.dart`
- [ ] Tester le login avec les vrais identifiants
- [ ] Vérifier que le token est sauvegardé

### Migration des pages
- [ ] Dashboard (page d'accueil)
- [ ] Mon Compte (profil)
- [ ] Pointages (nouvelle page)
- [ ] Tâches (nouvelle page)
- [ ] Statistiques (nouvelle page)

### Nettoyage
- [ ] Supprimer les pages Yogivida inutilisées
- [ ] Supprimer les modèles inutilisés
- [ ] Nettoyer les imports

### Tests
- [ ] Login/Logout
- [ ] Récupération de données
- [ ] Création de données
- [ ] Pagination
- [ ] Gestion d'erreurs

---

## 🆘 Aide rapide

### Remplacer GraphQL par REST dans UN fichier

**Cherchez :**
```dart
isGraphQl: true,
```

**Remplacez par :**
```dart
isGraphQl: false,
```

**Supprimez :**
```dart
attributeToGet: Model.shrinkedAttributs()  // ← Cette ligne
```

### Changer un endpoint

**Cherchez :**
```dart
Model.getEndpoint(isPagination: true)
```

**Remplacez par :**
```dart
'models'  // ← Nom de l'endpoint REST (pluriel)
```

---

## 📞 Questions à poser à votre ami backend

1. **Quelle est l'URL complète de l'API ?**
   - Ex: `https://api.example.com/v1/`

2. **Quels sont les endpoints disponibles ?**
   - `/api/pointages`, `/api/taches`, etc.

3. **Format de réponse pour la pagination ?**
   ```json
   {
     "data": [...],
     "meta": { "total": 100 } // ← ou "metadata" ?
   }
   ```

4. **Format de réponse pour les erreurs ?**
   ```json
   {
     "message": "...",
     "errors": { "email": ["..."] }
   }
   ```

5. **Authentification : Bearer token ou autre ?**
   ```
   Authorization: Bearer TOKEN
   ```

6. **Les identifiants de test fonctionnent-ils maintenant ?**

---

## 🎉 Une fois la migration terminée

Votre app sera :
- ✅ Plus rapide (REST plus léger que GraphQL)
- ✅ Plus simple (pas de queries complexes)
- ✅ Plus maintenable (structure standard)
- ✅ Prête pour de nouvelles fonctionnalités !

---

**📅 Créé le:** 16 décembre 2025  
**📝 Dernière mise à jour:** Avant réception de l'URL  
**👤 Auteur:** GitHub Copilot  
**🎯 Projet:** Migration Yogivida → Pointage Mobile

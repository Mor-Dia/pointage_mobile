# 📋 Guide : Système de Statuts pour Planifications

## 🎯 Vue d'ensemble

Le système permet maintenant de **suivre et afficher les statuts des tâches et fonctionnalités** à la fois dans l'application mobile Flutter et dans le backend Laravel.

---

## 🗄️ Structure de la base de données

### Tables modifiées :

#### 1. **`fonctionnalites`**

**Pour PostgreSQL :**
```sql
-- Créer le type ENUM
CREATE TYPE statut_fonctionnalite AS ENUM ('en_cours', 'cloturee');

-- Ajouter la colonne
ALTER TABLE fonctionnalites 
ADD COLUMN statut statut_fonctionnalite DEFAULT 'en_cours';
```

**Pour MySQL :**
```sql
ALTER TABLE fonctionnalites 
ADD COLUMN statut ENUM('en_cours', 'cloturee') DEFAULT 'en_cours';
```

- `en_cours` : Fonctionnalité active
- `cloturee` : Toutes les tâches sont terminées

#### 2. **`projet_taches`**

**Pour PostgreSQL :**
```sql
-- Créer le type ENUM
CREATE TYPE statut_tache AS ENUM ('en_cours', 'terminee');

-- Ajouter la colonne
ALTER TABLE projet_taches 
ADD COLUMN statut statut_tache DEFAULT 'en_cours';
```

**Pour MySQL :**
```sql
ALTER TABLE projet_taches 
ADD COLUMN statut ENUM('en_cours', 'terminee') DEFAULT 'en_cours';
```

- `en_cours` : Tâche non terminée
- `terminee` : Tâche marquée comme terminée

**Note :** La route `/setup-statut-columns` détecte automatiquement votre base de données (PostgreSQL ou MySQL) et applique la syntaxe appropriée.

---

## 🔌 Endpoints API créés

### 1. **POST `/fonctionnalites/{id}/statut`**
Met à jour le statut d'une fonctionnalité.

**Corps de la requête :**
```json
{
  "statut": "cloturee"
}
```

**Réponse :**
```json
{
  "success": true,
  "message": "Statut mis à jour avec succès",
  "data": {
    "id": 1,
    "nom": "Dashboard principal",
    "statut": "cloturee"
  }
}
```

### 2. **POST `/taches/{id}/statut`**
Met à jour le statut d'une tâche. **Clôture automatiquement la fonctionnalité** si toutes ses tâches sont terminées.

**Corps de la requête :**
```json
{
  "statut": "terminee"
}
```

**Réponse :**
```json
{
  "success": true,
  "message": "Statut mis à jour avec succès",
  "data": {
    "id": 5,
    "nom": "Créer le formulaire de login",
    "statut": "terminee"
  }
}
```

### 3. **GET `/setup-statut-columns`**
Crée les colonnes de statut dans les tables (à exécuter une seule fois).

**URL à visiter :**
```
http://localhost/guindy_manager/public/setup-statut-columns
```

---

## 📱 Fonctionnement dans l'application mobile

### Comportement :

1. **Bouton "Terminer" individuel :**
   - Marque la tâche comme `terminee` dans le backend
   - Ajoute la tâche à l'onglet "Tâches clôturées"
   - Si toutes les tâches sont terminées → clôture automatiquement la fonctionnalité

2. **Bouton "Tout terminer" :**
   - Marque toutes les tâches comme `terminee`
   - Marque la fonctionnalité comme `cloturee`
   - Déplace la fonctionnalité vers "Tâches clôturées"

3. **Onglet "Tâches clôturées" :**
   - Affiche les tâches marquées comme terminées
   - Boutons gris et désactivés
   - Permet de voir l'historique des tâches accomplies

---

## 🖥️ Affichage dans le backend Laravel

### Option 1 : Modifier la page Planification existante

Dans la colonne **STATUS** du tableau des planifications, vous pouvez afficher le statut :

#### Fichier à modifier :
`resources/views/planifications/index.blade.php` (ou équivalent)

```blade
<td>
    @if($planification->statut === 'cloturee')
        <span class="badge bg-secondary">Clôturée</span>
    @else
        <span class="badge bg-success">En cours</span>
    @endif
</td>
```

### Option 2 : Créer une page dédiée "Tâches Clôturées"

Créer un nouveau contrôleur et une nouvelle route pour afficher uniquement les fonctionnalités clôturées :

```php
// Route
Route::get('/planifications/cloturees', [PlanificationController::class, 'cloturees']);

// Méthode dans le contrôleur
public function cloturees()
{
    $fonctionnalites = Fonctionnalite::where('statut', 'cloturee')
        ->with(['taches', 'epic.projet'])
        ->orderBy('updated_at', 'desc')
        ->paginate(20);

    return view('planifications.cloturees', compact('fonctionnalites'));
}
```

---

## 🔄 Logique de clôture automatique

### Règle métier implémentée :

**Une fonctionnalité est automatiquement clôturée quand :**
- ✅ Toutes ses tâches ont le statut `terminee`
- ✅ Aucune tâche n'a le statut `en_cours`

Cette logique est appliquée :
1. Dans l'endpoint `/taches/{id}/statut` (côté backend)
2. Dans le bouton "Terminer" de l'app mobile (côté frontend)

---

## 📊 Requêtes SQL utiles

### 1. Voir toutes les fonctionnalités clôturées :
```sql
SELECT f.id, f.nom, f.statut, COUNT(t.id) as nombre_taches
FROM fonctionnalites f
LEFT JOIN projet_taches t ON f.id = t.fonctionnalite_id
WHERE f.statut = 'cloturee'
GROUP BY f.id, f.nom, f.statut;
```

### 2. Voir les tâches terminées par fonctionnalité :
```sql
SELECT f.nom as fonctionnalite, t.nom as tache, t.statut, t.duree
FROM projet_taches t
JOIN fonctionnalites f ON t.fonctionnalite_id = f.id
WHERE t.statut = 'terminee'
ORDER BY f.nom, t.nom;
```

### 3. Compter les tâches terminées vs en cours :
```sql
SELECT 
    f.nom,
    COUNT(CASE WHEN t.statut = 'terminee' THEN 1 END) as terminées,
    COUNT(CASE WHEN t.statut = 'en_cours' THEN 1 END) as en_cours,
    f.statut as statut_fonctionnalite
FROM fonctionnalites f
LEFT JOIN projet_taches t ON f.id = t.fonctionnalite_id
GROUP BY f.id, f.nom, f.statut;
```

---

## 🎨 Suggestions d'affichage dans le backend

### Dans le tableau des planifications :

| DATE DEBUT | DATE FIN | ASSIGNÉ À | PROJET | STATUT | ACTIONS |
|------------|----------|-----------|---------|--------|---------|
| 24/12/2025 | 24/12/2025 | FAYE AOUDY | **01** | <span style="background: #10b981; color: white; padding: 4px 12px; border-radius: 4px;">En cours</span> | ⚙️ |
| 25/12/2025 | 25/12/2025 | TEST TEST | **01** | <span style="background: #6b7280; color: white; padding: 4px 12px; border-radius: 4px;">Clôturée</span> | ⚙️ |

### CSS suggéré :
```css
.badge-en-cours {
    background-color: #10b981; /* Vert */
    color: white;
    padding: 4px 12px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 600;
}

.badge-cloturee {
    background-color: #6b7280; /* Gris */
    color: white;
    padding: 4px 12px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 600;
}
```

---

## ✅ Checklist de déploiement

- [x] Créer les colonnes `statut` dans les tables
- [x] Créer les endpoints API de mise à jour
- [x] Modifier l'endpoint `/planifications-mobile` pour retourner les statuts
- [x] Implémenter la logique de clôture automatique
- [x] Tester les boutons "Terminer" et "Tout terminer" dans l'app mobile
- [ ] Modifier la vue backend pour afficher les statuts
- [ ] Tester la synchronisation mobile ↔ backend
- [ ] Documenter pour l'équipe

---

## 🐛 Tests à effectuer

1. **Test 1 : Terminer une tâche individuelle**
   - Ouvrir une fonctionnalité avec 3 tâches
   - Cliquer sur "Terminer" pour la première tâche
   - Vérifier que la tâche apparaît dans "Tâches clôturées"
   - Vérifier dans la BD que `projet_taches.statut = 'terminee'`

2. **Test 2 : Clôture automatique**
   - Terminer toutes les tâches d'une fonctionnalité une par une
   - Vérifier que la fonctionnalité est automatiquement clôturée
   - Vérifier dans la BD que `fonctionnalites.statut = 'cloturee'`

3. **Test 3 : Tout terminer**
   - Cliquer sur "Tout terminer" dans une fonctionnalité
   - Vérifier que toutes les tâches ET la fonctionnalité sont clôturées
   - Vérifier dans "Tâches clôturées" que tout apparaît

4. **Test 4 : Affichage backend**
   - Rafraîchir la page Planification dans le backend
   - Vérifier que la colonne STATUS affiche "Clôturée"

---

## 📝 Notes importantes

- ⚠️ Les statuts sont maintenant **persistants** en base de données
- ⚠️ La clôture est **automatique** quand toutes les tâches sont terminées
- ⚠️ Les modifications se font en **temps réel** entre mobile et backend
- ⚠️ Le système est **rétroactif** : les anciennes planifications auront le statut `en_cours` par défaut

---

## 🚀 Prochaines améliorations possibles

1. Ajouter un filtre dans le backend pour voir uniquement les planifications clôturées
2. Créer un dashboard avec statistiques (% de tâches terminées)
3. Ajouter un bouton "Réouvrir" pour repasser une tâche en `en_cours`
4. Ajouter des notifications quand une fonctionnalité est clôturée
5. Exporter les tâches clôturées en PDF/Excel

---

**Date de création :** 26 décembre 2025  
**Version :** 1.0  
**Auteur :** GitHub Copilot

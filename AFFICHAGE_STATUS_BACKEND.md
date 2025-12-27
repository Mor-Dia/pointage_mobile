# 🎯 Comment afficher le statut dans la page Planification

## 📍 Page concernée
**URL :** `http://localhost/guindy_manager/public/#!/list-planification`

Cette page utilise **AngularJS + GraphQL** et affiche un tableau avec les colonnes :
- DATE DEBUT
- DATE FIN  
- ASSIGNÉ À
- PROJET
- **STATUS** ← Colonne à personnaliser

---

## 🔧 Solution : Ajouter un attribut calculé dans le modèle

### Étape 1 : Modifier le modèle `Planification`

**Fichier :** `/Applications/XAMPP/xamppfiles/htdocs/guindy_manager/app/Models/Planification.php`

Ajoutez cet accesseur pour calculer automatiquement le statut :

```php
<?php

namespace App\Models;

class Planification extends Model
{
    // ... code existant ...

    /**
     * Attribut calculé : statut de la planification
     * Retourne 'cloturee' si toutes les fonctionnalités sont clôturées
     * Sinon retourne 'en_cours'
     */
    public function getStatusAttribute()
    {
        // Charger les détails de la planification
        $details = $this->planificationassignes;
        
        if ($details->isEmpty()) {
            return 'en_cours';
        }

        // Vérifier si toutes les fonctionnalités sont clôturées
        foreach ($details as $detail) {
            if ($detail->fonctionnalite_id) {
                $fonctionnalite = \App\Models\ProjetFonctionnalite::find($detail->fonctionnalite_id);
                
                // Si une fonctionnalité n'est pas clôturée, la planification est en cours
                if ($fonctionnalite && $fonctionnalite->statut !== 'cloturee') {
                    return 'en_cours';
                }
            }
        }

        // Toutes les fonctionnalités sont clôturées
        return 'cloturee';
    }

    /**
     * Attribut calculé : statut en français
     */
    public function getStatusFrAttribute()
    {
        return $this->status === 'cloturee' ? 'Clôturée' : 'En cours';
    }

    /**
     * Attribut calculé : couleur du badge
     */
    public function getColorStatusAttribute()
    {
        return $this->status === 'cloturee' ? '#6b7280' : '#10b981';
    }

    /**
     * Ajouter les attributs calculés aux attributs sérialisés
     */
    protected $appends = ['status', 'status_fr', 'color_status'];
}
```

---

### Étape 2 : Définir la relation `planificationassignes` dans le modèle

Si la relation n'existe pas déjà, ajoutez-la :

```php
/**
 * Relation : Une planification a plusieurs affectations
 */
public function planificationassignes()
{
    return $this->hasMany(\App\Models\PlanificationAssigne::class, 'planification_id');
}
```

---

## 🎨 Affichage dans le frontend

### Le statut apparaîtra automatiquement dans l'API GraphQL

Quand vous interrogez une planification, les attributs seront disponibles :
```json
{
  "id": 31,
  "date_debut": "2025-12-24",
  "date_fin": "2025-12-24",
  "status": "en_cours",           ← Nouveau
  "status_fr": "En cours",        ← Nouveau
  "color_status": "#10b981"       ← Nouveau
}
```

### L'interface AngularJS affichera automatiquement :

La colonne STATUS dans le tableau utilisera `status_fr` avec un badge coloré selon `color_status`.

---

## 🎨 Alternative : Modifier directement la vue GraphQL

Si le système utilise des types GraphQL, modifiez le fichier :
**`app/GraphQL/Type/PlanificationType.php`**

Ajoutez ces champs :

```php
'status' => [
    'type' => Type::string(),
    'description' => 'Statut de la planification',
    'resolve' => function ($root) {
        // Même logique que l'accesseur
        $details = $root->planificationassignes;
        
        if ($details->isEmpty()) {
            return 'en_cours';
        }

        foreach ($details as $detail) {
            if ($detail->fonctionnalite_id) {
                $fonctionnalite = \App\Models\ProjetFonctionnalite::find($detail->fonctionnalite_id);
                if ($fonctionnalite && $fonctionnalite->statut !== 'cloturee') {
                    return 'en_cours';
                }
            }
        }

        return 'cloturee';
    }
],
'status_fr' => [
    'type' => Type::string(),
    'description' => 'Statut en français',
    'resolve' => function ($root) {
        return $root->status === 'cloturee' ? 'Clôturée' : 'En cours';
    }
],
'color_status' => [
    'type' => Type::string(),
    'description' => 'Couleur du badge de statut',
    'resolve' => function ($root) {
        return $root->status === 'cloturee' ? '#6b7280' : '#10b981';
    }
]
```

---

## ✅ Résultat attendu

Dans le tableau de la page `list-planification`, la colonne **STATUS** affichera :

| DATE DEBUT | DATE FIN | ASSIGNÉ À | PROJET | STATUS |
|------------|----------|-----------|---------|--------|
| 24/12/2025 | 24/12/2025 | FAYE AOUDY | **01** | <span style="background: #10b981; color: white; padding: 4px 12px; border-radius: 4px;">En cours</span> |
| 25/12/2025 | 25/12/2025 | TEST TEST | **01** | <span style="background: #6b7280; color: white; padding: 4px 12px; border-radius: 4px;">Clôturée</span> |

---

## 🔄 Rafraîchir après modification

1. Modifier le fichier `/app/Models/Planification.php`
2. Rafraîchir la page dans le navigateur (F5)
3. Le statut devrait apparaître automatiquement

Si le cache GraphQL pose problème :
```bash
php artisan cache:clear
php artisan config:clear
```

---

**Fichiers à modifier :**
- ✅ `/app/Models/Planification.php` (accesseurs)
- ⚠️ Optionnel : `/app/GraphQL/Type/PlanificationType.php` (si système GraphQL)


#!/bin/bash

# 🔄 Script de migration automatique Yogivida → Pointage
# Utilisation: ./migrate_to_rest_api.sh

echo "🔄 MIGRATION YOGIVIDA (GraphQL) → POINTAGE (REST API)"
echo "======================================================="
echo ""

# Vérifier si on est dans le bon dossier
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Erreur: Ce script doit être exécuté à la racine du projet Flutter"
    exit 1
fi

echo "📋 Étape 1: Créer un backup..."
git add -A
git commit -m "🔖 Backup avant migration GraphQL → REST" || echo "⚠️ Aucun changement à sauvegarder"
echo "✅ Backup créé (ou déjà à jour)"
echo ""

echo "🔍 Étape 2: Analyse des fichiers à modifier..."
echo "Fichiers contenant 'isGraphQl: true':"
grep -r "isGraphQl: true" lib/ --include="*.dart" | wc -l
echo ""

echo "❓ Voulez-vous continuer la migration automatique? (o/n)"
read -r CONTINUE

if [ "$CONTINUE" != "o" ]; then
    echo "❌ Migration annulée"
    exit 0
fi

echo ""
echo "🔧 Étape 3: Remplacement de 'isGraphQl: true' par 'isGraphQl: false'..."
find lib/ -name "*.dart" -exec sed -i '' 's/isGraphQl: true/isGraphQl: false/g' {} +
echo "✅ Remplacements effectués"
echo ""

echo "📊 Étape 4: Vérification..."
echo "Fichiers restants avec 'isGraphQl: true':"
grep -r "isGraphQl: true" lib/ --include="*.dart" | wc -l || echo "0"
echo ""

echo "🎨 Étape 5: Formatage du code..."
dart format lib/
echo "✅ Code formaté"
echo ""

echo "🔍 Étape 6: Analyse des erreurs..."
flutter analyze --no-pub | head -n 50
echo ""

echo "✅ MIGRATION AUTOMATIQUE TERMINÉE !"
echo ""
echo "📝 Prochaines étapes MANUELLES:"
echo "  1. Vérifiez lib/constant.dart ligne 13 (BASE_URL)"
echo "  2. Testez l'app: flutter run"
echo "  3. Vérifiez les logs pour les erreurs d'API"
echo "  4. Adaptez les modèles si nécessaire"
echo ""
echo "📄 Consultez MIGRATION_YOGIVIDA_TO_POINTAGE.md pour plus de détails"

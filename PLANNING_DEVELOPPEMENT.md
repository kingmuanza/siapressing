# Planning de Développement - SIA Pressing

## Vue d'ensemble du projet

Application Flutter de gestion de pressing avec :

- Gestion des dépôts et clients
- Impression automatique (marquage 58mm + factures 80mm)
- Suivi de production
- Encaissement

---

## Phase 1 : Architecture et Base de données

### 1.1 Structure du projet

- [x] Créer l'architecture des dossiers (`lib/models`, `lib/screens`, `lib/services`, `lib/widgets`, `lib/utils`)
- [x] Configurer les dépendances (sqflite, provider/riverpod, intl, etc.)
- [x] Mettre en place le système de thème et constantes de l'app

### 1.2 Modèles de données

- [x] Modèle `Client` (id, nom, téléphone, email, historique)
- [x] Modèle `Article` (id, nom, catégorie, prix, code interne, image)
- [x] Modèle `Commande` (id, numéro, client, date dépôt, date retrait, statut, total)
- [x] Modèle `LigneCommande` (article, quantité, prix, remarques/réserves)
- [x] Modèle `Paiement` (id, commande, montant, date, mode)
- [x] Modèle `Parametres` (couleur du jour, configuration impression, etc.)

### 1.3 Base de données locale

- [ ] Configurer SQLite avec sqflite
- [ ] Créer les tables et migrations
- [ ] Implémenter les DAOs (Data Access Objects)
- [ ] Système de sauvegarde automatique quotidienne

---

## Phase 2 : Gestion des Articles

### 2.1 Configuration des articles

- [ ] Écran liste des catégories (vêtements, ameublement, cuir, blanchisserie)
- [ ] Écran liste des articles par catégorie
- [ ] Formulaire ajout/modification article (nom, prix, code, image)
- [ ] Import/export des articles

### 2.2 Grille de sélection rapide

- [ ] Widget grille tactile avec icônes
- [ ] Affichage prix unitaire TTC
- [ ] Gestion des favoris/articles fréquents

---

## Phase 3 : Gestion des Clients

### 3.1 Base clients

- [ ] Écran recherche client (par nom, téléphone)
- [ ] Formulaire création/modification client
- [ ] Historique complet des commandes par client
- [ ] Fiche client détaillée

---

## Phase 4 : Écran Principal de Dépôt

### 4.1 Interface de dépôt

- [ ] Zone identification client (recherche rapide)
- [ ] Grille sélection articles avec icônes
- [ ] Liste des articles sélectionnés avec quantités
- [ ] Calcul automatique total TTC
- [ ] Sélection date dépôt et date retrait prévue

### 4.2 Gestion des remarques/réserves

- [ ] Ajout remarques par article (tache, sans garantie, lavage spécial)
- [ ] Tickets réserves séparés ou intégrés (configurable)

### 4.3 Clavier tactile

- [ ] Clavier numérique intégré
- [ ] Clavier alphabétique intégré
- [ ] Optimisation interface tactile

### 4.4 Couleur du jour

- [ ] Sélection automatique couleur du jour
- [ ] Configuration des couleurs par jour de la semaine
- [ ] Affichage visuel de la couleur active

---

## Phase 5 : Module Impression

### 5.1 Service d'impression ESC/POS

- [ ] Intégration bibliothèque ESC/POS Flutter
- [ ] Détection et connexion imprimantes (USB/Bluetooth/Réseau)
- [ ] Gestion des commandes de coupe (auto-cutter)
- [ ] Gestion erreurs impression

### 5.2 Imprimante 58mm - Marquage

- [ ] Template ticket article (numéro commande, date, index, article, prix, prestation)
- [ ] Impression ticket couleur du jour (premier dépôt)
- [ ] Coupe automatique après chaque ticket
- [ ] Réimpression ticket individuel

### 5.3 Imprimante 80mm - Factures

- [ ] Template facture complète :
  - En-tête (nom pressing, adresse, téléphone, email)
  - Code-barres numéro commande
  - Infos client
  - Liste détaillée articles
  - Section réserves
  - Total TTC + détail TVA
  - Mentions légales + horaires
- [ ] Impression duplicata automatique (avec mention "DUPLICATA")
- [ ] Logo pressing
- [ ] Réimpression facture

### 5.4 Paramètres impression

- [ ] Configuration longueur ticket
- [ ] Configuration police
- [ ] Activation/désactivation duplicata automatique

---

## Phase 6 : Suivi de Production

### 6.1 Écran suivi commandes

- [ ] Liste des commandes avec filtres (date, statut, client)
- [ ] Statuts : En cours / Prêt / Livré
- [ ] Changement de statut par lot ou individuel
- [ ] Visualisation articles prêts

### 6.2 Bon de livraison

- [ ] Génération bon de livraison valorisé
- [ ] Génération bon de livraison non valorisé
- [ ] Impression bon de livraison

---

## Phase 7 : Encaissement

### 7.1 Module paiement

- [ ] Écran encaissement avec détail commande
- [ ] Paiement total ou partiel
- [ ] Affichage reste dû
- [ ] Modes de paiement (espèces, CB, chèque)

### 7.2 Historique et comptabilité

- [ ] Historique encaissement journalier
- [ ] Clôture de caisse
- [ ] Export comptable (Excel/PDF)

### 7.3 Mode B2B

- [ ] Activation/désactivation mode entreprise
- [ ] Gestion comptes entreprises
- [ ] Facturation différée

---

## Phase 8 : Paramètres et Configuration

### 8.1 Paramètres généraux

- [ ] Configuration informations pressing (nom, adresse, téléphone, email)
- [ ] Configuration horaires d'ouverture
- [ ] Mentions légales personnalisables

### 8.2 Configuration TVA

- [ ] Taux de TVA configurables
- [ ] Calcul automatique base HT / montant TVA

### 8.3 Multi-comptoir / Multi-boutiques

- [ ] Architecture multi-boutiques
- [ ] Synchronisation données

### 8.4 Sauvegarde

- [ ] Sauvegarde locale automatique
- [ ] Sauvegarde cloud (optionnel)
- [ ] Restauration des données

---

## Phase 9 : Tests et Optimisation

### 9.1 Tests

- [ ] Tests unitaires modèles et services
- [ ] Tests widgets
- [ ] Tests intégration impression
- [ ] Tests de performance

### 9.2 Optimisation

- [ ] Optimisation interface tactile
- [ ] Optimisation temps de réponse
- [ ] Gestion mémoire pour longues sessions

---

## Phase 10 : Déploiement

### 10.1 Préparation

- [ ] Configuration build release
- [ ] Tests sur environnement de production
- [ ] Documentation utilisateur

### 10.2 Déploiement

- [ ] Installation sur POS Windows
- [ ] Configuration imprimantes sur site
- [ ] Formation utilisateurs

---

## Dépendances Flutter suggérées

```yaml
dependencies:
  # State management
  provider: ^6.0.0
  # ou riverpod: ^2.0.0

  # Base de données
  sqflite: ^2.3.0
  path: ^1.8.0

  # Impression ESC/POS
  esc_pos_utils: ^1.1.0
  esc_pos_printer: ^4.1.0

  # Code-barres
  barcode: ^2.2.0

  # Dates
  intl: ^0.18.0

  # Export
  excel: ^4.0.0
  pdf: ^3.10.0
  printing: ^5.11.0

  # Images
  image_picker: ^1.0.0

  # Stockage
  shared_preferences: ^2.2.0
```

---

## Notes techniques

- **Compatibilité** : Windows POS, imprimantes ESC/POS
- **Architecture** : MVVM ou Clean Architecture recommandé
- **Base de données** : SQLite local avec possibilité de sync cloud
- **Impression** : Commandes ESC/POS natives avec gestion auto-cutter

---

## Priorités de développement

1. **Critique** : Phases 1, 4, 5 (architecture, dépôt, impression)
2. **Important** : Phases 2, 3, 6, 7 (articles, clients, production, encaissement)
3. **Secondaire** : Phases 8, 9, 10 (paramètres, tests, déploiement)

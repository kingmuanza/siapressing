import 'package:flutter/material.dart';

/// Constantes de l'application SIA Pressing

class AppColors {
  AppColors._();

  // Couleurs principales
  static const Color primary = Color(0xFF1565C0); // Bleu pressing
  static const Color primaryLight = Color(0xFF5E92F3);
  static const Color primaryDark = Color(0xFF003C8F);

  // Couleurs secondaires
  static const Color secondary = Color(0xFF26A69A); // Vert-turquoise
  static const Color secondaryLight = Color(0xFF64D8CB);
  static const Color secondaryDark = Color(0xFF00766C);

  // Couleurs de fond
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;

  // Couleurs de texte
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Colors.white;

  // Couleurs de statut
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Couleurs des jours (pour le marquage)
  static const Map<int, Color> dailyColors = {
    DateTime.monday: Color(0xFFE53935),    // Rouge
    DateTime.tuesday: Color(0xFF8E24AA),   // Violet
    DateTime.wednesday: Color(0xFF43A047), // Vert
    DateTime.thursday: Color(0xFFFB8C00),  // Orange
    DateTime.friday: Color(0xFF1E88E5),    // Bleu
    DateTime.saturday: Color(0xFF6D4C41),  // Marron
    DateTime.sunday: Color(0xFF546E7A),    // Gris-bleu
  };

  // Couleurs de statut commande
  static const Color statusEnCours = Color(0xFFFF9800);  // Orange
  static const Color statusPret = Color(0xFF4CAF50);     // Vert
  static const Color statusLivre = Color(0xFF2196F3);    // Bleu
}

class AppDimensions {
  AppDimensions._();

  // Padding et marges
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Border radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;

  // Tailles de police
  static const double fontXS = 10.0;
  static const double fontS = 12.0;
  static const double fontM = 14.0;
  static const double fontL = 16.0;
  static const double fontXL = 18.0;
  static const double fontXXL = 24.0;
  static const double fontTitle = 32.0;

  // Tailles d'icônes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Hauteurs de boutons
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;

  // Grille articles (interface tactile)
  static const double gridItemSize = 100.0;
  static const double gridSpacing = 8.0;
}

class AppStrings {
  AppStrings._();

  // Nom de l'application
  static const String appName = 'SIA Pressing';
  static const String appVersion = '1.0.0';

  // Messages généraux
  static const String loading = 'Chargement...';
  static const String error = 'Une erreur est survenue';
  static const String success = 'Opération réussie';
  static const String confirm = 'Confirmer';
  static const String cancel = 'Annuler';
  static const String save = 'Enregistrer';
  static const String delete = 'Supprimer';
  static const String edit = 'Modifier';
  static const String add = 'Ajouter';
  static const String search = 'Rechercher';

  // Statuts commande
  static const String statusEnCours = 'En cours';
  static const String statusPret = 'Prêt';
  static const String statusLivre = 'Livré';

  // Modes de paiement
  static const String paiementEspeces = 'Espèces';
  static const String paiementCB = 'Carte bancaire';
  static const String paiementCheque = 'Chèque';

  // Catégories d'articles
  static const String categorieVetements = 'Vêtements';
  static const String categorieAmeublement = 'Ameublement';
  static const String categorieCuir = 'Cuir';
  static const String categorieBlanchisserie = 'Blanchisserie';
}

class AppConfig {
  AppConfig._();

  // Configuration TVA
  static const double tauxTVA = 20.0; // 20%

  // Configuration impression
  static const int largeurTicket58mm = 384; // pixels
  static const int largeurTicket80mm = 576; // pixels

  // Durée par défaut (en jours)
  static const int delaiRetraitDefaut = 2;

  // Base de données
  static const String dbName = 'siapressing.db';
  static const int dbVersion = 1;
}

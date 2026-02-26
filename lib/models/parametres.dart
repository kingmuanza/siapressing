import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Configuration des couleurs par jour de la semaine
class CouleurJour {
  final int jourSemaine; // 1 = lundi, 7 = dimanche
  final Color couleur;
  final String nom;

  const CouleurJour({
    required this.jourSemaine,
    required this.couleur,
    required this.nom,
  });

  Map<String, dynamic> toJson() {
    return {
      'jourSemaine': jourSemaine,
      'couleur': couleur.toHex(),
      'nom': nom,
    };
  }

  factory CouleurJour.fromJson(Map<String, dynamic> json) {
    return CouleurJour(
      jourSemaine: json['jourSemaine'] as int,
      couleur: HexColor.fromHex(json['couleur'] as String),
      nom: json['nom'] as String,
    );
  }
}

/// Extension pour convertir Color en hex et vice versa
extension HexColor on Color {
  String toHex() => '#${toARGB32().toRadixString(16).padLeft(8, '0')}';

  static Color fromHex(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}

/// Configuration de l'impression
class ConfigImpression {
  final bool activerImpression58mm;
  final bool activerImpression80mm;
  final bool imprimerDuplicata;
  final String? adresseImprimante58mm;
  final String? adresseImprimante80mm;
  final int longueurTicket;

  const ConfigImpression({
    this.activerImpression58mm = true,
    this.activerImpression80mm = true,
    this.imprimerDuplicata = true,
    this.adresseImprimante58mm,
    this.adresseImprimante80mm,
    this.longueurTicket = 0,
  });

  ConfigImpression copyWith({
    bool? activerImpression58mm,
    bool? activerImpression80mm,
    bool? imprimerDuplicata,
    String? adresseImprimante58mm,
    String? adresseImprimante80mm,
    int? longueurTicket,
  }) {
    return ConfigImpression(
      activerImpression58mm:
          activerImpression58mm ?? this.activerImpression58mm,
      activerImpression80mm:
          activerImpression80mm ?? this.activerImpression80mm,
      imprimerDuplicata: imprimerDuplicata ?? this.imprimerDuplicata,
      adresseImprimante58mm:
          adresseImprimante58mm ?? this.adresseImprimante58mm,
      adresseImprimante80mm:
          adresseImprimante80mm ?? this.adresseImprimante80mm,
      longueurTicket: longueurTicket ?? this.longueurTicket,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activerImpression58mm': activerImpression58mm,
      'activerImpression80mm': activerImpression80mm,
      'imprimerDuplicata': imprimerDuplicata,
      'adresseImprimante58mm': adresseImprimante58mm,
      'adresseImprimante80mm': adresseImprimante80mm,
      'longueurTicket': longueurTicket,
    };
  }

  factory ConfigImpression.fromJson(Map<String, dynamic> json) {
    return ConfigImpression(
      activerImpression58mm: json['activerImpression58mm'] as bool? ?? true,
      activerImpression80mm: json['activerImpression80mm'] as bool? ?? true,
      imprimerDuplicata: json['imprimerDuplicata'] as bool? ?? true,
      adresseImprimante58mm: json['adresseImprimante58mm'] as String?,
      adresseImprimante80mm: json['adresseImprimante80mm'] as String?,
      longueurTicket: json['longueurTicket'] as int? ?? 0,
    );
  }
}

/// Modèle contenant tous les paramètres de l'application
class Parametres {
  // Informations du pressing
  final String nomPressing;
  final String? adresse;
  final String? telephone;
  final String? email;
  final String? siteWeb;
  final String? siret;
  final String? numeroTVA;
  final String? logoPath;

  // Horaires
  final String? horaires;

  // Mentions légales
  final String? mentionsLegales;
  final String? conditionsGenerales;

  // Configuration TVA
  final double tauxTVA;

  // Délai retrait par défaut (en jours)
  final int delaiRetraitDefaut;

  // Couleurs du jour
  final List<CouleurJour> couleursJour;

  // Configuration impression
  final ConfigImpression configImpression;

  // Mode entreprise (B2B)
  final bool modeEntrepriseActif;

  // Numéro de commande courant
  final int dernierNumeroCommande;

  Parametres({
    this.nomPressing = 'SIA Pressing',
    this.adresse,
    this.telephone,
    this.email,
    this.siteWeb,
    this.siret,
    this.numeroTVA,
    this.logoPath,
    this.horaires,
    this.mentionsLegales,
    this.conditionsGenerales,
    this.tauxTVA = 20.0,
    this.delaiRetraitDefaut = 2,
    List<CouleurJour>? couleursJour,
    this.configImpression = const ConfigImpression(),
    this.modeEntrepriseActif = false,
    this.dernierNumeroCommande = 0,
  }) : couleursJour = couleursJour ?? _defaultCouleursJour;

  /// Couleurs par défaut pour chaque jour
  static final List<CouleurJour> _defaultCouleursJour = [
    CouleurJour(
        jourSemaine: DateTime.monday,
        couleur: AppColors.dailyColors[DateTime.monday]!,
        nom: 'Rouge'),
    CouleurJour(
        jourSemaine: DateTime.tuesday,
        couleur: AppColors.dailyColors[DateTime.tuesday]!,
        nom: 'Violet'),
    CouleurJour(
        jourSemaine: DateTime.wednesday,
        couleur: AppColors.dailyColors[DateTime.wednesday]!,
        nom: 'Vert'),
    CouleurJour(
        jourSemaine: DateTime.thursday,
        couleur: AppColors.dailyColors[DateTime.thursday]!,
        nom: 'Orange'),
    CouleurJour(
        jourSemaine: DateTime.friday,
        couleur: AppColors.dailyColors[DateTime.friday]!,
        nom: 'Bleu'),
    CouleurJour(
        jourSemaine: DateTime.saturday,
        couleur: AppColors.dailyColors[DateTime.saturday]!,
        nom: 'Marron'),
    CouleurJour(
        jourSemaine: DateTime.sunday,
        couleur: AppColors.dailyColors[DateTime.sunday]!,
        nom: 'Gris'),
  ];

  /// Obtient la couleur du jour actuel
  CouleurJour get couleurDuJour {
    final aujourdHui = DateTime.now().weekday;
    return couleursJour.firstWhere(
      (c) => c.jourSemaine == aujourdHui,
      orElse: () => couleursJour.first,
    );
  }

  /// Génère le prochain numéro de commande
  String genererNumeroCommande() {
    final date = DateTime.now();
    final annee = date.year.toString().substring(2);
    final mois = date.month.toString().padLeft(2, '0');
    final numero = (dernierNumeroCommande + 1).toString().padLeft(5, '0');
    return '$annee$mois-$numero';
  }

  /// Crée une copie avec des valeurs modifiées
  Parametres copyWith({
    String? nomPressing,
    String? adresse,
    String? telephone,
    String? email,
    String? siteWeb,
    String? siret,
    String? numeroTVA,
    String? logoPath,
    String? horaires,
    String? mentionsLegales,
    String? conditionsGenerales,
    double? tauxTVA,
    int? delaiRetraitDefaut,
    List<CouleurJour>? couleursJour,
    ConfigImpression? configImpression,
    bool? modeEntrepriseActif,
    int? dernierNumeroCommande,
  }) {
    return Parametres(
      nomPressing: nomPressing ?? this.nomPressing,
      adresse: adresse ?? this.adresse,
      telephone: telephone ?? this.telephone,
      email: email ?? this.email,
      siteWeb: siteWeb ?? this.siteWeb,
      siret: siret ?? this.siret,
      numeroTVA: numeroTVA ?? this.numeroTVA,
      logoPath: logoPath ?? this.logoPath,
      horaires: horaires ?? this.horaires,
      mentionsLegales: mentionsLegales ?? this.mentionsLegales,
      conditionsGenerales: conditionsGenerales ?? this.conditionsGenerales,
      tauxTVA: tauxTVA ?? this.tauxTVA,
      delaiRetraitDefaut: delaiRetraitDefaut ?? this.delaiRetraitDefaut,
      couleursJour: couleursJour ?? this.couleursJour,
      configImpression: configImpression ?? this.configImpression,
      modeEntrepriseActif: modeEntrepriseActif ?? this.modeEntrepriseActif,
      dernierNumeroCommande:
          dernierNumeroCommande ?? this.dernierNumeroCommande,
    );
  }

  /// Convertit en JSON
  Map<String, dynamic> toJson() {
    return {
      'nomPressing': nomPressing,
      'adresse': adresse,
      'telephone': telephone,
      'email': email,
      'siteWeb': siteWeb,
      'siret': siret,
      'numeroTVA': numeroTVA,
      'logoPath': logoPath,
      'horaires': horaires,
      'mentionsLegales': mentionsLegales,
      'conditionsGenerales': conditionsGenerales,
      'tauxTVA': tauxTVA,
      'delaiRetraitDefaut': delaiRetraitDefaut,
      'couleursJour': couleursJour.map((c) => c.toJson()).toList(),
      'configImpression': configImpression.toJson(),
      'modeEntrepriseActif': modeEntrepriseActif,
      'dernierNumeroCommande': dernierNumeroCommande,
    };
  }

  /// Crée des Parametres depuis JSON
  factory Parametres.fromJson(Map<String, dynamic> json) {
    return Parametres(
      nomPressing: json['nomPressing'] as String? ?? 'SIA Pressing',
      adresse: json['adresse'] as String?,
      telephone: json['telephone'] as String?,
      email: json['email'] as String?,
      siteWeb: json['siteWeb'] as String?,
      siret: json['siret'] as String?,
      numeroTVA: json['numeroTVA'] as String?,
      logoPath: json['logoPath'] as String?,
      horaires: json['horaires'] as String?,
      mentionsLegales: json['mentionsLegales'] as String?,
      conditionsGenerales: json['conditionsGenerales'] as String?,
      tauxTVA: (json['tauxTVA'] as num?)?.toDouble() ?? 20.0,
      delaiRetraitDefaut: json['delaiRetraitDefaut'] as int? ?? 2,
      couleursJour: (json['couleursJour'] as List<dynamic>?)
          ?.map((c) => CouleurJour.fromJson(c as Map<String, dynamic>))
          .toList(),
      configImpression: json['configImpression'] != null
          ? ConfigImpression.fromJson(
              json['configImpression'] as Map<String, dynamic>)
          : const ConfigImpression(),
      modeEntrepriseActif: json['modeEntrepriseActif'] as bool? ?? false,
      dernierNumeroCommande: json['dernierNumeroCommande'] as int? ?? 0,
    );
  }

  /// Encode en String JSON
  String toJsonString() => jsonEncode(toJson());

  /// Crée depuis une String JSON
  factory Parametres.fromJsonString(String source) =>
      Parametres.fromJson(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Parametres(nomPressing: $nomPressing, tauxTVA: $tauxTVA%)';
  }
}

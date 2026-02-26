import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'ligne_commande.dart';

/// Statuts possibles d'une commande
enum StatutCommande {
  enCours('En cours'),
  pret('Prêt'),
  livre('Livré');

  final String libelle;
  const StatutCommande(this.libelle);

  static StatutCommande fromString(String value) {
    return StatutCommande.values.firstWhere(
      (e) => e.name == value || e.libelle == value,
      orElse: () => StatutCommande.enCours,
    );
  }

  /// Couleur associée au statut
  Color get couleur {
    switch (this) {
      case StatutCommande.enCours:
        return AppColors.statusEnCours;
      case StatutCommande.pret:
        return AppColors.statusPret;
      case StatutCommande.livre:
        return AppColors.statusLivre;
    }
  }
}

/// Modèle représentant une commande/dépôt
class Commande {
  final int? id;
  final String numero;
  final int clientId;
  final DateTime dateDepot;
  final DateTime dateRetraitPrevue;
  final DateTime? dateRetraitEffective;
  final StatutCommande statut;
  final double totalTTC;
  final double montantPaye;
  final String? couleurJour;
  final String? notes;
  final List<LigneCommande> lignes;

  Commande({
    this.id,
    required this.numero,
    required this.clientId,
    required this.dateDepot,
    required this.dateRetraitPrevue,
    this.dateRetraitEffective,
    this.statut = StatutCommande.enCours,
    this.totalTTC = 0,
    this.montantPaye = 0,
    this.couleurJour,
    this.notes,
    this.lignes = const [],
  });

  /// Total HT calculé (TVA 20%)
  double get totalHT => totalTTC / 1.20;

  /// Montant TVA
  double get montantTVA => totalTTC - totalHT;

  /// Reste à payer
  double get resteAPayer => totalTTC - montantPaye;

  /// Commande entièrement payée
  bool get estPayee => resteAPayer <= 0;

  /// Nombre total d'articles
  int get nombreArticles => lignes.fold<int>(0, (sum, l) => sum + l.quantite);

  /// Crée une copie avec des valeurs modifiées
  Commande copyWith({
    int? id,
    String? numero,
    int? clientId,
    DateTime? dateDepot,
    DateTime? dateRetraitPrevue,
    DateTime? dateRetraitEffective,
    StatutCommande? statut,
    double? totalTTC,
    double? montantPaye,
    String? couleurJour,
    String? notes,
    List<LigneCommande>? lignes,
  }) {
    return Commande(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      clientId: clientId ?? this.clientId,
      dateDepot: dateDepot ?? this.dateDepot,
      dateRetraitPrevue: dateRetraitPrevue ?? this.dateRetraitPrevue,
      dateRetraitEffective: dateRetraitEffective ?? this.dateRetraitEffective,
      statut: statut ?? this.statut,
      totalTTC: totalTTC ?? this.totalTTC,
      montantPaye: montantPaye ?? this.montantPaye,
      couleurJour: couleurJour ?? this.couleurJour,
      notes: notes ?? this.notes,
      lignes: lignes ?? this.lignes,
    );
  }

  /// Recalcule le total depuis les lignes
  Commande recalculerTotal() {
    final nouveauTotal = lignes.fold(0.0, (sum, l) => sum + l.totalLigne);
    return copyWith(totalTTC: nouveauTotal);
  }

  /// Convertit en Map pour SQLite (sans les lignes)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'numero': numero,
      'client_id': clientId,
      'date_depot': dateDepot.toIso8601String(),
      'date_retrait_prevue': dateRetraitPrevue.toIso8601String(),
      'date_retrait_effective': dateRetraitEffective?.toIso8601String(),
      'statut': statut.name,
      'total_ttc': totalTTC,
      'montant_paye': montantPaye,
      'couleur_jour': couleurJour,
      'notes': notes,
    };
  }

  /// Crée une Commande depuis un Map SQLite (sans les lignes)
  factory Commande.fromMap(Map<String, dynamic> map,
      {List<LigneCommande>? lignes}) {
    return Commande(
      id: map['id'] as int?,
      numero: map['numero'] as String,
      clientId: map['client_id'] as int,
      dateDepot: DateTime.parse(map['date_depot'] as String),
      dateRetraitPrevue: DateTime.parse(map['date_retrait_prevue'] as String),
      dateRetraitEffective: map['date_retrait_effective'] != null
          ? DateTime.parse(map['date_retrait_effective'] as String)
          : null,
      statut: StatutCommande.fromString(map['statut'] as String),
      totalTTC: (map['total_ttc'] as num).toDouble(),
      montantPaye: (map['montant_paye'] as num).toDouble(),
      couleurJour: map['couleur_jour'] as String?,
      notes: map['notes'] as String?,
      lignes: lignes ?? [],
    );
  }

  /// Convertit en JSON (avec les lignes)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'clientId': clientId,
      'dateDepot': dateDepot.toIso8601String(),
      'dateRetraitPrevue': dateRetraitPrevue.toIso8601String(),
      'dateRetraitEffective': dateRetraitEffective?.toIso8601String(),
      'statut': statut.name,
      'totalTTC': totalTTC,
      'montantPaye': montantPaye,
      'couleurJour': couleurJour,
      'notes': notes,
      'lignes': lignes.map((l) => l.toJson()).toList(),
    };
  }

  /// Crée une Commande depuis JSON (avec les lignes)
  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'] as int?,
      numero: json['numero'] as String,
      clientId: json['clientId'] as int,
      dateDepot: DateTime.parse(json['dateDepot'] as String),
      dateRetraitPrevue: DateTime.parse(json['dateRetraitPrevue'] as String),
      dateRetraitEffective: json['dateRetraitEffective'] != null
          ? DateTime.parse(json['dateRetraitEffective'] as String)
          : null,
      statut: StatutCommande.fromString(json['statut'] as String),
      totalTTC: (json['totalTTC'] as num).toDouble(),
      montantPaye: (json['montantPaye'] as num).toDouble(),
      couleurJour: json['couleurJour'] as String?,
      notes: json['notes'] as String?,
      lignes: (json['lignes'] as List<dynamic>?)
              ?.map((l) => LigneCommande.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Encode en String JSON
  String toJsonString() => jsonEncode(toJson());

  /// Crée depuis une String JSON
  factory Commande.fromJsonString(String source) =>
      Commande.fromJson(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Commande(id: $id, numero: $numero, statut: ${statut.libelle}, total: $totalTTC€)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Commande && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

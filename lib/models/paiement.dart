import 'dart:convert';

/// Modes de paiement disponibles
enum ModePaiement {
  especes('Espèces'),
  carteBancaire('Carte bancaire'),
  cheque('Chèque'),
  virement('Virement'),
  avoir('Avoir');

  final String libelle;
  const ModePaiement(this.libelle);

  static ModePaiement fromString(String value) {
    return ModePaiement.values.firstWhere(
      (e) => e.name == value || e.libelle == value,
      orElse: () => ModePaiement.especes,
    );
  }
}

/// Modèle représentant un paiement
class Paiement {
  final int? id;
  final int commandeId;
  final double montant;
  final ModePaiement mode;
  final DateTime date;
  final String? reference;
  final String? notes;

  Paiement({
    this.id,
    required this.commandeId,
    required this.montant,
    required this.mode,
    DateTime? date,
    this.reference,
    this.notes,
  }) : date = date ?? DateTime.now();

  /// Crée une copie avec des valeurs modifiées
  Paiement copyWith({
    int? id,
    int? commandeId,
    double? montant,
    ModePaiement? mode,
    DateTime? date,
    String? reference,
    String? notes,
  }) {
    return Paiement(
      id: id ?? this.id,
      commandeId: commandeId ?? this.commandeId,
      montant: montant ?? this.montant,
      mode: mode ?? this.mode,
      date: date ?? this.date,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
    );
  }

  /// Convertit en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'commande_id': commandeId,
      'montant': montant,
      'mode': mode.name,
      'date': date.toIso8601String(),
      'reference': reference,
      'notes': notes,
    };
  }

  /// Crée un Paiement depuis un Map SQLite
  factory Paiement.fromMap(Map<String, dynamic> map) {
    return Paiement(
      id: map['id'] as int?,
      commandeId: map['commande_id'] as int,
      montant: (map['montant'] as num).toDouble(),
      mode: ModePaiement.fromString(map['mode'] as String),
      date: DateTime.parse(map['date'] as String),
      reference: map['reference'] as String?,
      notes: map['notes'] as String?,
    );
  }

  /// Convertit en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commandeId': commandeId,
      'montant': montant,
      'mode': mode.name,
      'date': date.toIso8601String(),
      'reference': reference,
      'notes': notes,
    };
  }

  /// Crée un Paiement depuis JSON
  factory Paiement.fromJson(Map<String, dynamic> json) {
    return Paiement(
      id: json['id'] as int?,
      commandeId: json['commandeId'] as int,
      montant: (json['montant'] as num).toDouble(),
      mode: ModePaiement.fromString(json['mode'] as String),
      date: DateTime.parse(json['date'] as String),
      reference: json['reference'] as String?,
      notes: json['notes'] as String?,
    );
  }

  /// Encode en String JSON
  String toJsonString() => jsonEncode(toJson());

  /// Crée depuis une String JSON
  factory Paiement.fromJsonString(String source) =>
      Paiement.fromJson(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Paiement(id: $id, montant: $montant€, mode: ${mode.libelle})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Paiement && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

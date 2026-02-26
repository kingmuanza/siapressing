import 'dart:convert';

/// Modèle représentant un client du pressing
class Client {
  final int? id;
  final String nom;
  final String? prenom;
  final String telephone;
  final String? email;
  final String? adresse;
  final DateTime dateCreation;
  final String? notes;
  final bool estEntreprise;
  final String? siret;

  Client({
    this.id,
    required this.nom,
    this.prenom,
    required this.telephone,
    this.email,
    this.adresse,
    DateTime? dateCreation,
    this.notes,
    this.estEntreprise = false,
    this.siret,
  }) : dateCreation = dateCreation ?? DateTime.now();

  /// Nom complet du client
  String get nomComplet => prenom != null ? '$prenom $nom' : nom;

  /// Crée une copie avec des valeurs modifiées
  Client copyWith({
    int? id,
    String? nom,
    String? prenom,
    String? telephone,
    String? email,
    String? adresse,
    DateTime? dateCreation,
    String? notes,
    bool? estEntreprise,
    String? siret,
  }) {
    return Client(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      telephone: telephone ?? this.telephone,
      email: email ?? this.email,
      adresse: adresse ?? this.adresse,
      dateCreation: dateCreation ?? this.dateCreation,
      notes: notes ?? this.notes,
      estEntreprise: estEntreprise ?? this.estEntreprise,
      siret: siret ?? this.siret,
    );
  }

  /// Convertit en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'adresse': adresse,
      'date_creation': dateCreation.toIso8601String(),
      'notes': notes,
      'est_entreprise': estEntreprise ? 1 : 0,
      'siret': siret,
    };
  }

  /// Crée un Client depuis un Map SQLite
  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String?,
      telephone: map['telephone'] as String,
      email: map['email'] as String?,
      adresse: map['adresse'] as String?,
      dateCreation: DateTime.parse(map['date_creation'] as String),
      notes: map['notes'] as String?,
      estEntreprise: (map['est_entreprise'] as int?) == 1,
      siret: map['siret'] as String?,
    );
  }

  /// Convertit en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'adresse': adresse,
      'dateCreation': dateCreation.toIso8601String(),
      'notes': notes,
      'estEntreprise': estEntreprise,
      'siret': siret,
    };
  }

  /// Crée un Client depuis JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String?,
      telephone: json['telephone'] as String,
      email: json['email'] as String?,
      adresse: json['adresse'] as String?,
      dateCreation: DateTime.parse(json['dateCreation'] as String),
      notes: json['notes'] as String?,
      estEntreprise: json['estEntreprise'] as bool? ?? false,
      siret: json['siret'] as String?,
    );
  }

  /// Encode en String JSON
  String toJsonString() => jsonEncode(toJson());

  /// Crée depuis une String JSON
  factory Client.fromJsonString(String source) =>
      Client.fromJson(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Client(id: $id, nom: $nomComplet, telephone: $telephone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Client && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

import 'dart:convert';

/// Type de réserve/remarque sur un article
enum TypeReserve {
  tache('Tache'),
  sansGarantie('Sans garantie'),
  lavageSpecial('Lavage spécial'),
  decoloration('Décoloration'),
  dechirure('Déchirure'),
  boutonManquant('Bouton manquant'),
  autre('Autre');

  final String libelle;
  const TypeReserve(this.libelle);

  static TypeReserve fromString(String value) {
    return TypeReserve.values.firstWhere(
      (e) => e.name == value || e.libelle == value,
      orElse: () => TypeReserve.autre,
    );
  }
}

/// Modèle représentant une ligne de commande (article dans une commande)
class LigneCommande {
  final int? id;
  final int? commandeId;
  final int articleId;
  final String articleNom;
  final int quantite;
  final double prixUnitaire;
  final List<TypeReserve> reserves;
  final String? remarques;
  final int indexTicket;

  LigneCommande({
    this.id,
    this.commandeId,
    required this.articleId,
    required this.articleNom,
    this.quantite = 1,
    required this.prixUnitaire,
    this.reserves = const [],
    this.remarques,
    this.indexTicket = 0,
  });

  /// Total de la ligne (prix × quantité)
  double get totalLigne => prixUnitaire * quantite;

  /// Indique si la ligne a des réserves
  bool get aDesReserves => reserves.isNotEmpty || (remarques?.isNotEmpty ?? false);

  /// Crée une copie avec des valeurs modifiées
  LigneCommande copyWith({
    int? id,
    int? commandeId,
    int? articleId,
    String? articleNom,
    int? quantite,
    double? prixUnitaire,
    List<TypeReserve>? reserves,
    String? remarques,
    int? indexTicket,
  }) {
    return LigneCommande(
      id: id ?? this.id,
      commandeId: commandeId ?? this.commandeId,
      articleId: articleId ?? this.articleId,
      articleNom: articleNom ?? this.articleNom,
      quantite: quantite ?? this.quantite,
      prixUnitaire: prixUnitaire ?? this.prixUnitaire,
      reserves: reserves ?? this.reserves,
      remarques: remarques ?? this.remarques,
      indexTicket: indexTicket ?? this.indexTicket,
    );
  }

  /// Convertit en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'commande_id': commandeId,
      'article_id': articleId,
      'article_nom': articleNom,
      'quantite': quantite,
      'prix_unitaire': prixUnitaire,
      'reserves': reserves.map((r) => r.name).join(','),
      'remarques': remarques,
      'index_ticket': indexTicket,
    };
  }

  /// Crée une LigneCommande depuis un Map SQLite
  factory LigneCommande.fromMap(Map<String, dynamic> map) {
    final reservesStr = map['reserves'] as String?;
    final reservesList = reservesStr?.isNotEmpty == true
        ? reservesStr!.split(',').map((r) => TypeReserve.fromString(r)).toList()
        : <TypeReserve>[];

    return LigneCommande(
      id: map['id'] as int?,
      commandeId: map['commande_id'] as int?,
      articleId: map['article_id'] as int,
      articleNom: map['article_nom'] as String,
      quantite: map['quantite'] as int,
      prixUnitaire: (map['prix_unitaire'] as num).toDouble(),
      reserves: reservesList,
      remarques: map['remarques'] as String?,
      indexTicket: map['index_ticket'] as int? ?? 0,
    );
  }

  /// Convertit en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commandeId': commandeId,
      'articleId': articleId,
      'articleNom': articleNom,
      'quantite': quantite,
      'prixUnitaire': prixUnitaire,
      'reserves': reserves.map((r) => r.name).toList(),
      'remarques': remarques,
      'indexTicket': indexTicket,
    };
  }

  /// Crée une LigneCommande depuis JSON
  factory LigneCommande.fromJson(Map<String, dynamic> json) {
    return LigneCommande(
      id: json['id'] as int?,
      commandeId: json['commandeId'] as int?,
      articleId: json['articleId'] as int,
      articleNom: json['articleNom'] as String,
      quantite: json['quantite'] as int,
      prixUnitaire: (json['prixUnitaire'] as num).toDouble(),
      reserves: (json['reserves'] as List<dynamic>?)
              ?.map((r) => TypeReserve.fromString(r as String))
              .toList() ??
          [],
      remarques: json['remarques'] as String?,
      indexTicket: json['indexTicket'] as int? ?? 0,
    );
  }

  /// Encode en String JSON
  String toJsonString() => jsonEncode(toJson());

  /// Crée depuis une String JSON
  factory LigneCommande.fromJsonString(String source) =>
      LigneCommande.fromJson(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LigneCommande(articleNom: $articleNom, qte: $quantite, total: $totalLigne€)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LigneCommande && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

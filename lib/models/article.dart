import 'dart:convert';

/// Catégories d'articles
enum CategorieArticle {
  vetements('Vêtements'),
  ameublement('Ameublement'),
  cuir('Cuir'),
  blanchisserie('Blanchisserie');

  final String libelle;
  const CategorieArticle(this.libelle);

  static CategorieArticle fromString(String value) {
    return CategorieArticle.values.firstWhere(
      (e) => e.name == value || e.libelle == value,
      orElse: () => CategorieArticle.vetements,
    );
  }
}

/// Modèle représentant un article/prestation du pressing
class Article {
  final int? id;
  final String nom;
  final CategorieArticle categorie;
  final double prixTTC;
  final String? codeInterne;
  final String? description;
  final String? imagePath;
  final bool actif;
  final bool estFavori;
  final int ordre;

  Article({
    this.id,
    required this.nom,
    required this.categorie,
    required this.prixTTC,
    this.codeInterne,
    this.description,
    this.imagePath,
    this.actif = true,
    this.estFavori = false,
    this.ordre = 0,
  });

  /// Prix HT calculé (TVA 20%)
  double get prixHT => prixTTC / 1.20;

  /// Montant TVA
  double get montantTVA => prixTTC - prixHT;

  /// Crée une copie avec des valeurs modifiées
  Article copyWith({
    int? id,
    String? nom,
    CategorieArticle? categorie,
    double? prixTTC,
    String? codeInterne,
    String? description,
    String? imagePath,
    bool? actif,
    bool? estFavori,
    int? ordre,
  }) {
    return Article(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      categorie: categorie ?? this.categorie,
      prixTTC: prixTTC ?? this.prixTTC,
      codeInterne: codeInterne ?? this.codeInterne,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      actif: actif ?? this.actif,
      estFavori: estFavori ?? this.estFavori,
      ordre: ordre ?? this.ordre,
    );
  }

  /// Convertit en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nom': nom,
      'categorie': categorie.name,
      'prix_ttc': prixTTC,
      'code_interne': codeInterne,
      'description': description,
      'image_path': imagePath,
      'actif': actif ? 1 : 0,
      'est_favori': estFavori ? 1 : 0,
      'ordre': ordre,
    };
  }

  /// Crée un Article depuis un Map SQLite
  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      categorie: CategorieArticle.fromString(map['categorie'] as String),
      prixTTC: (map['prix_ttc'] as num).toDouble(),
      codeInterne: map['code_interne'] as String?,
      description: map['description'] as String?,
      imagePath: map['image_path'] as String?,
      actif: (map['actif'] as int?) == 1,
      estFavori: (map['est_favori'] as int?) == 1,
      ordre: map['ordre'] as int? ?? 0,
    );
  }

  /// Convertit en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'categorie': categorie.name,
      'prixTTC': prixTTC,
      'codeInterne': codeInterne,
      'description': description,
      'imagePath': imagePath,
      'actif': actif,
      'estFavori': estFavori,
      'ordre': ordre,
    };
  }

  /// Crée un Article depuis JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      categorie: CategorieArticle.fromString(json['categorie'] as String),
      prixTTC: (json['prixTTC'] as num).toDouble(),
      codeInterne: json['codeInterne'] as String?,
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String?,
      actif: json['actif'] as bool? ?? true,
      estFavori: json['estFavori'] as bool? ?? false,
      ordre: json['ordre'] as int? ?? 0,
    );
  }

  /// Encode en String JSON
  String toJsonString() => jsonEncode(toJson());

  /// Crée depuis une String JSON
  factory Article.fromJsonString(String source) =>
      Article.fromJson(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Article(id: $id, nom: $nom, categorie: ${categorie.libelle}, prix: $prixTTC€)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Article && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

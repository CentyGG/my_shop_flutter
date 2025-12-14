class Recipe {
  final String id;
  final String name;
  final String? category;
  final String? area;
  final String? instructions;
  final String? imageUrl;
  final String? youtubeUrl;
  final List<String> ingredients;
  final List<String> measures;
  final String? tags;
  final String? source;

  Recipe({
    required this.id,
    required this.name,
    this.category,
    this.area,
    this.instructions,
    this.imageUrl,
    this.youtubeUrl,
    required this.ingredients,
    required this.measures,
    this.tags,
    this.source,
  });
}


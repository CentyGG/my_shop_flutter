class FoodProduct {
  final String id;
  final String name;
  final String? brand;
  final String? category;
  final String? imageUrl;
  final double? calories;
  final double? proteins;
  final double? carbohydrates;
  final double? fat;
  final List<String>? labels;
  final String? ingredientsText;

  FoodProduct({
    required this.id,
    required this.name,
    this.brand,
    this.category,
    this.imageUrl,
    this.calories,
    this.proteins,
    this.carbohydrates,
    this.fat,
    this.labels,
    this.ingredientsText,
  });
}


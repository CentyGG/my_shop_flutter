import 'package:json_annotation/json_annotation.dart';

part 'open_food_facts_dto.g.dart';

class DoubleConverter implements JsonConverter<double?, dynamic> {
  const DoubleConverter();

  @override
  double? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is double) return json;
    if (json is int) return json.toDouble();
    if (json is String) {
      return double.tryParse(json);
    }
    return null;
  }

  @override
  dynamic toJson(double? object) => object;
}

class IntConverter implements JsonConverter<int?, dynamic> {
  const IntConverter();

  @override
  int? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is String) {
      return int.tryParse(json);
    }
    return null;
  }

  @override
  dynamic toJson(int? object) => object;
}

class StringListConverter implements JsonConverter<List<String>?, dynamic> {
  const StringListConverter();

  @override
  List<String>? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is List) {
      return json.map((e) => e.toString()).toList();
    }
    if (json is String) {
      return [json];
    }
    return null;
  }

  @override
  dynamic toJson(List<String>? object) => object;
}

class ProductListConverter implements JsonConverter<List<OpenFoodFactsProductDto>?, dynamic> {
  const ProductListConverter();

  @override
  List<OpenFoodFactsProductDto>? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is List) {
      return json
          .map((e) => e is Map<String, dynamic>
              ? OpenFoodFactsProductDto.fromJson(e)
              : null)
          .whereType<OpenFoodFactsProductDto>()
          .toList();
    }
    return null;
  }

  @override
  dynamic toJson(List<OpenFoodFactsProductDto>? object) => object;
}

@JsonSerializable()
class OpenFoodFactsProductDto {
  final String? code;
  @JsonKey(name: 'product_name')
  final String? productName;
  final String? brands;
  final String? categories;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final NutrimentsDto? nutriments;
  @StringListConverter()
  final List<String>? labels;
  @JsonKey(name: 'ingredients_text')
  final String? ingredientsText;

  OpenFoodFactsProductDto({
    this.code,
    this.productName,
    this.brands,
    this.categories,
    this.imageUrl,
    this.nutriments,
    this.labels,
    this.ingredientsText,
  });

  factory OpenFoodFactsProductDto.fromJson(Map<String, dynamic> json) =>
      _$OpenFoodFactsProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OpenFoodFactsProductDtoToJson(this);
}

@JsonSerializable()
class NutrimentsDto {
  @JsonKey(name: 'energy-kcal_100g')
  @DoubleConverter()
  final double? energyKcal100g;
  @JsonKey(name: 'energy-kcal')
  @DoubleConverter()
  final double? energyKcal;
  @DoubleConverter()
  final double? proteins;
  @DoubleConverter()
  final double? carbohydrates;
  @DoubleConverter()
  final double? fat;

  NutrimentsDto({
    this.energyKcal100g,
    this.energyKcal,
    this.proteins,
    this.carbohydrates,
    this.fat,
  });

  factory NutrimentsDto.fromJson(Map<String, dynamic> json) =>
      _$NutrimentsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NutrimentsDtoToJson(this);
}

@JsonSerializable()
class OpenFoodFactsSearchResponseDto {
  @IntConverter()
  final int? count;
  @IntConverter()
  final int? page;
  @JsonKey(name: 'page_size')
  @IntConverter()
  final int? pageSize;
  @ProductListConverter()
  final List<OpenFoodFactsProductDto>? products;

  OpenFoodFactsSearchResponseDto({
    this.count,
    this.page,
    this.pageSize,
    this.products,
  });

  factory OpenFoodFactsSearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OpenFoodFactsSearchResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OpenFoodFactsSearchResponseDtoToJson(this);
}

@JsonSerializable()
class OpenFoodFactsProductResponseDto {
  final String? status;
  final String? code;
  final OpenFoodFactsProductDto? product;

  OpenFoodFactsProductResponseDto({
    this.status,
    this.code,
    this.product,
  });

  factory OpenFoodFactsProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OpenFoodFactsProductResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OpenFoodFactsProductResponseDtoToJson(this);
}


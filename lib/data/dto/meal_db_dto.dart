import 'package:json_annotation/json_annotation.dart';

part 'meal_db_dto.g.dart';

@JsonSerializable()
class MealDto {
  final String? idMeal;
  final String? strMeal;
  final String? strDrinkAlternate;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strIngredient16;
  final String? strIngredient17;
  final String? strIngredient18;
  final String? strIngredient19;
  final String? strIngredient20;
  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;
  final String? strMeasure11;
  final String? strMeasure12;
  final String? strMeasure13;
  final String? strMeasure14;
  final String? strMeasure15;
  final String? strMeasure16;
  final String? strMeasure17;
  final String? strMeasure18;
  final String? strMeasure19;
  final String? strMeasure20;
  final String? strSource;

  MealDto({
    this.idMeal,
    this.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
    this.strSource,
  });

  factory MealDto.fromJson(Map<String, dynamic> json) =>
      _$MealDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealDtoToJson(this);

  List<String> get ingredients {
    final list = <String>[];
    for (int i = 1; i <= 20; i++) {
      final ingredient = _getIngredient(i);
      if (ingredient != null && ingredient.isNotEmpty) {
        list.add(ingredient);
      }
    }
    return list;
  }

  List<String> get measures {
    final list = <String>[];
    for (int i = 1; i <= 20; i++) {
      final measure = _getMeasure(i);
      if (measure != null && measure.isNotEmpty) {
        list.add(measure);
      }
    }
    return list;
  }

  String? _getIngredient(int index) {
    switch (index) {
      case 1: return strIngredient1;
      case 2: return strIngredient2;
      case 3: return strIngredient3;
      case 4: return strIngredient4;
      case 5: return strIngredient5;
      case 6: return strIngredient6;
      case 7: return strIngredient7;
      case 8: return strIngredient8;
      case 9: return strIngredient9;
      case 10: return strIngredient10;
      case 11: return strIngredient11;
      case 12: return strIngredient12;
      case 13: return strIngredient13;
      case 14: return strIngredient14;
      case 15: return strIngredient15;
      case 16: return strIngredient16;
      case 17: return strIngredient17;
      case 18: return strIngredient18;
      case 19: return strIngredient19;
      case 20: return strIngredient20;
      default: return null;
    }
  }

  String? _getMeasure(int index) {
    switch (index) {
      case 1: return strMeasure1;
      case 2: return strMeasure2;
      case 3: return strMeasure3;
      case 4: return strMeasure4;
      case 5: return strMeasure5;
      case 6: return strMeasure6;
      case 7: return strMeasure7;
      case 8: return strMeasure8;
      case 9: return strMeasure9;
      case 10: return strMeasure10;
      case 11: return strMeasure11;
      case 12: return strMeasure12;
      case 13: return strMeasure13;
      case 14: return strMeasure14;
      case 15: return strMeasure15;
      case 16: return strMeasure16;
      case 17: return strMeasure17;
      case 18: return strMeasure18;
      case 19: return strMeasure19;
      case 20: return strMeasure20;
      default: return null;
    }
  }
}

@JsonSerializable()
class MealSearchResponseDto {
  final List<MealDto>? meals;

  MealSearchResponseDto({
    this.meals,
  });

  factory MealSearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealSearchResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealSearchResponseDtoToJson(this);
}

@JsonSerializable()
class MealRandomResponseDto {
  final List<MealDto>? meals;

  MealRandomResponseDto({
    this.meals,
  });

  factory MealRandomResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealRandomResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealRandomResponseDtoToJson(this);
}

@JsonSerializable()
class MealFilterResponseDto {
  final List<MealDto>? meals;

  MealFilterResponseDto({
    this.meals,
  });

  factory MealFilterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealFilterResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealFilterResponseDtoToJson(this);
}

@JsonSerializable()
class CategoryListResponseDto {
  final List<CategoryDto>? meals;

  CategoryListResponseDto({
    this.meals,
  });

  factory CategoryListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryListResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListResponseDtoToJson(this);
}

@JsonSerializable()
class CategoryDto {
  final String? strCategory;

  CategoryDto({
    this.strCategory,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}


// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_food_facts_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenFoodFactsProductDto _$OpenFoodFactsProductDtoFromJson(
  Map<String, dynamic> json,
) => OpenFoodFactsProductDto(
  code: json['code'] as String?,
  productName: json['product_name'] as String?,
  brands: json['brands'] as String?,
  categories: json['categories'] as String?,
  imageUrl: json['image_url'] as String?,
  nutriments: json['nutriments'] == null
      ? null
      : NutrimentsDto.fromJson(json['nutriments'] as Map<String, dynamic>),
  labels: const StringListConverter().fromJson(json['labels']),
  ingredientsText: json['ingredients_text'] as String?,
);

Map<String, dynamic> _$OpenFoodFactsProductDtoToJson(
  OpenFoodFactsProductDto instance,
) => <String, dynamic>{
  'code': instance.code,
  'product_name': instance.productName,
  'brands': instance.brands,
  'categories': instance.categories,
  'image_url': instance.imageUrl,
  'nutriments': instance.nutriments,
  'labels': const StringListConverter().toJson(instance.labels),
  'ingredients_text': instance.ingredientsText,
};

NutrimentsDto _$NutrimentsDtoFromJson(Map<String, dynamic> json) =>
    NutrimentsDto(
      energyKcal100g: const DoubleConverter().fromJson(
        json['energy-kcal_100g'],
      ),
      energyKcal: const DoubleConverter().fromJson(json['energy-kcal']),
      proteins: const DoubleConverter().fromJson(json['proteins']),
      carbohydrates: const DoubleConverter().fromJson(json['carbohydrates']),
      fat: const DoubleConverter().fromJson(json['fat']),
    );

Map<String, dynamic> _$NutrimentsDtoToJson(
  NutrimentsDto instance,
) => <String, dynamic>{
  'energy-kcal_100g': const DoubleConverter().toJson(instance.energyKcal100g),
  'energy-kcal': const DoubleConverter().toJson(instance.energyKcal),
  'proteins': const DoubleConverter().toJson(instance.proteins),
  'carbohydrates': const DoubleConverter().toJson(instance.carbohydrates),
  'fat': const DoubleConverter().toJson(instance.fat),
};

OpenFoodFactsSearchResponseDto _$OpenFoodFactsSearchResponseDtoFromJson(
  Map<String, dynamic> json,
) => OpenFoodFactsSearchResponseDto(
  count: const IntConverter().fromJson(json['count']),
  page: const IntConverter().fromJson(json['page']),
  pageSize: const IntConverter().fromJson(json['page_size']),
  products: const ProductListConverter().fromJson(json['products']),
);

Map<String, dynamic> _$OpenFoodFactsSearchResponseDtoToJson(
  OpenFoodFactsSearchResponseDto instance,
) => <String, dynamic>{
  'count': const IntConverter().toJson(instance.count),
  'page': const IntConverter().toJson(instance.page),
  'page_size': const IntConverter().toJson(instance.pageSize),
  'products': const ProductListConverter().toJson(instance.products),
};

OpenFoodFactsProductResponseDto _$OpenFoodFactsProductResponseDtoFromJson(
  Map<String, dynamic> json,
) => OpenFoodFactsProductResponseDto(
  status: json['status'] as String?,
  code: json['code'] as String?,
  product: json['product'] == null
      ? null
      : OpenFoodFactsProductDto.fromJson(
          json['product'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$OpenFoodFactsProductResponseDtoToJson(
  OpenFoodFactsProductResponseDto instance,
) => <String, dynamic>{
  'status': instance.status,
  'code': instance.code,
  'product': instance.product,
};

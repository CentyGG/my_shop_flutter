import '../../domain/models/food_product.dart';
import '../../domain/repositories/food_products_repository.dart';
import '../data_sources/open_food_facts_api_client.dart';
import '../dto/open_food_facts_dto.dart';

class FoodProductsRepositoryImpl implements FoodProductsRepository {
  final OpenFoodFactsApiClient _apiClient;

  FoodProductsRepositoryImpl(this._apiClient);

  @override
  Future<List<FoodProduct>> searchProductsByName(String query) async {
    final response = await _apiClient.searchProductsByName(query);
    return _mapProducts(response.products ?? []);
  }

  @override
  Future<FoodProduct?> getProductById(String id) async {
    try {
      final response = await _apiClient.getProductByBarcode(id);
      if (response.product != null) {
        return _mapProduct(response.product!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<FoodProduct>> getProductsList() async {
    final response = await _apiClient.getProductsList();
    return _mapProducts(response.products ?? []);
  }

  @override
  Future<List<FoodProduct>> getProductsByCategory(String category) async {
    final response = await _apiClient.getProductsByCategory(category);
    return _mapProducts(response.products ?? []);
  }

  @override
  Future<FoodProduct?> getRandomProduct() async {
    final response = await _apiClient.getRandomProduct();
    final products = response.products ?? [];
    if (products.isNotEmpty) {
      return _mapProduct(products.first);
    }
    return null;
  }

  List<FoodProduct> _mapProducts(List<OpenFoodFactsProductDto> dtos) {
    return dtos.map((dto) => _mapProduct(dto)).toList();
  }

  FoodProduct _mapProduct(OpenFoodFactsProductDto dto) {
    return FoodProduct(
      id: dto.code ?? '',
      name: dto.productName ?? 'Неизвестный продукт',
      brand: dto.brands,
      category: dto.categories?.split(',').first.trim(),
      imageUrl: dto.imageUrl,
      calories: dto.nutriments?.energyKcal100g ?? dto.nutriments?.energyKcal,
      proteins: dto.nutriments?.proteins,
      carbohydrates: dto.nutriments?.carbohydrates,
      fat: dto.nutriments?.fat,
      labels: dto.labels,
      ingredientsText: dto.ingredientsText,
    );
  }
}


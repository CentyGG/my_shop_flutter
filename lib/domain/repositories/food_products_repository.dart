import '../models/food_product.dart';

abstract class FoodProductsRepository {
  Future<List<FoodProduct>> searchProductsByName(String query);
  Future<FoodProduct?> getProductById(String id);
  Future<List<FoodProduct>> getProductsList();
  Future<List<FoodProduct>> getProductsByCategory(String category);
  Future<FoodProduct?> getRandomProduct();
}


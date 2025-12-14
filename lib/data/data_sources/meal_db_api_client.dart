import 'package:dio/dio.dart';
import '../dto/meal_db_dto.dart';

class MealDbApiClient {
  final Dio _dio;
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  MealDbApiClient(this._dio) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<MealSearchResponseDto> searchMealByName(String name) async {
    try {
      final response = await _dio.get(
        '/search.php',
        queryParameters: {'s': name},
      );
      return MealSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при поиске рецепта: $e');
    }
  }

  Future<MealRandomResponseDto> getRandomMeal() async {
    try {
      final response = await _dio.get('/random.php');
      return MealRandomResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при получении случайного рецепта: $e');
    }
  }

  Future<MealSearchResponseDto> getMealById(String id) async {
    try {
      final response = await _dio.get(
        '/lookup.php',
        queryParameters: {'i': id},
      );
      return MealSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при получении рецепта: $e');
    }
  }


  Future<MealFilterResponseDto> getSimilarMeals(String category) async {
    try {
      final response = await _dio.get(
        '/filter.php',
        queryParameters: {'c': category},
      );
      return MealFilterResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при поиске похожих рецептов: $e');
    }
  }

  // 5. Поиск рецептов по ингредиенту
  Future<MealFilterResponseDto> searchMealsByIngredient(String ingredient) async {
    try {
      final response = await _dio.get(
        '/filter.php',
        queryParameters: {'i': ingredient},
      );
      return MealFilterResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при поиске рецептов по ингредиенту: $e');
    }
  }
}


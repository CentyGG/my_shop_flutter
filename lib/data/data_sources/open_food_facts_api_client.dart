import 'package:dio/dio.dart';
import '../dto/open_food_facts_dto.dart';

class OpenFoodFactsApiClient {
  final Dio _dio;
  static const String _baseUrl = 'https://world.openfoodfacts.org';
  static const String _apiKey = 'ekljUXgRvEsnxv7MEcloFx79r2vC55b0e1ZNp0Qo';

  OpenFoodFactsApiClient(this._dio) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }
  Future<OpenFoodFactsSearchResponseDto> searchProductsByName(
    String query, {
    int pageSize = 100,
  }) async {
    try {
      final response = await _dio.get(
        '/cgi/search.pl',
        queryParameters: {
          'search_terms': query,
          'page_size': pageSize,
          'json': true,
          'action': 'process',
          'fields': 'code,product_name,brands,categories,image_url,nutriments,labels,ingredients_text',
          'user_id': _apiKey,
          'tagtype_0': 'origins',
          'tag_contains_0': 'contains',
          'tag_0': 'Russia',
        },
      );
      return OpenFoodFactsSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при поиске продуктов: $e');
    }
  }

  // 2. Получение информации о конкретном продукте
  Future<OpenFoodFactsProductResponseDto> getProductByBarcode(String barcode) async {
    try {
      final response = await _dio.get(
        '/api/v0/product/$barcode.json',
      );
      return OpenFoodFactsProductResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при получении продукта: $e');
    }
  }

  // 3. Загрузка списка продуктов (популярные/новые)
  Future<OpenFoodFactsSearchResponseDto> getProductsList({
    int pageSize = 100,
    String sortBy = 'popularity',
  }) async {
    try {

      final response = await _dio.get(
        '/cgi/search.pl',
        queryParameters: {
          'search_terms': '',
          'sort_by': sortBy,
          'page_size': pageSize,
          'json': true,
          'action': 'process',
          'fields': 'code,product_name,brands,categories,image_url,nutriments,labels,ingredients_text',
          'user_id': _apiKey,
          // Фильтр по России
          'tagtype_0': 'origins',
          'tag_contains_0': 'contains',
          'tag_0': 'Russia',
        },
      );
      return OpenFoodFactsSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при загрузке списка продуктов: $e');
    }
  }

  // 4. Поиск продуктов по категории
  Future<OpenFoodFactsSearchResponseDto> getProductsByCategory(
    String category, {
    int pageSize = 100,
  }) async {
    try {
      final categoryMap = {
        'Молочные продукты': 'dairy',
        'Хлеб и выпечка': 'bread',
        'Овощи и фрукты': 'fruits-vegetables-nuts',
        'Мясо и рыба': 'meats',
      };
      final englishCategory = categoryMap[category] ?? category.toLowerCase();
      
      final response = await _dio.get(
        '/cgi/search.pl',
        queryParameters: {
          'tagtype_0': 'categories',
          'tag_contains_0': 'contains',
          'tag_0': englishCategory,
          'page_size': pageSize,
          'json': true,
          'action': 'process',
          'fields': 'code,product_name,brands,categories,image_url,nutriments,labels,ingredients_text',
          'user_id': _apiKey,
          'tagtype_1': 'origins',
          'tag_contains_1': 'contains',
          'tag_1': 'Russia',
        },
      );
      return OpenFoodFactsSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при поиске продуктов по категории: $e');
    }
  }

  // 5. Получение случайного продукта (продукт дня)
  Future<OpenFoodFactsSearchResponseDto> getRandomProduct() async {
    try {
      final response = await _dio.get(
        '/cgi/search.pl',
        queryParameters: {
          'sort_by': 'popularity',
          'page_size': 1,
          'json': true,
          'action': 'process',
          'random': true,
          'user_id': _apiKey,
          // Фильтр по России
          'tagtype_0': 'origins',
          'tag_contains_0': 'contains',
          'tag_0': 'Russia',
        },
      );
      return OpenFoodFactsSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка при получении случайного продукта: $e');
    }
  }
}


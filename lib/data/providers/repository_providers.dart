import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_sources/local_database.dart';
import '../data_sources/open_food_facts_api_client.dart';
import '../data_sources/meal_db_api_client.dart';
import '../repositories/local_storage_repository_impl.dart';
import '../repositories/preferences_repository_impl.dart';
import '../repositories/secure_storage_repository_impl.dart';
import '../repositories/food_products_repository_impl.dart';
import '../repositories/recipes_repository_impl.dart';
import '../../domain/repositories/local_storage_repository.dart';
import '../../domain/repositories/preferences_repository.dart';
import '../../domain/repositories/secure_storage_repository.dart';
import '../../domain/repositories/food_products_repository.dart';
import '../../domain/repositories/recipes_repository.dart';


final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return LocalDatabase();
});


final localStorageRepositoryProvider = Provider<LocalStorageRepository>((ref) {
  final database = ref.watch(localDatabaseProvider);
  return LocalStorageRepositoryImpl(database);
});

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  return PreferencesRepositoryImpl();
});

final secureStorageRepositoryProvider = Provider<SecureStorageRepository>((ref) {
  return SecureStorageRepositoryImpl();
});

// Dio providers
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

// API Clients
final openFoodFactsApiClientProvider = Provider<OpenFoodFactsApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return OpenFoodFactsApiClient(dio);
});

final mealDbApiClientProvider = Provider<MealDbApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return MealDbApiClient(dio);
});

// Repositories
final foodProductsRepositoryProvider = Provider<FoodProductsRepository>((ref) {
  final apiClient = ref.watch(openFoodFactsApiClientProvider);
  return FoodProductsRepositoryImpl(apiClient);
});

final recipesRepositoryProvider = Provider<RecipesRepository>((ref) {
  final apiClient = ref.watch(mealDbApiClientProvider);
  return RecipesRepositoryImpl(apiClient);
});


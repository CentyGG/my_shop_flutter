import '../../domain/models/recipe.dart';
import '../../domain/repositories/recipes_repository.dart';
import '../data_sources/meal_db_api_client.dart';
import '../dto/meal_db_dto.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  final MealDbApiClient _apiClient;

  RecipesRepositoryImpl(this._apiClient);

  @override
  Future<List<Recipe>> searchRecipesByName(String name) async {
    final response = await _apiClient.searchMealByName(name);
    return _mapMeals(response.meals ?? []);
  }

  @override
  Future<Recipe?> getRandomRecipe() async {
    final response = await _apiClient.getRandomMeal();
    final meals = response.meals ?? [];
    if (meals.isNotEmpty) {
      return _mapMeal(meals.first);
    }
    return null;
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    try {
      final response = await _apiClient.getMealById(id);
      final meals = response.meals ?? [];
      if (meals.isNotEmpty) {
        return _mapMeal(meals.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Recipe>> getSimilarRecipes(String category) async {
    final response = await _apiClient.getSimilarMeals(category);
    return _mapMeals(response.meals ?? []);
  }

  @override
  Future<List<Recipe>> searchRecipesByIngredient(String ingredient) async {
    final response = await _apiClient.searchMealsByIngredient(ingredient);
    return _mapMeals(response.meals ?? []);
  }

  List<Recipe> _mapMeals(List<MealDto> dtos) {
    return dtos.map((dto) => _mapMeal(dto)).toList();
  }

  Recipe _mapMeal(MealDto dto) {
    return Recipe(
      id: dto.idMeal ?? '',
      name: dto.strMeal ?? 'Неизвестный рецепт',
      category: dto.strCategory,
      area: dto.strArea,
      instructions: dto.strInstructions,
      imageUrl: dto.strMealThumb,
      youtubeUrl: dto.strYoutube,
      ingredients: dto.ingredients,
      measures: dto.measures,
      tags: dto.strTags,
      source: dto.strSource,
    );
  }
}


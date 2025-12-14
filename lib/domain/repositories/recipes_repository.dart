import '../models/recipe.dart';

abstract class RecipesRepository {
  Future<List<Recipe>> searchRecipesByName(String name);
  Future<Recipe?> getRandomRecipe();
  Future<Recipe?> getRecipeById(String id);
  Future<List<Recipe>> getSimilarRecipes(String category);
  Future<List<Recipe>> searchRecipesByIngredient(String ingredient);
}


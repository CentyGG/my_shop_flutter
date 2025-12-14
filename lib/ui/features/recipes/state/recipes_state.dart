import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/recipe.dart';
import '../../../../domain/repositories/recipes_repository.dart';
import '../../../../data/providers/repository_providers.dart';

class RecipesState {
  final List<Recipe> recipes;
  final Recipe? selectedRecipe;
  final List<Recipe> similarRecipes;
  final List<Recipe> savedRecipesList;
  final bool isLoading;
  final String? error;

  RecipesState({
    this.recipes = const [],
    this.selectedRecipe,
    this.similarRecipes = const [],
    this.savedRecipesList = const [],
    this.isLoading = false,
    this.error,
  });

  RecipesState copyWith({
    List<Recipe>? recipes,
    Recipe? selectedRecipe,
    List<Recipe>? similarRecipes,
    List<Recipe>? savedRecipesList,
    bool? isLoading,
    String? error,
  }) {
    return RecipesState(
      recipes: recipes ?? this.recipes,
      selectedRecipe: selectedRecipe ?? this.selectedRecipe,
      similarRecipes: similarRecipes ?? this.similarRecipes,
      savedRecipesList: savedRecipesList ?? this.savedRecipesList,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RecipesNotifier extends StateNotifier<RecipesState> {
  final RecipesRepository _repository;

  RecipesNotifier(this._repository) : super(RecipesState());

  Future<void> searchRecipesByName(String name) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      selectedRecipe: null,
      similarRecipes: [],
      recipes: [],
    );
    try {
      final recipes = await _repository.searchRecipesByName(name);
      state = state.copyWith(
        recipes: recipes,
        savedRecipesList: recipes,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> getRandomRecipe() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final recipe = await _repository.getRandomRecipe();
      if (recipe != null) {
        state = state.copyWith(selectedRecipe: recipe, isLoading: false);
        // Загружаем похожие рецепты
        if (recipe.category != null) {
          await getSimilarRecipes(recipe.category!);
        }
      } else {
        state = state.copyWith(error: 'Не удалось получить рецепт', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> getRecipeById(String id) async {
    // Сначала ищем рецепт в уже загруженном списке
    try {
      final existingRecipe = state.recipes.firstWhere(
        (r) => r.id == id,
      );
      state = state.copyWith(selectedRecipe: existingRecipe, similarRecipes: []);
      // Загружаем похожие рецепты
      if (existingRecipe.category != null) {
        await getSimilarRecipes(existingRecipe.category!);
      }
      return;
    } catch (e) {
      // Рецепт не найден в списке, загружаем из API
    }
    
    // Если не найден в списке, загружаем из API
    state = state.copyWith(isLoading: true, error: null);
    try {
      final recipe = await _repository.getRecipeById(id);
      if (recipe != null) {
        state = state.copyWith(selectedRecipe: recipe, isLoading: false);
        // Загружаем похожие рецепты
        if (recipe.category != null) {
          await getSimilarRecipes(recipe.category!);
        }
      } else {
        state = state.copyWith(error: 'Рецепт не найден', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
  
  Future<void> selectRecipe(Recipe recipe) async {
    // ВСЕГДА сохраняем текущий список рецептов перед выбором
    // Приоритет: recipes > savedRecipesList
    final recipesToSave = state.recipes.isNotEmpty 
        ? state.recipes 
        : (state.savedRecipesList.isNotEmpty ? state.savedRecipesList : <Recipe>[]);
    
    state = state.copyWith(
      selectedRecipe: recipe,
      similarRecipes: [],
      // НЕ очищаем список recipes - он должен остаться видимым
      savedRecipesList: recipesToSave, // Сохраняем список (даже если пуст)
    );
    // Загружаем похожие рецепты
    if (recipe.category != null) {
      await getSimilarRecipes(recipe.category!);
    }
  }

  Future<void> getSimilarRecipes(String category) async {
    try {
      final recipes = await _repository.getSimilarRecipes(category);
      state = state.copyWith(similarRecipes: recipes);
    } catch (e) {
      // Не показываем ошибку для похожих рецептов
    }
  }

  Future<void> searchRecipesByIngredient(String ingredient) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      selectedRecipe: null,
      similarRecipes: [],
      recipes: [], // Очищаем предыдущие результаты
    );
    try {
      final recipes = await _repository.searchRecipesByIngredient(ingredient);
      state = state.copyWith(
        recipes: recipes,
        savedRecipesList: recipes, // Сохраняем результаты поиска
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void clearSelectedRecipe() {
    // ВСЕГДА восстанавливаем список из сохраненного
    // Приоритет: savedRecipesList > recipes
    List<Recipe> recipesToShow;
    
    if (state.savedRecipesList.isNotEmpty) {
      recipesToShow = state.savedRecipesList;
    } else if (state.recipes.isNotEmpty) {
      recipesToShow = state.recipes;
    } else {
      // Если оба списка пусты, просто очищаем выбранный рецепт
      state = RecipesState(
        recipes: [],
        selectedRecipe: null,
        similarRecipes: [],
        savedRecipesList: [],
        isLoading: false,
        error: null,
      );
      return;
    }
    
    // Восстанавливаем список и обновляем состояние
    state = RecipesState(
      recipes: recipesToShow,
      selectedRecipe: null,
      similarRecipes: [],
      savedRecipesList: recipesToShow,
      isLoading: false,
      error: null,
    );
  }
}

final recipesStateProvider =
    StateNotifierProvider<RecipesNotifier, RecipesState>((ref) {
  final repository = ref.watch(recipesRepositoryProvider);
  return RecipesNotifier(repository);
});


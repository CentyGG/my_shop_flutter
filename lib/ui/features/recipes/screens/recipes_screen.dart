  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../state/recipes_state.dart';

class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});

  @override
  ConsumerState<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends ConsumerState<RecipesScreen> {
  final _searchController = TextEditingController();
  final _ingredientController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recipesStateProvider);
    final notifier = ref.read(recipesStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепты'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Поиск по названию
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Поиск рецепта по названию',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    notifier.searchRecipesByName(_searchController.text);
                  },
                  child: const Text('Найти'),
                ),
              ],
            ),
          ),
          // Поиск по ингредиенту
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientController,
                    decoration: const InputDecoration(
                      labelText: 'Поиск по ингредиенту',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    notifier.searchRecipesByIngredient(_ingredientController.text);
                  },
                  child: const Text('Найти'),
                ),
              ],
            ),
          ),
          // Кнопка случайного рецепта
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                notifier.getRandomRecipe();
              },
              child: const Text('Случайный рецепт'),
            ),
          ),
          // Контент
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.error != null
                    ? Center(child: Text('Ошибка: ${state.error}'))
                    : _buildContent(state, notifier),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(RecipesState state, RecipesNotifier notifier) {
    if (state.selectedRecipe != null) {
      return _buildRecipeDetail(state, notifier);
    }
    if (state.recipes.isNotEmpty) {
      return _buildRecipesList(state, notifier);
    }
    return const Center(child: Text('Начните поиск рецептов'));
  }

  Widget _buildRecipesList(RecipesState state, RecipesNotifier notifier) {
    return ListView.builder(
      itemCount: state.recipes.length,
      itemBuilder: (context, index) {
        final recipe = state.recipes[index];
        return ListTile(
          leading: recipe.imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: recipe.imageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.restaurant),
          title: Text(recipe.name),
          subtitle: Text(recipe.category ?? ''),
          onTap: () async {
            await notifier.selectRecipe(recipe);
          },
        );
      },
    );
  }

  Widget _buildRecipeDetail(RecipesState state, RecipesNotifier notifier) {
    final recipe = state.selectedRecipe!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recipe.imageUrl != null)
            CachedNetworkImage(
              imageUrl: recipe.imageUrl!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 16),
          Text(
            recipe.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          if (recipe.category != null)
            Text('Категория: ${recipe.category}'),
          if (recipe.area != null) Text('Кухня: ${recipe.area}'),
          const SizedBox(height: 16),
          const Text(
            'Ингредиенты:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            recipe.ingredients.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '${recipe.ingredients[index]} - ${index < recipe.measures.length ? recipe.measures[index] : ""}',
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Инструкции:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (recipe.instructions != null)
            Text(recipe.instructions!),
          if (state.similarRecipes.isNotEmpty) ...[
            const SizedBox(height: 24),
            const Text(
              'Похожие рецепты:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...state.similarRecipes.take(2).map((similarRecipe) => ListTile(
                  leading: similarRecipe.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: similarRecipe.imageUrl!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.restaurant),
                  title: Text(similarRecipe.name),
                  onTap: () async {
                    await notifier.selectRecipe(similarRecipe);
                  },
                )),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              notifier.clearSelectedRecipe();
            },
            child: const Text('Назад к списку'),
          ),
        ],
      ),
    );
  }
}


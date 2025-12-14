import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../state/food_products_state.dart';
import '../../cart/state/cart_state.dart';
import '../../../../domain/models/product.dart';
import '../../../../domain/models/food_product.dart' as domain;

class FoodProductsScreen extends ConsumerStatefulWidget {
  const FoodProductsScreen({super.key});

  @override
  ConsumerState<FoodProductsScreen> createState() => _FoodProductsScreenState();
}

class _FoodProductsScreenState extends ConsumerState<FoodProductsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(foodProductsStateProvider);
    final notifier = ref.read(foodProductsStateProvider.notifier);
    final cartNotifier = ref.read(cartStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Продукты'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              notifier.loadProducts();
            },
          ),
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              notifier.getRandomProduct();
            },
            tooltip: 'Продукт дня',
          ),
        ],
      ),
      body: Column(
        children: [
          // Поиск по названию
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Поиск продукта по названию',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    notifier.searchProducts(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                notifier.searchProducts(value);
              },
            ),
          ),
          // Фильтры по категориям
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildCategoryChip('Молочные продукты', notifier),
                const SizedBox(width: 8),
                _buildCategoryChip('Хлеб и выпечка', notifier),
                const SizedBox(width: 8),
                _buildCategoryChip('Овощи и фрукты', notifier),
                const SizedBox(width: 8),
                _buildCategoryChip('Мясо и рыба', notifier),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Контент
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.error != null
                    ? Center(child: Text('Ошибка: ${state.error}'))
                    : state.selectedProduct != null
                        ? _buildProductDetail(state, notifier, cartNotifier)
                        : _buildProductsList(state, notifier, cartNotifier),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category, FoodProductsNotifier notifier) {
    return FilterChip(
      label: Text(category),
      onSelected: (selected) {
        if (selected) {
          notifier.getProductsByCategory(category);
        } else {
          notifier.loadProducts();
        }
      },
    );
  }

  Widget _buildProductsList(FoodProductsState state, FoodProductsNotifier notifier, CartNotifier cartNotifier) {
    if (state.products.isEmpty) {
      return const Center(child: Text('Продукты не найдены'));
    }
    return ListView.builder(
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final foodProduct = state.products[index];
        return ListTile(
          leading: foodProduct.imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: foodProduct.imageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.food_bank),
                )
              : const Icon(Icons.food_bank),
          title: Text(foodProduct.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (foodProduct.brand != null) Text('Бренд: ${foodProduct.brand}'),
              if (foodProduct.category != null) Text('Категория: ${foodProduct.category}'),
              if (foodProduct.calories != null)
                Text('Калории: ${foodProduct.calories!.toStringAsFixed(0)} ккал/100г'),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () async {
              final product = _foodProductToProduct(foodProduct);
              await cartNotifier.addProduct(product);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${foodProduct.name} добавлен в корзину'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            tooltip: 'Добавить в корзину',
          ),
          onTap: () {
            notifier.selectProduct(foodProduct);
          },
        );
      },
    );
  }

  Product _foodProductToProduct(domain.FoodProduct foodProduct) {
    // Преобразуем FoodProduct в Product для корзины
    // Используем калории как основу для цены, или устанавливаем базовую цену
    double price = 100.0; // Базовая цена
    if (foodProduct.calories != null) {
      // Цена основана на калориях (примерно 1 рубль за 10 ккал)
      price = (foodProduct.calories! / 10).clamp(50.0, 1000.0);
    }
    
    // Формируем описание из доступной информации
    String description = '';
    if (foodProduct.brand != null) {
      description += 'Бренд: ${foodProduct.brand}. ';
    }
    if (foodProduct.category != null) {
      description += 'Категория: ${foodProduct.category}. ';
    }
    if (foodProduct.calories != null) {
      description += 'Калории: ${foodProduct.calories!.toStringAsFixed(0)} ккал/100г.';
    }
    if (description.isEmpty) {
      description = 'Продукт питания';
    }
    
    return Product(
      id: foodProduct.id,
      name: foodProduct.name,
      description: description.trim(),
      price: price,
    );
  }

  Widget _buildProductDetail(FoodProductsState state, FoodProductsNotifier notifier, CartNotifier cartNotifier) {
    final product = state.selectedProduct!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.imageUrl != null)
            CachedNetworkImage(
              imageUrl: product.imageUrl!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.food_bank, size: 100),
            ),
          const SizedBox(height: 16),
          Text(
            product.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          if (product.brand != null)
            Text('Бренд: ${product.brand}'),
          if (product.category != null)
            Text('Категория: ${product.category}'),
          const SizedBox(height: 16),
          const Text(
            'Пищевая ценность (на 100г):',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (product.calories != null)
            Text('Калории: ${product.calories!.toStringAsFixed(0)} ккал'),
          if (product.proteins != null)
            Text('Белки: ${product.proteins!.toStringAsFixed(1)} г'),
          if (product.carbohydrates != null)
            Text('Углеводы: ${product.carbohydrates!.toStringAsFixed(1)} г'),
          if (product.fat != null)
            Text('Жиры: ${product.fat!.toStringAsFixed(1)} г'),
          if (product.labels != null && product.labels!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Метки:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: product.labels!
                  .map((label) => Chip(label: Text(label)))
                  .toList(),
            ),
          ],
          if (product.ingredientsText != null) ...[
            const SizedBox(height: 16),
            const Text(
              'Состав:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(product.ingredientsText!),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    notifier.clearSelectedProduct();
                  },
                  child: const Text('Назад к списку'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final cartProduct = _foodProductToProduct(product);
                    await cartNotifier.addProduct(cartProduct);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} добавлен в корзину'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('В корзину'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/food_product.dart';
import '../../../../domain/repositories/food_products_repository.dart';
import '../../../../data/providers/repository_providers.dart';

class FoodProductsState {
  final List<FoodProduct> products;
  final FoodProduct? selectedProduct;
  final List<FoodProduct> savedProductsList;
  final bool isLoading;
  final String? error;

  FoodProductsState({
    this.products = const [],
    this.selectedProduct,
    this.savedProductsList = const [],
    this.isLoading = false,
    this.error,
  });

  FoodProductsState copyWith({
    List<FoodProduct>? products,
    FoodProduct? selectedProduct,
    List<FoodProduct>? savedProductsList,
    bool? isLoading,
    String? error,
  }) {
    return FoodProductsState(
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      savedProductsList: savedProductsList ?? this.savedProductsList,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class FoodProductsNotifier extends StateNotifier<FoodProductsState> {
  final FoodProductsRepository _repository;

  FoodProductsNotifier(this._repository) : super(FoodProductsState()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, error: null, selectedProduct: null);
    try {
      final products = await _repository.getProductsList();
      state = state.copyWith(
        products: products,
        savedProductsList: products, // Сохраняем загруженный список
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      await loadProducts();
      return;
    }
    state = state.copyWith(
      isLoading: true,
      error: null,
      selectedProduct: null,
      products: [], // Очищаем предыдущие результаты
    );
    try {
      final products = await _repository.searchProductsByName(query);
      state = state.copyWith(
        products: products,
        savedProductsList: products, // Сохраняем результаты поиска
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> getProductById(String id) async {
    // Сначала ищем продукт в уже загруженном списке
    try {
      final existingProduct = state.products.firstWhere(
        (p) => p.id == id,
      );
      state = state.copyWith(selectedProduct: existingProduct);
      return;
    } catch (e) {
      // Продукт не найден в списке, загружаем из API
    }
    
    // Если не найден в списке, загружаем из API
    state = state.copyWith(isLoading: true, error: null);
    try {
      final product = await _repository.getProductById(id);
      if (product != null) {
        state = state.copyWith(selectedProduct: product, isLoading: false);
      } else {
        state = state.copyWith(error: 'Продукт не найден', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
  
  void selectProduct(FoodProduct product) {
    // ВСЕГДА сохраняем текущий список продуктов перед выбором
    // Приоритет: products > savedProductsList
    final productsToSave = state.products.isNotEmpty 
        ? state.products 
        : (state.savedProductsList.isNotEmpty ? state.savedProductsList : <FoodProduct>[]);
    
    state = state.copyWith(
      selectedProduct: product,
      // НЕ очищаем список products - он должен остаться видимым
      savedProductsList: productsToSave, // Сохраняем список (даже если пуст)
    );
  }

  Future<void> getProductsByCategory(String category) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      selectedProduct: null,
      products: [], // Очищаем предыдущие результаты
    );
    try {
      final products = await _repository.getProductsByCategory(category);
      state = state.copyWith(
        products: products,
        savedProductsList: products, // Сохраняем результаты фильтрации
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> getRandomProduct() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final product = await _repository.getRandomProduct();
      if (product != null) {
        state = state.copyWith(selectedProduct: product, isLoading: false);
      } else {
        state = state.copyWith(error: 'Не удалось получить продукт', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void clearSelectedProduct() {
    // ВСЕГДА восстанавливаем список из сохраненного
    // Приоритет: savedProductsList > products > загрузка заново
    List<FoodProduct> productsToShow;
    
    if (state.savedProductsList.isNotEmpty) {
      productsToShow = state.savedProductsList;
    } else if (state.products.isNotEmpty) {
      productsToShow = state.products;
    } else {
      // Если оба списка пусты, загружаем заново
      loadProducts();
      return;
    }
    
    // Восстанавливаем список и обновляем состояние
    state = FoodProductsState(
      products: productsToShow,
      selectedProduct: null,
      savedProductsList: productsToShow,
      isLoading: false,
      error: null,
    );
  }
}

final foodProductsStateProvider =
    StateNotifierProvider<FoodProductsNotifier, FoodProductsState>((ref) {
  final repository = ref.watch(foodProductsRepositoryProvider);
  return FoodProductsNotifier(repository);
});


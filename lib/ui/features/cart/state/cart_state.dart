import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/product.dart';
import '../../../../domain/repositories/local_storage_repository.dart';
import '../../../../data/providers/repository_providers.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
  double get totalPrice => product.price * quantity;
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  final LocalStorageRepository _localStorage;

  CartNotifier(this._localStorage) : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final cartItemsData = await _localStorage.getCartItems();
    state = cartItemsData.map((data) {
      return CartItem(
        product: data.toProduct(),
        quantity: data.quantity,
      );
    }).toList();
  }

  Future<void> _saveCart() async {
    for (final item in state) {
      await _localStorage.saveCartItem(
        CartItemData(
          productId: item.product.id,
          productName: item.product.name,
          productDescription: item.product.description,
          productPrice: item.product.price,
          quantity: item.quantity,
        ),
      );
    }
    // Удаляем элементы, которых больше нет в корзине
    final currentProductIds = state.map((item) => item.product.id).toSet();
    final allCartItems = await _localStorage.getCartItems();
    for (final item in allCartItems) {
      if (!currentProductIds.contains(item.productId)) {
        await _localStorage.deleteCartItem(item.productId);
      }
    }
  }

  Future<void> addProduct(Product product) async {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    if (existingIndex != -1) {
      final existingItem = state[existingIndex];
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            CartItem(product: existingItem.product, quantity: existingItem.quantity + 1)
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(product: product)];
    }
    await _saveCart();
  }

  Future<void> removeProduct(Product product) async {
    state = state.where((item) => item.product.id != product.id).toList();
    await _localStorage.deleteCartItem(product.id);
  }

  Future<void> clearCart() async {
    state = [];
    await _localStorage.clearCart();
  }

  int get totalItems => state.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => state.fold(0.0, (sum, item) => sum + item.totalPrice);
}

final cartStateProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final localStorage = ref.watch(localStorageRepositoryProvider);
  return CartNotifier(localStorage);
});


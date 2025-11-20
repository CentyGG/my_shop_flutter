import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/product.dart';
part 'cart_state.g.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
  double get totalPrice => product.price * quantity;
}
@Riverpod(keepAlive: true)
class CartState extends _$CartState {
  @override
  List<CartItem> build() {
    return [];
  }
  void addProduct(Product product) {
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
      state = [...state, CartItem( product: product)];
    }
  }
  void removeProduct(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }
  void clearCart() {
    state = [];
  }
  int get totalItems => state.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => state.fold(0.0, (sum, item) => sum + item.totalPrice);
}

import 'package:flutter/foundation.dart';
import '../../product_selection/models/product_model.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Cart _cart = Cart();

  List<CartItem> get items => [..._cart.items];
  double get totalPrice => _cart.totalPrice;

  void addItem(Product product, int quantity) {
    _cart.addItem(product, quantity);
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    _cart.updateQuantity(productId, newQuantity);
    notifyListeners();
  }

  void clear() {
    _cart.clear();
    notifyListeners();
  }

  // Возвращает текущую корзину как список для передачи в заказ
  List<CartItem> getCartItems() {
    return [..._cart.items];
  }
}
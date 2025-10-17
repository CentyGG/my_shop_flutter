import '../../product_selection/models/product_model.dart';
class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}
class Cart {
  final List<CartItem> items = [];
  double get totalPrice => items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);
  void addItem(Product product, int quantity) {
    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      items[index].quantity += quantity;
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }
  }
  void removeItem(String productId) {
    items.removeWhere((item) => item.product.id == productId);
  }
  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(productId);
    } else {
      final index = items.indexWhere((item) => item.product.id == productId);
      if (index >= 0) {
        items[index].quantity = newQuantity;
      }
    }
  }
  void clear() {
    items.clear();
  }
}
import '../features/models/product.dart';
class CartService {
  final List<Product> _cart = [];

  List<Product> get cart => List.unmodifiable(_cart);

  void toggleProduct(Product product) {
    if (_cart.any((Product p) => p.id == product.id)) {
      _cart.removeWhere((Product p) => p.id == product.id);
    } else {
      _cart.add(product);
    }
  }

  void addProduct(Product product) {
    _cart.add(product);
  }

  void removeProduct(Product product) {
    _cart.removeWhere((Product p) => p.id == product.id);
  }

  void clearCart() {
    _cart.clear();
  }

  double get totalPrice =>
      _cart.fold(0.0, (double sum, Product product) => sum + product.price);
}
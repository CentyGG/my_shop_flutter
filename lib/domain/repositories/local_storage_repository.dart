import '../models/order_record.dart';
import '../models/product.dart';
import '../models/profile.dart';
import '../models/review.dart';

// Интерфейс для работы с локальным хранилищем (SQLite)
abstract class LocalStorageRepository {

  Future<List<OrderRecord>> getOrders();
  Future<void> saveOrder(OrderRecord order);
  Future<void> deleteOrder(String orderId);
  Future<void> clearOrders();

  Future<List<CartItemData>> getCartItems();
  Future<void> saveCartItem(CartItemData item);
  Future<void> deleteCartItem(String productId);
  Future<void> clearCart();

  Future<Profile?> getProfile();
  Future<void> saveProfile(Profile profile);
  Future<void> clearProfile();

  Future<List<Review>> getReviews();
  Future<void> saveReview(Review review);
  Future<void> deleteReview(int index);
  Future<void> clearReviews();

  Future<List<String>> getSubscriptions();
  Future<void> saveSubscriptions(List<String> subscriptionTypes);
  Future<void> clearSubscriptions();
}

class CartItemData {
  final String productId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final int quantity;

  CartItemData({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_description': productDescription,
      'product_price': productPrice,
      'quantity': quantity,
    };
  }

  factory CartItemData.fromMap(Map<String, dynamic> map) {
    return CartItemData(
      productId: map['product_id'] as String,
      productName: map['product_name'] as String,
      productDescription: map['product_description'] as String,
      productPrice: map['product_price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  Product toProduct() {
    return Product(
      id: productId,
      name: productName,
      description: productDescription,
      price: productPrice,
    );
  }
}


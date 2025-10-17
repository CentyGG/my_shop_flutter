import 'package:flutter/foundation.dart';
import '../../cart/models/cart_model.dart';
import '../models/order_model.dart';


class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(List<CartItem> cartItems, double total) {
    final orderItems = cartItems.map((item) => OrderItem(
      product: item.product,
      quantity: item.quantity,
    )).toList();

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      items: orderItems,
      total: total,
    );

    _orders.insert(0, newOrder);
    notifyListeners();
  }
}
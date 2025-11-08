// lib/features/cart/state/cart_container.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/product.dart';
import '../screens/cart_screen.dart';
import '../screens/order_history_screen.dart';

class CartContainer extends StatefulWidget {
  final List<Product> initialCart;

  const CartContainer({super.key, required this.initialCart});

  @override
  State<CartContainer> createState() => _CartContainerState();
}
class _CartContainerState extends State<CartContainer> {
  late List<Product> _cart;
  List<OrderRecord> _orderHistory = [];
  @override
  void initState() {
    super.initState();
    _cart = List.from(widget.initialCart);
  }
  String _generateOrderId() => DateTime.now().millisecondsSinceEpoch.toString();
  void _placeOrder() {
    if (_cart.isEmpty) return;
    final total = _cart.fold(0.0, (sum, p) => sum + p.price);
    final orderId = _generateOrderId();
    setState(() {
      _orderHistory.add(OrderRecord(id: orderId, total: total));
      _cart.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заказ оформлен!')));
  }
  void _openOrderHistory() {
    context.pushNamed("order_history",extra:List.from(_orderHistory));
  }

  void _updateCart(List<Product> updatedCart) {
    setState(() {
      _cart = updatedCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CartScreen(
    );
  }
}

class OrderRecord {
  final String id;
  final double total;
  OrderRecord({required this.id, required this.total});
}
import 'package:flutter/material.dart';
import '../state/сart_container.dart';


class OrderHistoryScreen extends StatelessWidget {
  final List<OrderRecord> orders;
  final VoidCallback? onBackToCart;

  const OrderHistoryScreen({
    super.key,
    required this.orders,
    this.onBackToCart,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История заказов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>Navigator.pop(context),
        ),
      ),
      body: orders.isEmpty
          ? const Center(child: Text('Нет заказов'))
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text('Заказ №${order.id.substring(0, 6)}'),
            subtitle: Text('Сумма: ${order.total.toStringAsFixed(2)} ₽'),
          );
        },
      ),
      floatingActionButton: onBackToCart != null
          ? FloatingActionButton(
        onPressed: onBackToCart,
        child: const Icon(Icons.shopping_cart),
      )
          : null,
    );
  }
}
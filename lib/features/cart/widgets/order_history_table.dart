// lib/features/cart/widgets/order_history_table.dart
import 'package:flutter/material.dart';

import '../state/сart_container.dart';

class OrderHistoryTable extends StatelessWidget {
  final List<OrderRecord> orders;

  const OrderHistoryTable({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
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
    );
  }
}
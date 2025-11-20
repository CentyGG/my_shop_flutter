import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../state/order_state.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('История заказов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pushReplacementNamed('cart'),
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
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../widgets/order_card.dart';
import '../widgets/order_detail_modal.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
        appBar: AppBar(
            title: const Text('История заказов'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )),
      body: orderProvider.orders.isEmpty
          ? Center(child: const Text('У вас ещё нет заказов'))
          : ListView.separated(
        itemCount: orderProvider.orders.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final order = orderProvider.orders[index];
          return OrderCard(
            order: order,
            onViewDetails: () => showOrderDetailModal(context, order),
          );
        },
      ),
    );
  }
}
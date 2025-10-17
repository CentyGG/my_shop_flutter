import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../../../utils/price_formatter.dart';

void showOrderDetailModal(BuildContext context, Order order) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Детали заказа №${order.id.substring(0, 6)}'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final item in order.items)
                ListTile(
                  title: Text(item.product.name),
                  subtitle: Text(item.product.description),
                  trailing: Text('${item.quantity} x ${formatPrice(item.product.price)}'),
                ),
              const Divider(),
              ListTile(
                title: const Text('Итого:'),
                trailing: Text(
                  formatPrice(order.total),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      );
    },
  );
}
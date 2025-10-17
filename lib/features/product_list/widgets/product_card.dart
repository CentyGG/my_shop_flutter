// lib/features/product_list/widgets/product_card.dart
import 'package:flutter/material.dart';
import '../../models/product.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  final bool isInCart;
  final VoidCallback onToggle;
  const ProductCard({
    super.key,
    required this.product,
    required this.isInCart,
    required this.onToggle,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 12),
            Text('${product.price.toStringAsFixed(2)} ₽'),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isInCart ? Colors.red : null,
              ),
              onPressed: onToggle,
              child: Text(
                isInCart ? 'Убрать из корзины' : 'Добавить в корзину',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
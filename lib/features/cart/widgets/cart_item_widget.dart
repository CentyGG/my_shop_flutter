import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/quantity_selector.dart';
import '../../../utils/price_formatter.dart';

class CartItemWidget extends StatelessWidget {
  final String productId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final int quantity;

  const CartItemWidget({
    super.key,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              productDescription,
              style: const TextStyle(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatPrice(productPrice),
                  style: const TextStyle(fontSize: 16),
                ),
                QuantitySelector(
                  quantity: quantity,
                  onIncrement: () => cartProvider.updateQuantity(productId, quantity + 1),
                  onDecrement: () => cartProvider.updateQuantity(productId, quantity - 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
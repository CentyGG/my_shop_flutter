import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_widget.dart';
import '../../order_history/providers/order_provider.dart';
import '../../../utils/price_formatter.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Корзина'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )),
      body: cartProvider.items.isEmpty
          ? Center(child: const Text('Корзина пуста'))
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cartProvider.items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return CartItemWidget(
                  productId: item.product.id,
                  productName: item.product.name,
                  productDescription: item.product.description,
                  productPrice: item.product.price,
                  quantity: item.quantity,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Итого:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(formatPrice(cartProvider.totalPrice), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: cartProvider.items.isEmpty
                      ? null
                      : () {
                    final cartItems = cartProvider.getCartItems();
                    final total = cartProvider.totalPrice;
                    orderProvider.addOrder(cartItems, total);
                    cartProvider.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Заказ оформлен!')),
                    );
                  },
                  child: const Text('Оформить заказ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
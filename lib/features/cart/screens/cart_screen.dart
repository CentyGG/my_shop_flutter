// lib/features/cart/screens/cart_screen.dart
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cart;
  final VoidCallback onPlaceOrder;
  final VoidCallback onOpenOrderHistory;
  final void Function(List<Product>) onCartUpdate;

  const CartScreen({
    super.key,
    required this.cart,
    required this.onPlaceOrder,
    required this.onOpenOrderHistory,
    required this.onCartUpdate,
  });


  String _getImageUrlForProduct(String productId) {

    final imageMap = {
      '1': 'https://avatars.mds.yandex.net/i?id=f88ef89bfe8d2590feb7c153c5786e9fabc458cd-11491093-images-thumbs&n=13', // Яблоки
      '2': 'https://avatars.mds.yandex.net/get-mpic/11213128/2a0000018ea795278e66da16dad7e6e125b6/orig', // Молоко
      '3': 'https://main-cdn.sbermegamarket.ru/big2/hlr-system/-20/768/373/877/112/40/100032413807b0.jpg', // Хлеб
      '4': 'https://avatars.mds.yandex.net/i?id=a5601d1a3c824da0266981fa99c934ce_l-5235999-images-thumbs&n=13', // Курица
      '5': 'https://img.inmyroom.ru/inmyroom/thumb/1880x1200/jpg:60/uploads/food_post/teaser/ab/ab34/jpg_2000_ab340bbd-d46a-4c74-985b-94c1bca2d595.jpg?sign=673194598095949197afd266cf3f855505ca373369ccfb5e1561f305a356a678', // Шоколад
    };
    return imageMap[productId] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final map = <String, _CartItem>{};
    for (final product in cart) {
      if (map.containsKey(product.id)) {
        map[product.id]!.quantity++;
      } else {
        map[product.id] = _CartItem(product);
      }
    }
    final items = map.values.toList();
    final total = items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Корзина пуста'))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final imageUrl = _getImageUrlForProduct(item.product.id);

          return CartItemWidget(
            product: item.product,
            quantity: item.quantity,
            imageUrl: imageUrl,
            onIncrement: () {
              final updated = List<Product>.from(cart)..add(item.product);
              onCartUpdate(updated);
            },
            onDecrement: () {
              final updated = List<Product>.from(cart)..remove(item.product);
              onCartUpdate(updated);
            },
          );
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (items.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Итого:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${total.toStringAsFixed(2)} ₽', style: const TextStyle(fontSize: 18)),
                ],
              ),
            if (items.isNotEmpty) const SizedBox(height: 16),
            if (items.isNotEmpty)
              ElevatedButton(
                onPressed: onPlaceOrder,
                child: const Text('Оформить заказ'),
              ),
            if (items.isNotEmpty) const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onOpenOrderHistory,
              child: const Text('История заказов'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItem {
  final Product product;
  int quantity;

  _CartItem(this.product) : quantity = 1;
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/cart_item_widget.dart';
import '../../models/product.dart';
import '../state/cart_state.dart';
import '../state/order_state.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  String _getImageUrlForProduct(String productId) {
    final imageMap = {
      '1': 'https://avatars.mds.yandex.net/i?id=f88ef89bfe8d2590feb7c153c5786e9fabc458cd-11491093-images-thumbs&n=13',
      '2': 'https://avatars.mds.yandex.net/get-mpic/11213128/2a0000018ea795278e66da16dad7e6e125b6/orig',
      '3': 'https://main-cdn.sbermegamarket.ru/big2/hlr-system/-20/768/373/877/112/40/100032413807b0.jpg',
      '4': 'https://avatars.mds.yandex.net/i?id=a5601d1a3c824da0266981fa99c934ce_l-5235999-images-thumbs&n=13',
      '5': 'https://img.inmyroom.ru/inmyroom/thumb/1880x1200/jpg:60/uploads/food_post/teaser/ab/ab34/jpg_2000_ab340bbd-d46a-4c74-985b-94c1bca2d595.jpg',
    };
    return imageMap[productId] ?? '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartStateProvider);
    final total = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pushNamed('main'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.pushNamed('order_history'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Товаров в корзине: ${cartItems.length}, Итого: ${total.toStringAsFixed(2)} ₽',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('Корзина пуста'))
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemWidget(
                  product: item.product,
                  quantity: item.quantity,
                  imageUrl: _getImageUrlForProduct(item.product.id),
                  onIncrement: () {
                    ref.read(cartStateProvider.notifier).addProduct(item.product);
                  },
                  onDecrement: () {
                    ref.read(cartStateProvider.notifier).removeProduct(item.product);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (cartItems.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Итого:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${total.toStringAsFixed(2)} ₽'),
                ],
              ),
            const SizedBox(height: 16),
            if (cartItems.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  final order = ref.read(orderHistoryProvider.notifier).createOrderFromCart(cartItems);
                  final currentHistory = ref.read(orderHistoryProvider);
                  ref.read(orderHistoryProvider.notifier).addOrder(currentHistory, order);
                  ref.read(cartStateProvider.notifier).clearCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Заказ оформлен!')),
                  );
                },
                child: const Text('Оформить заказ'),
              ),
            const SizedBox(height: 16),
            // Кнопка "История заказов" — ВСЕГДА видна
            OutlinedButton(
              onPressed: () => context.go('/cart/order_history'),
              child: const Text('История заказов'),
            ),
          ],
        ),
      ),
    );
  }
}
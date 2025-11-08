import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../di.dart';
import '../../../services/cart_service.dart';
import '../../models/product.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    String cartText;
    if (getIt.isRegistered<CartService>()) {
      final cartService = getIt.get<CartService>();
      final cart = cartService.cart;
      final total = cart.fold(0.0, (sum, p) => sum + p.price);
      cartText = 'Товаров в корзине: ${cart.length}, Итого: ${total.toStringAsFixed(2)} ₽';
    } else {
      print('Ошибка: CartService не зарегистрирован в GetIt!');
      cartText = 'Ошибка: Корзина недоступна. Обратитесь к разработчику.';
    }

    // Группировка товаров по ID
    final map = <String, _CartItem>{};
    for (final product in getIt.isRegistered<CartService>() ? getIt.get<CartService>().cart : []) {
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
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Выводим текст с информацией о корзине (с проверкой)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              cartText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Корзина пуста'))
                : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return CartItemWidget(
                  product: item.product,
                  quantity: item.quantity,
                  imageUrl: _getImageUrlForProduct(item.product.id),
                  onIncrement: () => getIt.get<CartService>().addProduct(item.product),
                  onDecrement: () => getIt.get<CartService>().removeProduct(item.product),
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
            if (items.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Итого:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${total.toStringAsFixed(2)} ₽'),
                ],
              ),
            const SizedBox(height: 16),
            if (items.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  getIt.get<CartService>().clearCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Заказ оформлен!')),
                  );
                  context.pop();
                },
                child: const Text('Оформить заказ'),
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
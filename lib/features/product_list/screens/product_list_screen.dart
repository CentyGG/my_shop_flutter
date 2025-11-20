import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cart/state/cart_state.dart';
import '../widgets/product_card.dart';
import '../../models/product.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  List<Product> _getProducts() {
    return [
      Product(id: '1', name: 'Яблоки', description: 'Свежие красные яблоки', price: 150.0),
      Product(id: '2', name: 'Молоко', description: 'Цельное молоко 3.2%', price: 85.0),
      Product(id: '3', name: 'Хлеб', description: 'Бородинский хлеб', price: 45.0),
      Product(id: '4', name: 'Курица', description: 'Филе куриной грудки', price: 250.0),
      Product(id: '5', name: 'Шоколад', description: 'Тёмный шоколад 70%', price: 120.0),
    ];
  }

  List<String> _getImageUrls() {
    return [
      'https://avatars.mds.yandex.net/i?id=f88ef89bfe8d2590feb7c153c5786e9fabc458cd-11491093-images-thumbs&n=13',
      'https://avatars.mds.yandex.net/get-mpic/11213128/2a0000018ea795278e66da16dad7e6e125b6/orig',
      'https://main-cdn.sbermegamarket.ru/big2/hlr-system/-20/768/373/877/112/40/100032413807b0.jpg',
      'https://avatars.mds.yandex.net/i?id=a5601d1a3c824da0266981fa99c934ce_l-5235999-images-thumbs&n=13',
      'https://img.inmyroom.ru/inmyroom/thumb/1880x1200/jpg:60/uploads/food_post/teaser/ab/ab34/jpg_2000_ab340bbd-d46a-4c74-985b-94c1bca2d595.jpg?sign=673194598095949197afd266cf3f855505ca373369ccfb5e1561f305a356a678',
    ];
  }

  bool _isInCart(List<Product> cartProducts, String productId) {
    return cartProducts.any((p) => p.id == productId);
  }

  void _toggleCart(WidgetRef ref, Product product) {
    final cartItems = ref.read(cartStateProvider.notifier);
    if (_isInCart(cartItems.state.map((item) => item.product).toList(), product.id)) {
      cartItems.removeProduct(product);
    } else {
      cartItems.addProduct(product);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartStateProvider);
    final cartProducts = cartItems.map((item) => item.product).toList();

    final products = _getProducts();
    final imageUrls = _getImageUrls();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор продуктов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final product = products[index];
          final inCart = _isInCart(cartProducts, product.id);
          final imageUrl = imageUrls[index].trim(); // убираем лишние пробелы

          return ProductCard(
            product: product,
            isInCart: inCart,
            imageUrl: imageUrl,
            onToggle: () => _toggleCart(ref, product),
          );
        },
      ),
    );
  }
}
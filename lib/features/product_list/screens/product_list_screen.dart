// lib/features/product_list/screens/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../AppState.dart';
import '../../models/product.dart';
import '../widgets/product_card.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late List<Product> _cart;

  @override
  void initState() {
    super.initState();
    final appState = AppState.of(context);
    _cart = List.from(appState.cart);
  }

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
      'https://avatars.mds.yandex.net/i?id=f88ef89bfe8d2590feb7c153c5786e9fabc458cd-11491093-images-thumbs&n=13', // Яблоки
      '  https://avatars.mds.yandex.net/get-mpic/11213128/2a0000018ea795278e66da16dad7e6e125b6/orig  ', // Молоко
      'https://main-cdn.sbermegamarket.ru/big2/hlr-system/-20/768/373/877/112/40/100032413807b0.jpg  ',   // Хлеб
      'https://avatars.mds.yandex.net/i?id=a5601d1a3c824da0266981fa99c934ce_l-5235999-images-thumbs&n=13', // Курица
      '  https://img.inmyroom.ru/inmyroom/thumb/1880x1200/jpg  :60/uploads/food_post/teaser/ab/ab34/jpg_2000_ab340bbd-d46a-4c74-985b-94c1bca2d595.jpg?sign=673194598095949197afd266cf3f855505ca373369ccfb5e1561f305a356a678', // Шоколад
    ];
  }

  bool _isInCart(String productId) {
    return _cart.any((p) => p.id == productId);
  }

  void _toggleCart(Product product) {
    setState(() {
      if (_isInCart(product.id)) {
        _cart.removeWhere((p) => p.id == product.id);
      } else {
        _cart.add(product);
      }
    });

    // Обновляем состояние в AppState
    final appState = AppState.of(context);
    appState.onCartUpdate(_cart);
  }

  @override
  Widget build(BuildContext context) {
    final products = _getProducts();
    final imageUrls = _getImageUrls();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор продуктов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // При выходе также обновляем состояние в AppState
            final appState = AppState.of(context);
            appState.onCartUpdate(_cart);
            context.pop(); // Не передаем _cart, так как он уже обновлен в AppState
          },
        ),
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final product = products[index];
          final inCart = _isInCart(product.id);
          final imageUrl = imageUrls[index];

          return ProductCard(
            product: product,
            isInCart: inCart,
            imageUrl: imageUrl,
            onToggle: () => _toggleCart(product),
          );
        },
      ),
    );
  }
}
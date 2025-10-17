import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../widgets/product_card.dart';


class ProductListScreen extends StatefulWidget {
  final List<Product> cart;
  final void Function(List<Product>) onCartUpdate;

  const ProductListScreen({
    super.key,
    required this.cart,
    required this.onCartUpdate,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late List<Product> _cart;

  @override
  void initState() {
    super.initState();
    _cart = List.from(widget.cart);
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
  }

  @override
  Widget build(BuildContext context) {
    final products = _getProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор продуктов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onCartUpdate(_cart);
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final product = products[index];
          final inCart = _isInCart(product.id);
          return ProductCard(
            product: product,
            isInCart: inCart,
            onToggle: () => _toggleCart(product),
          );
        },
      ),
    );
  }
}
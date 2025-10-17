import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

import '../widgets/quantity_picker_modal.dart';

class ProductListScreen extends StatelessWidget {
  // Пример продуктов (можно заменить на API или базу данных)
  static List<Product> getProducts() {
    return [
      Product(id: '1',
          name: 'Яблоки',
          description: 'Свежие красные яблоки',
          price: 150.0),
      Product(id: '2',
          name: 'Молоко',
          description: 'Цельное молоко 3.2%',
          price: 85.0),
      Product(
          id: '3', name: 'Хлеб', description: 'Бородинский хлеб', price: 45.0),
      Product(id: '4',
          name: 'Курица',
          description: 'Филе куриной грудки',
          price: 250.0),
      Product(id: '5',
          name: 'Шоколад',
          description: 'Тёмный шоколад 70%',
          price: 120.0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final products = getProducts();
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Выбор продуктов'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onAddToCart: () {
              _showQuantitySelector(context, product, cartProvider);
            },
          );
        },
      ),
    );
  }

  void _showQuantitySelector(BuildContext context, Product product,
      CartProvider cartProvider) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return QuantityPickerModal(
          product: product,
          cartProvider: cartProvider,
        );
      },
    );
  }
}
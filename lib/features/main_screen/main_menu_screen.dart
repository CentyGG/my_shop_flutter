// lib/features/main_menu/screens/main_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  List<Product> _cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,title: const Text('Магазин продуктов')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pushNamed('products', extra: _cart).then((updatedCart) {
                    if (updatedCart is List<Product>) {
                      setState(() => _cart = updatedCart);
                    }
                    });
                  },
                child: const Text('Выбор продуктов', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed('cart', extra: _cart);
                },
                child: const Text('Корзина', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed('reviews');
                },
                child: const Text('Отзыв', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

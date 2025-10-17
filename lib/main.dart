import 'package:flutter/material.dart';

import 'features/models/product.dart';
import 'features/cart/screens/cart_screen.dart';
import 'features/product_list/screens/product_list_screen.dart';
import 'features/reviews/screens/reviews_screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин',
      theme: ThemeData(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Product> _cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Магазин продуктов')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductListScreen(
                        cart: _cart,
                        onCartUpdate: (updatedCart) => setState(() => _cart = updatedCart),
                      ),
                    ),
                  );
                },
                child: const Text('Выбор продуктов', style: TextStyle(fontSize: 18)),

              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(
                        cart: _cart,
                        onCartUpdate: (updatedCart) => setState(() => _cart = updatedCart),
                      ),
                    ),
                  );
                },
                child: const Text('Корзина', style: TextStyle(fontSize: 18)),

              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReviewScreen()),
                  );
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
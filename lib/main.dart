// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/cart/providers/cart_provider.dart';
import 'features/order_history/providers/order_provider.dart';
import 'features/product_selection/screens/product_list_screen.dart';
import 'features/cart/screens/cart_screen.dart';
import 'features/order_history/screens/order_history_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин продуктов',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeMenuScreen(),
    );
  }
}

class HomeMenuScreen extends StatelessWidget {
  const HomeMenuScreen({super.key});

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
                    MaterialPageRoute(builder: (_) =>  ProductListScreen()),
                  );
                },
                child: const Text('Выбор продуктов', style: TextStyle(fontSize: 18)),

              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  CartScreen()),
                  );
                },
                child: const Text('Корзина', style: TextStyle(fontSize: 18)),

              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  OrderHistoryScreen()),
                  );
                },
                child: const Text('История заказов', style: TextStyle(fontSize: 18)),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
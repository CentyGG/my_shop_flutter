import 'package:flutter/material.dart';
import 'AppState.dart';
import 'app_router.dart';
import 'features/models/product.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late List<Product> _cart;
  @override
  void initState() {
    super.initState();
    _cart = [];
  }
  void _updateCart(List<Product> newCart) {
    setState(() {
      _cart = newCart;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppState(
      cart: _cart,
      onCartUpdate: _updateCart,
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Магазин',
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
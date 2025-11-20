import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Магазин Продуктов',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true
      ),
      routerConfig: router,
    );
  }
}
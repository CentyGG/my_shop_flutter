
import 'package:flutter/material.dart';

import 'features/models/product.dart';

class AppState extends InheritedWidget {
  final List<Product> cart;
  final void Function(List<Product>) onCartUpdate;

  const AppState({
    super.key,
    required this.cart,
    required this.onCartUpdate,
    required super.child,
  });


  static AppState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(result != null, 'No AppState found in context');
    return result!;
  }


  @override
  bool updateShouldNotify(covariant AppState oldWidget) {

    return cart != oldWidget.cart;
  }
}
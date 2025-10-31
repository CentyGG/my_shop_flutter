// app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'features/cart/screens/order_history_screen.dart';
import 'features/product_list/screens/product_list_screen.dart';
import 'features/cart/state/сart_container.dart';
import 'features/reviews/screens/reviews_screen.dart';
import 'features/reviews/screens/add_review_screen.dart';
import 'features/models/product.dart';
import 'features/main_screen/main_menu_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'main',
      builder: (context, state) => const MainMenuScreen(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) {
        final cart = state.extra as List<Product>? ?? [];
        return ProductListScreen(
          cart: cart,
          onCartUpdate: (updatedCart) {
          },
        );
      },
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) {
        final cart = state.extra as List<Product>? ?? [];
        return CartContainer(initialCart: cart);
      },
    ),
    GoRoute(
      path: '/reviews',
      name: 'reviews',
      builder: (context, state) => const ReviewScreen(),
    ),
    GoRoute(
      path: '/add_review',
      name: 'add_review',
      builder: (context, state) => const AddReviewScreen(),
    ),
    GoRoute(
      path: '/cart/order_history',
      name: 'order_history',
      builder: (context, state) => const OrderHistoryScreen(orders: [],),
    ),
  ],
);
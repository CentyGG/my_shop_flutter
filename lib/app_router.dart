// app_router.dart
import 'package:go_router/go_router.dart';
import 'features/cart/screens/cart_screen.dart';
import 'features/cart/screens/order_history_screen.dart';
import 'features/product_list/screens/product_list_screen.dart';
import 'features/profile/screens/change_profile_data_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/reviews/screens/reviews_screen.dart';
import 'features/reviews/screens/add_review_screen.dart';
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
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartScreen(),
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
      builder: (context, state) => const OrderHistoryScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/profile/change',
      name: 'change_profile',
      builder: (context, state) => const ChangeProfileDataScreen(),
    ),
  ],
);
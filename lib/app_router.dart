// app_router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'ui/features/auth/screens/login_screen.dart';
import 'ui/features/auth/screens/register_screen.dart';
import 'ui/features/auth/state/auth_state.dart';
import 'ui/features/cart/screens/cart_screen.dart';
import 'ui/features/cart/screens/order_history_screen.dart';
import 'ui/features/product_list/screens/product_list_screen.dart';
import 'ui/features/profile/screens/change_profile_data_screen.dart';
import 'ui/features/profile/screens/profile_screen.dart';
import 'ui/features/reviews/screens/reviews_screen.dart';
import 'ui/features/reviews/screens/add_review_screen.dart';
import 'ui/features/main_screen/main_menu_screen.dart';
import 'ui/features/settings/screens/settings_screen.dart';
import 'ui/features/subscription/screens/subscription_screen.dart';
import 'ui/features/support/screens/support_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  final router = GoRouter(
    initialLocation: authState ? '/' : '/login',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authStateProvider);
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRegister = state.matchedLocation == '/register';

      // Если не авторизован и пытается попасть на защищенные маршруты
      if (!isLoggedIn && !isGoingToLogin && !isGoingToRegister) {
        return '/login';
      }

      // Если авторизован и пытается попасть на login/register
      if (isLoggedIn && (isGoingToLogin || isGoingToRegister)) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
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
        routes: [
          GoRoute(
            path: 'add_review',
            name: 'add_review',
            builder: (context, state) => const AddReviewScreen(),
          ),
        ],
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
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/subscription',
        name: 'subscription',
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: '/support',
        name: 'support',
        builder: (context, state) => const SupportScreen(),
      ),
    ],
  );

  // Обновляем роутер при изменении состояния авторизации
  ref.listen<bool>(authStateProvider, (previous, next) {
    if (previous != next) {
      router.refresh();
    }
  });

  return router;
});
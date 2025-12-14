import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/order_record.dart';
import '../../../../domain/repositories/local_storage_repository.dart';
import '../../../../data/providers/repository_providers.dart';
import 'cart_state.dart';

class OrderHistoryNotifier extends StateNotifier<List<OrderRecord>> {
  final LocalStorageRepository _localStorage;
  final Random _random = Random();

  OrderHistoryNotifier(this._localStorage) : super([]) {
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    state = await _localStorage.getOrders();
  }

  Future<void> addOrder(List<OrderRecord> currentOrders, OrderRecord newOrder) async {
    state = [newOrder, ...currentOrders];
    await _localStorage.saveOrder(newOrder);
  }

  OrderRecord createOrderFromCart(List<CartItem> cartItems) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomSuffix = _random.nextInt(999999); // 6-значное случайное число
    final id = '${timestamp}_$randomSuffix';
    
    final total = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    final items = cartItems.map((item) {
      return OrderItem(
        productId: item.product.id,
        productName: item.product.name,
        quantity: item.quantity,
        price: item.product.price,
      );
    }).toList();
    
    return OrderRecord(
      id: id,
      total: total,
      date: DateTime.now(),
      status: 'pending',
      items: items,
    );
  }
}

final orderHistoryProvider = StateNotifierProvider<OrderHistoryNotifier, List<OrderRecord>>((ref) {
  final localStorage = ref.watch(localStorageRepositoryProvider);
  return OrderHistoryNotifier(localStorage);
});


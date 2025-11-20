import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/order_record.dart';
import 'cart_state.dart';
part 'order_state.g.dart';
@Riverpod(keepAlive: true)
class OrderHistory extends _$OrderHistory {
  @override
  List<OrderRecord> build() {
    return [];
  }
  void addOrder(List<OrderRecord> currentOrders, OrderRecord newOrder) {
    state = [newOrder, ...currentOrders];
  }

  OrderRecord createOrderFromCart(List<CartItem> cartItems) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final total = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    return OrderRecord(id: id, total: total);
  }
}
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cart;
  final void Function(List<Product>) onCartUpdate;

  const CartScreen({
    super.key,
    required this.cart,
    required this.onCartUpdate,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartItem {
  final Product product;
  int quantity;

  _CartItem(this.product) : quantity = 1;
}

class _CartScreenState extends State<CartScreen> {
  late List<_CartItem> _items;

  @override
  void initState() {
    super.initState();
    final map = <String, _CartItem>{};
    for (final product in widget.cart) {
      if (map.containsKey(product.id)) {
        map[product.id]!.quantity++;
      } else {
        map[product.id] = _CartItem(product);
      }
    }
    _items = map.values.toList();
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      _items[index].quantity += delta;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
    });
  }
  List<Product> _getCartForReturn() {
    final List<Product> result = [];
    for (final item in _items) {
      for (int i = 0; i < item.quantity; i++) {
        result.add(item.product);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final total = _items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onCartUpdate(_getCartForReturn());
            Navigator.pop(context);
          },
        ),
      ),
      body: _items.isEmpty
          ? const Center(child: Text('Корзина пуста'))
          : ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return CartItemWidget(
            product: item.product,
            quantity: item.quantity,
            onIncrement: () => _updateQuantity(index, 1),
            onDecrement: () => _updateQuantity(index, -1),
          );
        },
      ),
      bottomSheet: _items.isNotEmpty
          ? Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Итого:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${total.toStringAsFixed(2)} ₽', style: const TextStyle(fontSize: 18)),
          ],
        ),
      )
          : null,
    );
  }
}
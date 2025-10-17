// lib/features/product_selection/widgets/quantity_picker_modal.dart
import 'package:flutter/material.dart';
import '../../cart/providers/cart_provider.dart';
import '../models/product_model.dart';

class QuantityPickerModal extends StatefulWidget {
  final Product product;
  final CartProvider cartProvider;

  const QuantityPickerModal({
    super.key,
    required this.product,
    required this.cartProvider,
  });

  @override
  State<QuantityPickerModal> createState() => _QuantityPickerModalState();
}

class _QuantityPickerModalState extends State<QuantityPickerModal> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = 1;
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    widget.cartProvider.addItem(widget.product, _quantity);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Выберите количество для "${widget.product.name}"',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _decrement,
                icon: const Icon(Icons.remove),
              ),
              Text(
                '$_quantity',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _increment,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _addToCart,
            child: const Text('Добавить в корзину'),
          ),
        ],
      ),
    );
  }
}
class OrderRecord {
  final String id;
  final double total;
  final DateTime date;
  final String status;
  final List<OrderItem> items;

  OrderRecord({
    required this.id,
    required this.total,
    required this.date,
    this.status = 'pending',
    this.items = const [],
  });

  OrderRecord copyWith({
    String? id,
    double? total,
    DateTime? date,
    String? status,
    List<OrderItem>? items,
  }) {
    return OrderRecord(
      id: id ?? this.id,
      total: total ?? this.total,
      date: date ?? this.date,
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });
}


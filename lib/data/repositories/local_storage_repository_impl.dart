import 'package:sqflite/sqflite.dart';
import '../../domain/models/order_record.dart';
import '../../domain/models/profile.dart';
import '../../domain/models/review.dart';
import '../../domain/repositories/local_storage_repository.dart';
import '../data_sources/local_database.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalDatabase _database;
  LocalStorageRepositoryImpl(this._database);
  @override
  Future<List<OrderRecord>> getOrders() async {
    final db = await _database.database;
    final ordersList = await db.query('orders', orderBy: 'date DESC');
    final orders = <OrderRecord>[];

    for (final orderMap in ordersList) {
      final orderId = orderMap['id'] as String;
      final itemsList = await db.query(
        'order_items',
        where: 'order_id = ?',
        whereArgs: [orderId],
      );

      final items = itemsList.map((item) {
        return OrderItem(
          productId: item['product_id'] as String,
          productName: item['product_name'] as String,
          quantity: item['quantity'] as int,
          price: item['price'] as double,
        );
      }).toList();

      orders.add(OrderRecord(
        id: orderId,
        total: orderMap['total'] as double,
        date: DateTime.fromMillisecondsSinceEpoch(orderMap['date'] as int),
        status: orderMap['status'] as String,
        items: items,
      ));
    }

    return orders;
  }

  @override
  Future<void> saveOrder(OrderRecord order) async {
    final db = await _database.database;
    await db.transaction((txn) async {
      await txn.insert('orders', {
        'id': order.id,
        'total': order.total,
        'date': order.date.millisecondsSinceEpoch,
        'status': order.status,
      });

      for (final item in order.items) {
        await txn.insert('order_items', {
          'order_id': order.id,
          'product_id': item.productId,
          'product_name': item.productName,
          'quantity': item.quantity,
          'price': item.price,
        });
      }
    });
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    final db = await _database.database;
    await db.delete('orders', where: 'id = ?', whereArgs: [orderId]);
  }

  @override
  Future<void> clearOrders() async {
    final db = await _database.database;
    await db.delete('orders');
  }

  // Корзина
  @override
  Future<List<CartItemData>> getCartItems() async {
    final db = await _database.database;
    final itemsList = await db.query('cart_items');
    return itemsList.map((map) => CartItemData.fromMap(map)).toList();
  }

  @override
  Future<void> saveCartItem(CartItemData item) async {
    final db = await _database.database;
    await db.insert(
      'cart_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteCartItem(String productId) async {
    final db = await _database.database;
    await db.delete('cart_items', where: 'product_id = ?', whereArgs: [productId]);
  }

  @override
  Future<void> clearCart() async {
    final db = await _database.database;
    await db.delete('cart_items');
  }

  // Профиль
  @override
  Future<Profile?> getProfile() async {
    final db = await _database.database;
    final profileList = await db.query('user_profile', limit: 1);
    if (profileList.isEmpty) return null;

    final profileMap = profileList.first;
    return Profile(
      firstName: profileMap['first_name'] as String,
      lastName: profileMap['last_name'] as String,
      email: profileMap['email'] as String,
    );
  }

  @override
  Future<void> saveProfile(Profile profile) async {
    final db = await _database.database;
    await db.delete('user_profile');
    await db.insert('user_profile', {
      'first_name': profile.firstName,
      'last_name': profile.lastName,
      'email': profile.email,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> clearProfile() async {
    final db = await _database.database;
    await db.delete('user_profile');
  }

  // Отзывы
  @override
  Future<List<Review>> getReviews() async {
    final db = await _database.database;
    final reviewsList = await db.query('reviews', orderBy: 'created_at DESC');
    return reviewsList.map((map) {
      return Review(
        rating: map['rating'] as int,
        text: map['text'] as String,
      );
    }).toList();
  }

  @override
  Future<void> saveReview(Review review) async {
    final db = await _database.database;
    await db.insert('reviews', {
      'rating': review.rating,
      'text': review.text,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> deleteReview(int index) async {
    final db = await _database.database;
    final reviewsList = await db.query('reviews', orderBy: 'created_at DESC');
    if (index < reviewsList.length) {
      final reviewId = reviewsList[index]['id'] as int;
      await db.delete('reviews', where: 'id = ?', whereArgs: [reviewId]);
    }
  }

  @override
  Future<void> clearReviews() async {
    final db = await _database.database;
    await db.delete('reviews');
  }

  // Подписки
  @override
  Future<List<String>> getSubscriptions() async {
    final db = await _database.database;
    final subscriptionsList = await db.query('subscriptions');
    return subscriptionsList.map((map) => map['type'] as String).toList();
  }

  @override
  Future<void> saveSubscriptions(List<String> subscriptionTypes) async {
    final db = await _database.database;
    await db.delete('subscriptions');
    final now = DateTime.now().millisecondsSinceEpoch;
    for (final type in subscriptionTypes) {
      await db.insert('subscriptions', {
        'type': type,
        'subscribed_at': now,
      });
    }
  }

  @override
  Future<void> clearSubscriptions() async {
    final db = await _database.database;
    await db.delete('subscriptions');
  }
}


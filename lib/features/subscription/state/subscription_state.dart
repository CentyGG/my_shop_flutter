import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SubscriptionType {
  breakfast('Готовые завтраки', 'Выбор готовых завтраков на каждый день'),
  dairy('Молочные продукты', 'Свежие молочные продукты'),
  vegetables('Овощи и фрукты', 'Сезонные овощи и фрукты'),
  meat('Мясо и рыба', 'Свежее мясо и рыба'),
  bakery('Хлеб и выпечка', 'Свежая выпечка каждый день'),
  mixed('Смешанная корзина', 'Разнообразный набор продуктов');

  final String title;
  final String description;
  const SubscriptionType(this.title, this.description);
}

class SubscriptionNotifier extends StateNotifier<List<SubscriptionType>> {
  SubscriptionNotifier() : super([]);

  void subscribe(SubscriptionType type) {
    if (!state.contains(type)) {
      state = [...state, type];
    }
  }

  void unsubscribe(SubscriptionType type) {
    state = state.where((t) => t != type).toList();
  }

  bool isSubscribed(SubscriptionType type) {
    return state.contains(type);
  }
}

final subscriptionStateProvider = StateNotifierProvider<SubscriptionNotifier, List<SubscriptionType>>((ref) {
  return SubscriptionNotifier();
});


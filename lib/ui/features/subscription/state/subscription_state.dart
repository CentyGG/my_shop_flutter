import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repositories/local_storage_repository.dart';
import '../../../../data/providers/repository_providers.dart';

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

  String get name => toString().split('.').last;
  static SubscriptionType? fromString(String name) {
    try {
      return SubscriptionType.values.firstWhere(
        (type) => type.name == name,
      );
    } catch (e) {
      return null;
    }
  }
}

class SubscriptionNotifier extends StateNotifier<List<SubscriptionType>> {
  final LocalStorageRepository _localStorage;

  SubscriptionNotifier(this._localStorage) : super([]) {
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    final subscriptionStrings = await _localStorage.getSubscriptions();
    state = subscriptionStrings
        .map((s) => SubscriptionType.fromString(s))
        .whereType<SubscriptionType>()
        .toList();
  }

  Future<void> _saveSubscriptions() async {
    final subscriptionStrings = state.map((type) => type.name).toList();
    await _localStorage.saveSubscriptions(subscriptionStrings);
  }

  Future<void> subscribe(SubscriptionType type) async {
    if (!state.contains(type)) {
      state = [...state, type];
      await _saveSubscriptions();
    }
  }

  Future<void> unsubscribe(SubscriptionType type) async {
    state = state.where((t) => t != type).toList();
    await _saveSubscriptions();
  }

  bool isSubscribed(SubscriptionType type) {
    return state.contains(type);
  }
}

final subscriptionStateProvider = StateNotifierProvider<SubscriptionNotifier, List<SubscriptionType>>((ref) {
  final localStorage = ref.watch(localStorageRepositoryProvider);
  return SubscriptionNotifier(localStorage);
});


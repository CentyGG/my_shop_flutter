import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../state/subscription_state.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSubscriptions = ref.watch(subscriptionStateProvider);
    final subscriptionNotifier = ref.read(subscriptionStateProvider.notifier);
    final subscriptionTypes = SubscriptionType.values;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подписка на доставку'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('main'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Выберите варианты подписки',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Каждый месяц вам будет доставляться выбранный набор продуктов. Можно выбрать несколько вариантов.',
                ),
                const SizedBox(height: 16),
                if (currentSubscriptions.isNotEmpty) ...[
                  const Text(
                    'Активные подписки:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...currentSubscriptions.map((subscription) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Text('• '),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(subscription.title),
                              Text(
                                subscription.description,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: subscriptionTypes.length,
              itemBuilder: (context, index) {
                final type = subscriptionTypes[index];
                final isSelected = subscriptionNotifier.isSubscribed(type);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isSelected) {
                        subscriptionNotifier.unsubscribe(type);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Подписка "${type.title}" отменена'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      } else {
                        subscriptionNotifier.subscribe(type);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Подписка "${type.title}" активирована'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.blue : null,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                type.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          type.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.white70 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}


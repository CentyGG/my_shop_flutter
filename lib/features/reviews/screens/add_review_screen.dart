import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_shop_flutter/features/reviews/screens/reviews_screen.dart';

import '../state/reviews_state.dart';

class AddReviewScreen extends ConsumerWidget {
  const AddReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _textController = TextEditingController();
    int? _selectedRating;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Новый отзыв'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Ваш отзыв',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Оцените магазин:'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRatingButton(1, _selectedRating, () => _selectedRating = 1),
                _buildRatingButton(2, _selectedRating, () => _selectedRating = 2),
                _buildRatingButton(3, _selectedRating, () => _selectedRating = 3),
                _buildRatingButton(4, _selectedRating, () => _selectedRating = 4),
                _buildRatingButton(5, _selectedRating, () => _selectedRating = 5),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_selectedRating == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Выберите оценку!')),
                  );
                  return;
                }

                final text = _textController.text.trim();
                if (text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Напишите отзыв или поставьте оценку!')),
                  );
                  return;
                }
                ref.read(reviewsStateProvider.notifier).addReview(_selectedRating!, text);
                _textController.clear();
                context.pushReplacementNamed("reviews");
              },
              child: const Text('Отправить отзыв'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingButton(int value, int? selected, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected == value ? Colors.blue : null,
      ),
      onPressed: onPressed,
      child: Text('$value'),
    );
  }
}
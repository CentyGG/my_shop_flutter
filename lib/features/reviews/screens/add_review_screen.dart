// lib/features/reviews/screens/add_review_screen.dart
import 'package:flutter/material.dart';
import 'package:my_shop_flutter/features/reviews/screens/reviews_screen.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  int? _selectedRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,title: const Text('Новый отзыв')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedRating == 1 ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() => _selectedRating = 1);
                  },
                  child: const Text('1'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedRating == 2 ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() => _selectedRating = 2);
                  },
                  child: const Text('2'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedRating == 3 ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() => _selectedRating = 3);
                  },
                  child: const Text('3'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedRating == 4 ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() => _selectedRating = 4);
                  },
                  child: const Text('4'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedRating == 5 ? Colors.blue : null,
                  ),
                  onPressed: () {
                    setState(() => _selectedRating = 5);
                  },
                  child: const Text('5'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ReviewScreen()),
                );
              },
              child: const Text('Отправить отзыв'),
            ),
          ],
        ),
      ),
    );
  }
}
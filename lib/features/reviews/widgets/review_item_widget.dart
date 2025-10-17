import 'package:flutter/material.dart';

class ReviewItemWidget extends StatelessWidget {
  final int rating;
  final String text;
  final VoidCallback onDelete;

  const ReviewItemWidget({
    super.key,
    required this.rating,
    required this.text,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const SizedBox(width: 4),
                Text('$rating', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(text),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onDelete,
                child: const Text('Удалить', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
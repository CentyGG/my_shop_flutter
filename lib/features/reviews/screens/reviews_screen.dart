// lib/features/reviews/screens/review_screen.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/review_item_widget.dart';
import 'add_review_screen.dart';

class Review {
  final int rating;
  final String text;
  const Review({required this.rating, required this.text});
}

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final initialReviews = [
      Review(rating: 5, text: 'Хороший сервис!'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Отзывы'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: SizedBox(
              height: 100,
              child: CachedNetworkImage(
                imageUrl: 'https://static.tildacdn.com/tild6532-3436-4763-b661-306534623030/94-945346_cutting-th.png',
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, url, progress) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AddReviewScreen()),
              );
            },
            child: const Text('Добавить отзыв'),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: initialReviews.length,
              itemBuilder: (context, index) {
                final r = initialReviews[index];
                return ReviewItemWidget(
                  rating: r.rating,
                  text: r.text,
                  onDelete: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
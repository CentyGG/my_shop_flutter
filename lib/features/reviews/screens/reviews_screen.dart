import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../state/reviews_state.dart';
import '../widgets/review_item_widget.dart';
import 'add_review_screen.dart';

class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewsStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отзывы'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
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
              context.pushReplacementNamed("add_review");
            },
            child: const Text('Добавить отзыв'),
          ),
          const Divider(),
          Expanded(
            child: reviews.isEmpty
                ? const Center(child: Text('Пока нет отзывов'))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final r = reviews[index];
                return ReviewItemWidget(
                  rating: r.rating,
                  text: r.text,
                  onDelete: () {
                    ref.read(reviewsStateProvider.notifier).deleteReview(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
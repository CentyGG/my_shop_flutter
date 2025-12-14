import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/review.dart';
import '../../../../domain/repositories/local_storage_repository.dart';
import '../../../../data/providers/repository_providers.dart';

class ReviewsNotifier extends StateNotifier<List<Review>> {
  final LocalStorageRepository _localStorage;

  ReviewsNotifier(this._localStorage) : super([]) {
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    state = await _localStorage.getReviews();
  }

  Future<void> addReview(int rating, String text) async {
    final newReview = Review(rating: rating, text: text);
    state = [...state, newReview];
    await _localStorage.saveReview(newReview);
  }

  Future<void> deleteReview(int index) async {
    if (index >= 0 && index < state.length) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i != index) state[i]
      ];
      await _localStorage.deleteReview(index);
    }
  }
}

final reviewsStateProvider = StateNotifierProvider<ReviewsNotifier, List<Review>>((ref) {
  final localStorage = ref.watch(localStorageRepositoryProvider);
  return ReviewsNotifier(localStorage);
});

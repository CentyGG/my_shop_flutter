import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/review.dart';
part 'reviews_state.g.dart';
@Riverpod(keepAlive: true)
class ReviewsState extends _$ReviewsState {
  @override
  List<Review> build() {
    return [];
  }

  void addReview(int rating, String text) {
    final newReview = Review(rating: rating, text: text);
    state = [...state, newReview];
  }

  void deleteReview(int index) {
    if (index >= 0 && index < state.length) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i != index) state[i]
      ];
    }
  }
}
import 'package:flutter/material.dart';

import '../widgets/review_item_widget.dart';

class Review {
  final int rating;
  final String text;

  Review({required this.rating, required this.text});
}

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String _reviewText = '';
  int? _selectedRating;
  final List<Review> _reviews = [];

  void _submitReview() {
    if (_selectedRating != null && _reviewText.isNotEmpty) {
      setState(() {
        _reviews.add(Review(rating: _selectedRating!, text: _reviewText));
        _reviewText = '';
        _selectedRating = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Отзыв отправлен!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заполните все поля')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отзывы'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), child: TextField(
            decoration: const InputDecoration(labelText: 'Ваш отзыв',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _reviewText = value;
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Оцените магазин:'),
          ),
          //Здесь 5 кнопок для отзывов
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedRating == 1 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = 1;
                  });
                },
                child: const Text('1'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedRating == 2 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = 2;
                  });
                },
                child: const Text('2'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedRating == 3 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = 3;
                  });
                },
                child: const Text('3'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedRating == 4 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = 4;
                  });
                },
                child: const Text('4'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedRating == 5 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = 5;
                  });
                },
                child: const Text('5'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitReview,
            child: const Text('Отправить отзыв'),
          ),
          const Divider(),
          //Здесь то, что показывается если нет отзывов
          Expanded(
            child: _reviews.isEmpty
                ? const Center(child: Text('Нет отзывов'))
                : ListView.builder(
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final r = _reviews[index];
                return ReviewItemWidget(
                  rating: r.rating,
                  text: r.text,
                  onDelete: () {
                    setState(() {
                      _reviews.removeAt(index);
                    });
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
import '../../../utils/id_generator.dart';


class Product {
  final String id;
  final String name;
  final String description;
  final double price;

  Product({
    String? id,
    required this.name,
    required this.description,
    required this.price,
  }) : id = id ?? generateRandomId();
}
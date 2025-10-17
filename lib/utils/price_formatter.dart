import 'package:intl/intl.dart';

String formatPrice(double price) {
  final formatter = NumberFormat.simpleCurrency(locale: 'ru_RU');
  return formatter.format(price);
}
import 'dart:math';

String generateRandomId() {
  return (Random().nextInt(100000) + 1).toString();
}
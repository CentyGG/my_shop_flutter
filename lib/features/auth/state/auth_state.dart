import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  void login(String email, String password) {
    // Простая проверка (в реальном приложении здесь был бы API вызов)
    if (email.isNotEmpty && password.isNotEmpty) {
      state = true;
    }
  }

  void register(String email, String password, String confirmPassword) {
    // Простая проверка (в реальном приложении здесь был бы API вызов)
    if (email.isNotEmpty && password.isNotEmpty && password == confirmPassword) {
      state = true;
    }
  }

  void logout() {
    state = false;
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});


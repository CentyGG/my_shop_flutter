import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../../domain/repositories/preferences_repository.dart';
import '../../../../domain/repositories/secure_storage_repository.dart';

class AuthNotifier extends StateNotifier<bool> {
  final SecureStorageRepository _secureStorage;
  final PreferencesRepository _preferences;

  AuthNotifier(this._secureStorage, this._preferences) : super(false) {
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    final token = await _secureStorage.getAuthToken();
    state = token != null && token.isNotEmpty;
  }

  Future<void> login(String email, String password) async {
    // Простая проверка (в реальном приложении здесь был бы API вызов)
    if (email.isNotEmpty && password.isNotEmpty) {
      // Сохраняем токен (в реальном приложении получаем с сервера)
      final fakeToken = 'fake_auth_token_${DateTime.now().millisecondsSinceEpoch}';
      await _secureStorage.setAuthToken(fakeToken);

      // Сохраняем email для автозаполнения
      await _preferences.setEmail(email);

      state = true;
    }
  }

  Future<void> register(String email, String password, String confirmPassword) async {
    // Простая проверка (в реальном приложении здесь был бы API вызов)
    if (email.isNotEmpty && password.isNotEmpty && password == confirmPassword) {
      // Сохраняем токен (в реальном приложении получаем с сервера)
      final fakeToken = 'fake_auth_token_${DateTime.now().millisecondsSinceEpoch}';
      await _secureStorage.setAuthToken(fakeToken);

      // Сохраняем email для автозаполнения
      await _preferences.setEmail(email);

      state = true;
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearAuthToken();
    state = false;
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final secureStorage = ref.watch(secureStorageRepositoryProvider);
  final preferences = ref.watch(preferencesRepositoryProvider);
  return AuthNotifier(secureStorage, preferences);
});


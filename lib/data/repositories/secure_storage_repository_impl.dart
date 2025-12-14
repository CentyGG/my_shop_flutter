import 'dart:developer' as developer;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/secure_storage_repository.dart';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  static const String _keyAuthToken = 'auth_token';
  static const String _logTag = 'SecureStorage';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  @override
  Future<String?> getAuthToken() async {
    try {
      final token = await _storage.read(key: _keyAuthToken);
      developer.log(
        token != null 
          ? 'Токен получен'
          : 'Токен не найден',
        name: _logTag,
      );
      return token;
    } catch (e) {
      developer.log('Ошибка при получении токена: $e', name: _logTag, error: e);
      rethrow;
    }
  }

  @override
  Future<void> setAuthToken(String token) async {
    try {
      await _storage.write(key: _keyAuthToken, value: token);
      developer.log('Токен сохранен', name: _logTag);
    } catch (e) {
      developer.log('Ошибка при сохранении токена: $e', name: _logTag, error: e);
      rethrow;
    }
  }

  @override
  Future<void> clearAuthToken() async {
    try {
      await _storage.delete(key: _keyAuthToken);
      developer.log('Токен удален', name: _logTag);
    } catch (e) {
      developer.log('Ошибка при удалении токена: $e', name: _logTag, error: e);
      rethrow;
    }
  }
}


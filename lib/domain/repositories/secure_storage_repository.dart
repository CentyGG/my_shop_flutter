abstract class SecureStorageRepository {
  Future<String?> getAuthToken();
  Future<void> setAuthToken(String token);
  Future<void> clearAuthToken();
}


abstract class PreferencesRepository {
  Future<bool> getDarkTheme();
  Future<void> setDarkTheme(bool value);

  Future<bool> getNotificationsEnabled();
  Future<void> setNotificationsEnabled(bool value);

  Future<String?> getEmail();
  Future<void> setEmail(String email);
  Future<void> clearEmail();
}


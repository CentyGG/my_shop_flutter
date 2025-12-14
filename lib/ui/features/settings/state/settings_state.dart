import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../../domain/repositories/preferences_repository.dart';
part 'settings_state.g.dart';

@Riverpod(keepAlive: true)
class SettingsState extends _$SettingsState {
  @override
  SettingsModel build() {
    // Загружаем настройки асинхронно после инициализации
    Future.microtask(() => _loadSettings());
    return SettingsModel(
      isDarkTheme: false,
      isNotificationsEnabled: true,
    );
  }

  Future<void> _loadSettings() async {
    final preferences = ref.read(preferencesRepositoryProvider);
    final isDarkTheme = await preferences.getDarkTheme();
    final isNotificationsEnabled = await preferences.getNotificationsEnabled();
    
    state = SettingsModel(
      isDarkTheme: isDarkTheme,
      isNotificationsEnabled: isNotificationsEnabled,
    );
  }

  Future<void> toggleTheme() async {
    final preferences = ref.read(preferencesRepositoryProvider);
    final newValue = !state.isDarkTheme;
    await preferences.setDarkTheme(newValue);
    state = state.copyWith(isDarkTheme: newValue);
  }

  Future<void> toggleNotifications() async {
    final preferences = ref.read(preferencesRepositoryProvider);
    final newValue = !state.isNotificationsEnabled;
    await preferences.setNotificationsEnabled(newValue);
    state = state.copyWith(isNotificationsEnabled: newValue);
  }
}

class SettingsModel {
  final bool isDarkTheme;
  final bool isNotificationsEnabled;

  const SettingsModel({
    required this.isDarkTheme,
    required this.isNotificationsEnabled,
  });

  SettingsModel copyWith({
    bool? isDarkTheme,
    bool? isNotificationsEnabled,
  }) {
    return SettingsModel(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
    );
  }
}


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'settings_state.g.dart';
@Riverpod(keepAlive: true)
class SettingsState extends _$SettingsState {
  @override
  SettingsModel build() {
    return SettingsModel(
      isDarkTheme: false,
      isRememberPassword: false,
      isNotificationsEnabled: true,
    );
  }

  void toggleTheme() {
    state = state.copyWith(isDarkTheme: !state.isDarkTheme);
  }

  void toggleRememberPassword() {
    state = state.copyWith(isRememberPassword: !state.isRememberPassword);
  }

  void toggleNotifications() {
    state = state.copyWith(isNotificationsEnabled: !state.isNotificationsEnabled);
  }
}

class SettingsModel {
  final bool isDarkTheme;
  final bool isRememberPassword;
  final bool isNotificationsEnabled;

  const SettingsModel({
    required this.isDarkTheme,
    required this.isRememberPassword,
    required this.isNotificationsEnabled,
  });

  SettingsModel copyWith({
    bool? isDarkTheme,
    bool? isRememberPassword,
    bool? isNotificationsEnabled,
  }) {
    return SettingsModel(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isRememberPassword: isRememberPassword ?? this.isRememberPassword,
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
    );
  }
}
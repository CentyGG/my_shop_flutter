// lib/features/settings/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../state/settings_state.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            SizedBox(
              height: 120,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Windows_Settings_app_icon.png',
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, progress) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.isDarkTheme ? Colors.grey[800] : Colors.grey[300],
              ),
              onPressed: () => ref.read(settingsStateProvider.notifier).toggleTheme(),
              child: Text(
                settings.isDarkTheme ? 'Тёмная тема' : 'Светлая тема',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.isRememberPassword ? Colors.blue : Colors.grey,
              ),
              onPressed: () => ref.read(settingsStateProvider.notifier).toggleRememberPassword(),
              child: Text(
                settings.isRememberPassword ? 'Запоминать пароль' : 'Не запоминать пароль',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.isNotificationsEnabled ? Colors.green : Colors.red,
              ),
              onPressed: () => ref.read(settingsStateProvider.notifier).toggleNotifications(),
              child: Text(
                settings.isNotificationsEnabled ? 'Уведомления включены' : 'Уведомления отключены',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
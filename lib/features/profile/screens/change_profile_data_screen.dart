import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../state/profile_state.dart';

class ChangeProfileDataScreen extends ConsumerWidget {
  const ChangeProfileDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileStateProvider);
    final _firstNameController = TextEditingController(text: profile.firstName);
    final _lastNameController = TextEditingController(text: profile.lastName);
    final _emailController = TextEditingController(text: profile.email);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить данные'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Фамилия'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Почта'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {

                ref.read(profileStateProvider.notifier).updateProfile(
                  _firstNameController.text.trim(),
                  _lastNameController.text.trim(),
                  _emailController.text.trim(),
                );

                context.pop();
              },
              child: const Text('Сохранить изменения'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../state/profile_state.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileStateProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('main'),
        ),
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            SizedBox(
              height: 150,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: 'https://avatars.mds.yandex.net/get-yapic/33202/mgJTbnBlSFhZSIO1009iDxmc-1/orig',
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, progress) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Имя
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text('Имя:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(profile.firstName.isEmpty ? 'Не указано' : profile.firstName),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Фамилия
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text('Фамилия:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(profile.lastName.isEmpty ? 'Не указана' : profile.lastName),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Почта
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text('Почта:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(profile.email.isEmpty ? 'Не указана' : profile.email),
                ],
              ),
            ),

            const SizedBox(height: 40),


            ElevatedButton(
              onPressed: () => context.pushNamed('change_profile'),
              child: const Text('Изменить данные'),
            ),
          ],
        ),
      ),
    );
  }
}
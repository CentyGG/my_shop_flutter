import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/profile.dart';
import '../../../../domain/repositories/local_storage_repository.dart';
import '../../../../data/providers/repository_providers.dart';

class ProfileNotifier extends StateNotifier<Profile> {
  final LocalStorageRepository _localStorage;

  ProfileNotifier(this._localStorage) : super(const Profile(
    firstName: '',
    lastName: '',
    email: '',
  )) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await _localStorage.getProfile();
    if (profile != null) {
      state = profile;
    }
  }

  Future<void> updateProfile(String firstName, String lastName, String email) async {
    final newProfile = Profile(
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
    state = newProfile;
    await _localStorage.saveProfile(newProfile);
  }

  Future<void> setInitialProfile(Profile profile) async {
    state = profile;
    await _localStorage.saveProfile(profile);
  }
}

final profileStateProvider = StateNotifierProvider<ProfileNotifier, Profile>((ref) {
  final localStorage = ref.watch(localStorageRepositoryProvider);
  return ProfileNotifier(localStorage);
});

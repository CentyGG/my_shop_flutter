import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/profile.dart';
part 'profile_state.g.dart';

@Riverpod(keepAlive: true)
class ProfileState extends _$ProfileState {
  @override
  Profile build() {
    return Profile(
      firstName: '',
      lastName: '',
      email: '',
    );
  }
  void updateProfile(String firstName, String lastName, String email) {
    state = Profile(
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
  }

  void setInitialProfile(Profile profile) {
    state = profile;
  }
}
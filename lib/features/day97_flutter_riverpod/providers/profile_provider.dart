import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_profile_model.dart';

class ProfileNotifier extends Notifier<UserProfile> {
  @override
  UserProfile build() => UserProfile(
    name: 'Guest User',
    email: 'guest@example.com',
    isOnline: false,
  );

  void updateName(String newName) => state = state.copyWith(name: newName);
  void updateEmail(String newEmail) => state = state.copyWith(email: newEmail);
  void toggleStatus() => state = state.copyWith(isOnline: !state.isOnline);
}

final profileProvider = NotifierProvider<ProfileNotifier, UserProfile>(
  ProfileNotifier.new,
);

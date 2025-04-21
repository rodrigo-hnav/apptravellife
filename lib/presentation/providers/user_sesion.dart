import 'package:apptravellife/data/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Un objeto de tipo UserModel (custom)
final userSessionProvider =
    StateNotifierProvider<UserSessionNotifier, UserModel?>(
      (ref) => UserSessionNotifier(),
    );

class UserSessionNotifier extends StateNotifier<UserModel?> {
  // STATE = Estado = null
  UserSessionNotifier() : super(null);

  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apptravellife/data/services/user_service.dart';
import 'package:apptravellife/presentation/providers/user_sesion.dart';
import 'dart:developer';

Future<void> fetchAndSetUserSession(String email, WidgetRef ref) async {
  final user = await UserService.getUserByEmail(email);
  if (user != null) {
    ref.read(userSessionProvider.notifier).setUser(user);
    log('[USER SESSION] Usuario cargado: id=${user.id}, email=${user.email}, name=${user.name}');
  } else {
    ref.read(userSessionProvider.notifier).clearUser();
    log('[USER SESSION] No se encontró usuario con email $email');
  }
}

import 'package:apptravellife/config/router/app_router.dart';
import 'package:apptravellife/config/theme/app_theme.dart';
import 'package:apptravellife/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:apptravellife/firebase_options.dart';
import 'package:apptravellife/data/services/bootstrap_user_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isDarkmode = ref.watch(isDarkmodeProvider);
    // final selectedColor = ref.watch(selectedColorProvider);
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    // Inicializa la sesión de usuario demo al iniciar la app
    fetchAndSetUserSession('johndoe@email.com', ref);

    return MaterialApp.router(
      title: 'Flutter Widgets',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Fuerza el dark mode globalmente
    );
  }
}

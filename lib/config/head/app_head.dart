import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apptravellife/presentation/providers/theme_provider.dart';

class AppHead extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String avatarUrl;
  final String userName;
  final VoidCallback? onNotification;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final List<Widget>? actions;

  const AppHead({
    super.key,
    required this.title,
    required this.avatarUrl,
    required this.userName,
    this.onNotification,
    this.backgroundColor,
    this.foregroundColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkmode = ref.watch(isDarkmodeProvider);
    return AppBar(
      backgroundColor:
          backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color:
              foregroundColor ?? Theme.of(context).appBarTheme.foregroundColor,
        ),
      ),
      actions:
          actions ??
          [
            IconButton(
              icon: Icon(
                isDarkmode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color:
                    foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                ref.read(isDarkmodeProvider.notifier).update((state) => !state);
              },
              tooltip: isDarkmode ? 'Dark mode' : 'Light mode',
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              color: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
              onPressed: onNotification,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    userName,
                    style: TextStyle(
                      color:
                          foregroundColor ??
                          Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

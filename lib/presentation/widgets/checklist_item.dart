import 'package:flutter/material.dart';

class ChecklistItem extends StatelessWidget {
  final String text;
  const ChecklistItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

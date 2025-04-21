import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarButton extends ConsumerWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool collapsed;
  const SidebarButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.collapsed = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = isActive ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).textTheme.bodySmall?.color;
    final bgGradient = isActive
        ? LinearGradient(colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary])
        : null;
    final bgColor = isActive ? null : Colors.transparent;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: bgGradient,
        color: bgColor,
      ),
      child: ListTile(
        leading: FaIcon(icon, color: textColor),
        title: collapsed ? null : Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.transparent,
        hoverColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        contentPadding: collapsed ? const EdgeInsets.symmetric(horizontal: 8, vertical: 0) : null,
        minLeadingWidth: 0,
      ),
    );
  }
}

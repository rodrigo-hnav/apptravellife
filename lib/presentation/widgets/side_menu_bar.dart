import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:apptravellife/config/menu/menu_items.dart';
import 'package:apptravellife/presentation/providers/side_menu_provider.dart';
import 'package:apptravellife/presentation/widgets/sidebar_button.dart';
import 'dart:developer';

class SideMenuBar extends ConsumerWidget {
  const SideMenuBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collapsed = ref.watch(isSideMenuCollapsedProvider);
    final selectedIndex = ref.watch(selectedMenuItemProvider);
    void toggleCollapse() {
      ref.read(isSideMenuCollapsedProvider.notifier).state = !collapsed;
    }

    void onItemTap(int index) {
      ref.read(selectedMenuItemProvider.notifier).state = index;
      // Mostrar por consola el índice seleccionado usando log
      log('Índice seleccionado en SideMenuBar: index = $index', name: 'side_menu_bar');
      // Navegar a la ruta correspondiente
      final route = appMenuItems[index].link;
      if (route.isNotEmpty) {
        // Usar GoRouter para navegar
        GoRouter.of(context).go(route);
      }
    }

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        width: collapsed ? 77 : 250,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FaIcon(
                  FontAwesomeIcons.planeDeparture,
                  color: Theme.of(context).colorScheme.primary,
                  size: collapsed ? 28 : 22,
                ),
                if (!collapsed) ...[
                  const SizedBox(width: 10),
                  Text(
                    'TravelLife',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(100),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 30),
            ...List.generate(appMenuItems.length, (index) {
              final item = appMenuItems[index];
              return SidebarButton(
                icon: item.icon,
                label: item.title,
                isActive: selectedIndex == index,
                onTap: () => onItemTap(index),
                collapsed: collapsed,
              );
            }),
            if (collapsed) ...[
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
                  onPressed: toggleCollapse,
                  tooltip: 'Expandir menú',
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),
            ] else ...[
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[400]),
                  onPressed: toggleCollapse,
                  tooltip: 'Contraer menú',
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

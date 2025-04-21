import 'package:flutter/material.dart';
import 'package:apptravellife/presentation/widgets/side_menu_bar.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;
  const DashboardLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideMenuBar(),
          Container(width: 1, color: Colors.grey.withAlpha(25)),
          Expanded(child: child),
        ],
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

final isSideMenuCollapsedProvider = StateProvider<bool>((ref) => true);
final selectedMenuItemProvider = StateProvider<int>((ref) => 0);

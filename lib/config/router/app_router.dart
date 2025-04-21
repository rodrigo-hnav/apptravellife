// ignore: depend_on_referenced_packages
import 'package:apptravellife/presentation/screens/account/account_screen.dart';
import 'package:apptravellife/presentation/screens/calendar/calendar_screen.dart';
import 'package:apptravellife/presentation/screens/support/support_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:apptravellife/presentation/screens/screens.dart';
import 'package:apptravellife/presentation/widgets/dashboard_layout.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => DashboardLayout(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: HomeScreen.name,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/trips',
          name: TripsScreen.name,
          builder: (context, state) => const TripsScreen(),
        ),
        GoRoute(
          path: '/calendar',
          name: CalendarScreen.name,
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/account',
          name: AccountScreen.name,
          builder: (context, state) => const AccountScreen(),
        ),
        GoRoute(
          path: '/support',
          name: SupportScreen.name,
          builder: (context, state) => const SupportScreen(),
        ),
        GoRoute(
          path: '/counter-river',
          name: CounterScreen.name,
          builder: (context, state) => const CounterScreen(),
        ),
        GoRoute(
          path: '/theme-changer',
          name: ThemeChangerScreen.name,
          builder: (context, state) => const ThemeChangerScreen(),
        ),
      ],
    ),
  ],
);

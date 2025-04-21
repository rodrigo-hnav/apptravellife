import 'package:apptravellife/config/head/app_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import added
import 'package:apptravellife/presentation/widgets/trip_card.dart';
import 'package:apptravellife/presentation/widgets/activity_item.dart';
import 'package:apptravellife/presentation/widgets/quick_link_button.dart';
import 'package:apptravellife/presentation/widgets/checklist_item.dart';
import 'package:apptravellife/data/services/trip_service.dart';
import 'package:apptravellife/data/models/trip.dart';
import 'package:apptravellife/presentation/providers/user_sesion.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final user = ref.watch(userSessionProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return FutureBuilder<List<TripModel>>(
      future: TripService.getUpcomingTripsForUser(user.id),
      builder: (context, snapshot) {
        final upcomingTrips = snapshot.data ?? [];
        return Scaffold(
          key: scaffoldKey,
          appBar: AppHead(
            title: 'Dashboard',
            avatarUrl: user.avatarUrl.isNotEmpty
                ? user.avatarUrl
                : 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-2.jpg',
            userName: user.name ?? 'User',
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Debug info: mostrar el id del usuario
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'DEBUG: user.id = \'${user.id}\'',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 12),
                // Upcoming Trips (2 Cards en Row)
                Row(
                  children:
                      upcomingTrips.isNotEmpty
                          ? upcomingTrips
                              .map(
                                (trip) => Expanded(
                                  child: TripCard(
                                    title: trip.destination,
                                    dateRange:
                                        '${trip.startDate.toDate().toString().split(' ')[0]} - ${trip.endDate.toDate().toString().split(' ')[0]}',
                                    statusText: trip.status,
                                    statusColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              )
                              .toList()
                          : [
                            Expanded(
                              child: TripCard(
                                title: 'No Upcoming Trips',
                                dateRange: '',
                                statusText: '',
                                statusColor: Colors.grey,
                              ),
                            ),
                          ],
                ),
                const SizedBox(height: 16),

                // Siguiente fila -> Recent Activity (col-span 2) y Quick Links
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recent Activity
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recent Activity',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            ActivityItem(
                              icon: FontAwesomeIcons.suitcase,
                              title: 'Packing list updated',
                              subtitle: 'Spain Trip',
                            ),
                            ActivityItem(
                              icon: FontAwesomeIcons.plane,
                              title: 'Flight booked',
                              subtitle: 'New York Trip',
                            ),
                            ActivityItem(
                              icon: FontAwesomeIcons.map,
                              title: 'New trip created',
                              subtitle: 'Spain Trip',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Quick Links
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Links',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Flexible(
                                  child: QuickLinkButton(
                                    icon: FontAwesomeIcons.route,
                                    label: 'Itinerary',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: QuickLinkButton(
                                    icon: FontAwesomeIcons.wallet,
                                    label: 'Budget',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Flexible(
                                  child: QuickLinkButton(
                                    icon: FontAwesomeIcons.listCheck,
                                    label: 'Checklist',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: QuickLinkButton(
                                    icon: FontAwesomeIcons.cloud,
                                    label: 'Weather',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Última fila -> Checklist y Budget
                Row(
                  children: [
                    // Checklist
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Checklist: Spain',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ChecklistItem('Pack Luggage'),
                            ChecklistItem('Book Tours'),
                            ChecklistItem('Confirm Hotels'),
                            ChecklistItem('Travel Insurance'),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.plus,
                                color: Theme.of(context).colorScheme.primary,
                                size: 16,
                              ),
                              label: Text(
                                'Add Item',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Budget
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Budget: Bali',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Planned Budget',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.color,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$3,500',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Actual Spent',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.color,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$2,800',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(
                                            0xFF4ADE80,
                                          ), // verde neón igual que Upcoming
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Barra de progreso
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).dividerColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 75, // 3/4
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          bottomLeft: Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 25,
                                    child: Container(), // espacio vacío
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

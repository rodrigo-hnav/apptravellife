import 'package:apptravellife/data/models/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:apptravellife/config/head/app_head.dart';
import 'package:apptravellife/presentation/widgets/trip_summary_card.dart';
import 'package:apptravellife/presentation/widgets/create_trip_card.dart';
import 'package:apptravellife/presentation/widgets/itinerary_item.dart';
import 'package:apptravellife/presentation/widgets/detail_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apptravellife/presentation/providers/user_sesion.dart';
import 'package:apptravellife/data/models/trip.dart';
import 'package:apptravellife/data/services/trip_service.dart';

class TripsScreen extends ConsumerWidget {
  const TripsScreen({super.key});
  static const String name = 'trips_screen';

  // Consulta a Firestore: si hay un usuario válido en el provider, busca el trip activo y retorna ambos modelos
  Future<Map<String, dynamic>?> fetchUserAndActiveTrip(WidgetRef ref) async {
    final user = ref.read(userSessionProvider);
    if (user == null) return null;
    final activeTrip = await TripService.getActiveTripForUser(user.id);
    return {'user': user, 'activeTrip': activeTrip};
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchUserAndActiveTrip(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final user = snapshot.data?['user'] as UserModel?;
          final activeTrip = snapshot.data?['activeTrip'] as TripModel?;
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppHead(
              title: 'Trips',
              avatarUrl: user?.avatarUrl ?? 'https://example.com/avatar.jpg',
              userName: user?.name ?? 'User',
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trip cards
                  Row(
                    children: [
                      Expanded(
                        child:
                            activeTrip != null
                                ? TripSummaryCard(
                                  title: activeTrip.destination,
                                  date:
                                      '${activeTrip.startDate.toDate().toString().split(' ')[0]} - ${activeTrip.endDate.toDate().toString().split(' ')[0]}',
                                  status: activeTrip.status,
                                  statusColor: const Color(0xFF39FF14),
                                  statusBg: const Color(
                                    0xFF39FF14,
                                  ).withAlpha(51),
                                )
                                : const SizedBox.shrink(),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TripSummaryCard(
                          title: 'Paris',
                          date: 'June 1-8, 2025',
                          status: 'Planning',
                          statusColor: const Color(0xFFFF8A00),
                          statusBg: const Color(0xFFFF8A00).withAlpha(51),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: const CreateTripCard()),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Itinerary
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0x1AFFFFFF)),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Itinerary',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ...List.generate(5, (i) => ItineraryItem(day: i + 1)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Details grid
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: const [
                      DetailCard(
                        icon: FontAwesomeIcons.ticket,
                        title: 'Bookings',
                        button: 'View Bookings',
                      ),
                      DetailCard(
                        icon: FontAwesomeIcons.listCheck,
                        title: 'Checklist',
                        button: 'View Checklist',
                      ),
                      DetailCard(
                        icon: FontAwesomeIcons.file,
                        title: 'Documents',
                        button: 'View Documents',
                      ),
                      DetailCard(
                        icon: FontAwesomeIcons.wallet,
                        title: 'Budget',
                        button: 'View Budget',
                      ),
                      DetailCard(
                        icon: FontAwesomeIcons.cloudSun,
                        title: 'Weather',
                        button: 'View Weather',
                      ),
                      DetailCard(
                        icon: FontAwesomeIcons.mapLocationDot,
                        title: 'Local Guide',
                        button: 'View Guide',
                      ),
                      DetailCard(
                        icon: FontAwesomeIcons.images,
                        title: 'Photos',
                        button: 'View Photos',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

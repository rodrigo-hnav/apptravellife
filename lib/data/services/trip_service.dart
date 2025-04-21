import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apptravellife/data/models/trip.dart';
import 'dart:developer';

class TripService {
  static Future<void> createTrip({
    required String userId,
    required String destination,
    required Timestamp startDate,
    required Timestamp endDate,
    required String status,
  }) async {
    await FirebaseFirestore.instance.collection('trips').add({
      'user_id': userId,
      'destination': destination,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
      'created_at': Timestamp.now(),
    });
  }

  static Future<TripModel?> getActiveTripForUser(String userId) async {
    final tripsSnapshot =
        await FirebaseFirestore.instance
            .collection('trips')
            .where('user_id', isEqualTo: userId)
            .where('status', isEqualTo: 'Active')
            .limit(1)
            .get();
    if (tripsSnapshot.docs.isNotEmpty) {
      final tripDoc = tripsSnapshot.docs.first;
      final activeTrip = TripModel.fromMap(tripDoc.id, tripDoc.data());
      log(
        '[TRIPS] Resultado búsqueda trip activo: id=${activeTrip.id}, destino=${activeTrip.destination}, fechas=${activeTrip.startDate.toDate()} - ${activeTrip.endDate.toDate()}, status=${activeTrip.status}',
      );
      return activeTrip;
    } else {
      log('[TRIPS] No se encontró trip activo para el usuario $userId');
      return null;
    }
  }

  static Future<List<TripModel>> getUpcomingTripsForUser(String userId) async {
    log('[DEBUG] Buscando trips para user_id=$userId');
    final tripsSnapshot =
        await FirebaseFirestore.instance
            .collection('trips')
            .where('user_id', isEqualTo: userId)
            .where('status', isEqualTo: 'Upcoming')
            //.orderBy('start_date')
            .get();
    log('[DEBUG] Firestore docs encontrados: ${tripsSnapshot.docs.length}');
    for (var doc in tripsSnapshot.docs) {
      log('[DEBUG] doc.id=${doc.id}, data=${doc.data()}');
    }
    return tripsSnapshot.docs
        .map((doc) => TripModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}

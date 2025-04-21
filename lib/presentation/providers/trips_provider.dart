// Active trip
import 'package:apptravellife/data/models/trip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeTripProvider =
    StateNotifierProvider<ActiveTripNotifier, TripModel?>(
      (ref) => ActiveTripNotifier(),
    );

class ActiveTripNotifier extends StateNotifier<TripModel?> {
  ActiveTripNotifier() : super(null);

  void setActiveTrip(TripModel trip) {
    state = trip;
  }

  void clearActiveTrip() {
    state = null;
  }
}

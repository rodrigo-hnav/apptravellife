import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String? id;
  final String tripId;
  final String bookingType;
  final String provider;
  final String details;
  final Timestamp bookingDate;
  final Timestamp? createdAt;

  Booking({
    this.id,
    required this.tripId,
    required this.bookingType,
    required this.provider,
    required this.details,
    required this.bookingDate,
    this.createdAt,
  });

  factory Booking.fromMap(String? id, Map<String, dynamic> map) => Booking(
        id: id,
        tripId: map['trip_id'] ?? '',
        bookingType: map['booking_type'] ?? '',
        provider: map['provider'] ?? '',
        details: map['details'] ?? '',
        bookingDate: map['booking_date'],
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'trip_id': tripId,
        'booking_type': bookingType,
        'provider': provider,
        'details': details,
        'booking_date': bookingDate,
        'created_at': createdAt,
      };
}

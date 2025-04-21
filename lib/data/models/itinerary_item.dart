import 'package:cloud_firestore/cloud_firestore.dart';

class ItineraryItem {
  final String? id;
  final String tripId;
  final int dayNumber;
  final String title;
  final String description;
  final Timestamp? createdAt;

  ItineraryItem({
    this.id,
    required this.tripId,
    required this.dayNumber,
    required this.title,
    required this.description,
    this.createdAt,
  });

  factory ItineraryItem.fromMap(String? id, Map<String, dynamic> map) => ItineraryItem(
        id: id,
        tripId: map['trip_id'] ?? '',
        dayNumber: map['day_number'] ?? 0,
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'trip_id': tripId,
        'day_number': dayNumber,
        'title': title,
        'description': description,
        'created_at': createdAt,
      };
}

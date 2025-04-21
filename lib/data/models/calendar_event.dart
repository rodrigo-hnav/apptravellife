import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarEvent {
  final String? id;
  final String userId;
  final String? tripId;
  final String title;
  final Timestamp startDate;
  final Timestamp endDate;
  final String color;
  final String source;
  final Timestamp? createdAt;

  CalendarEvent({
    this.id,
    required this.userId,
    this.tripId,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.color,
    required this.source,
    this.createdAt,
  });

  factory CalendarEvent.fromMap(String? id, Map<String, dynamic> map) => CalendarEvent(
        id: id,
        userId: map['user_id'] ?? '',
        tripId: map['trip_id'],
        title: map['title'] ?? '',
        startDate: map['start_date'],
        endDate: map['end_date'],
        color: map['color'] ?? '',
        source: map['source'] ?? '',
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'trip_id': tripId,
        'title': title,
        'start_date': startDate,
        'end_date': endDate,
        'color': color,
        'source': source,
        'created_at': createdAt,
      };
}

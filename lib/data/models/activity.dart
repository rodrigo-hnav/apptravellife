import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String? id;
  final String userId;
  final String tripId;
  final String title;
  final String type;
  final Timestamp? createdAt;

  Activity({
    this.id,
    required this.userId,
    required this.tripId,
    required this.title,
    required this.type,
    this.createdAt,
  });

  factory Activity.fromMap(String? id, Map<String, dynamic> map) => Activity(
        id: id,
        userId: map['user_id'] ?? '',
        tripId: map['trip_id'] ?? '',
        title: map['title'] ?? '',
        type: map['type'] ?? '',
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'trip_id': tripId,
        'title': title,
        'type': type,
        'created_at': createdAt,
      };
}

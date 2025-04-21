import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;
  final String userId;
  final String destination;
  final Timestamp startDate;
  final Timestamp endDate;
  final String status;
  final Timestamp? createdAt;

  TripModel({
    required this.id,
    required this.userId,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.createdAt,
  });

  factory TripModel.fromMap(String id, Map<String, dynamic> map) => TripModel(
    id: id,
    userId: map['user_id'] ?? '',
    destination: map['destination'] ?? '',
    startDate: map['start_date'],
    endDate: map['end_date'],
    status: map['status'] ?? '',
    createdAt: map['created_at'],
  );

  Map<String, dynamic> toMap() => {
    'user_id': userId,
    'destination': destination,
    'start_date': startDate,
    'end_date': endDate,
    'status': status,
    'created_at': createdAt,
  };
}

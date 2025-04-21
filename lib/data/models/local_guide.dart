import 'package:cloud_firestore/cloud_firestore.dart';

class LocalGuide {
  final String? id;
  final String tripId;
  final String name;
  final String contactInfo;
  final String recommendation;
  final Timestamp? createdAt;

  LocalGuide({
    this.id,
    required this.tripId,
    required this.name,
    required this.contactInfo,
    required this.recommendation,
    this.createdAt,
  });

  factory LocalGuide.fromMap(String? id, Map<String, dynamic> map) => LocalGuide(
        id: id,
        tripId: map['trip_id'] ?? '',
        name: map['name'] ?? '',
        contactInfo: map['contact_info'] ?? '',
        recommendation: map['recommendation'] ?? '',
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'trip_id': tripId,
        'name': name,
        'contact_info': contactInfo,
        'recommendation': recommendation,
        'created_at': createdAt,
      };
}

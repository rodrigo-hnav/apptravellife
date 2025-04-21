import 'package:cloud_firestore/cloud_firestore.dart';

class TravelDocument {
  final String? id;
  final String tripId;
  final String name;
  final String fileUrl;
  final Timestamp? uploadedAt;

  TravelDocument({
    this.id,
    required this.tripId,
    required this.name,
    required this.fileUrl,
    this.uploadedAt,
  });

  factory TravelDocument.fromMap(String? id, Map<String, dynamic> map) => TravelDocument(
        id: id,
        tripId: map['trip_id'] ?? '',
        name: map['name'] ?? '',
        fileUrl: map['file_url'] ?? '',
        uploadedAt: map['uploaded_at'],
      );

  Map<String, dynamic> toMap() => {
        'trip_id': tripId,
        'name': name,
        'file_url': fileUrl,
        'uploaded_at': uploadedAt,
      };
}

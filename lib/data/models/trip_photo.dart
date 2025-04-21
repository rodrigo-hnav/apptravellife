import 'package:cloud_firestore/cloud_firestore.dart';

class TripPhoto {
  final String? id;
  final String tripId;
  final String photoUrl;
  final String caption;
  final Timestamp? uploadedAt;

  TripPhoto({
    this.id,
    required this.tripId,
    required this.photoUrl,
    required this.caption,
    this.uploadedAt,
  });

  factory TripPhoto.fromMap(String? id, Map<String, dynamic> map) => TripPhoto(
        id: id,
        tripId: map['trip_id'] ?? '',
        photoUrl: map['photo_url'] ?? '',
        caption: map['caption'] ?? '',
        uploadedAt: map['uploaded_at'],
      );

  Map<String, dynamic> toMap() => {
        'trip_id': tripId,
        'photo_url': photoUrl,
        'caption': caption,
        'uploaded_at': uploadedAt,
      };
}

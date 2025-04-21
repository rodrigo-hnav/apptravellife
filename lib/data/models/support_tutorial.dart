import 'package:cloud_firestore/cloud_firestore.dart';

class SupportTutorial {
  final String? id;
  final String title;
  final String description;
  final String videoUrl;
  final bool isActive;
  final Timestamp? createdAt;

  SupportTutorial({
    this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.isActive,
    this.createdAt,
  });

  factory SupportTutorial.fromMap(String? id, Map<String, dynamic> map) => SupportTutorial(
        id: id,
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        videoUrl: map['video_url'] ?? '',
        isActive: map['is_active'] ?? false,
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'video_url': videoUrl,
        'is_active': isActive,
        'created_at': createdAt,
      };
}

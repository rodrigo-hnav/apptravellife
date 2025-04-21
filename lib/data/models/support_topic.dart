import 'package:cloud_firestore/cloud_firestore.dart';

class SupportTopic {
  final String? id;
  final String title;
  final String description;
  final String icon;
  final Timestamp? createdAt;

  SupportTopic({
    this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.createdAt,
  });

  factory SupportTopic.fromMap(String? id, Map<String, dynamic> map) => SupportTopic(
        id: id,
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        icon: map['icon'] ?? '',
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'icon': icon,
        'created_at': createdAt,
      };
}

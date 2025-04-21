import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String userId;
  final String avatarUrl;
  final String fullName;
  final Timestamp? createdAt;

  UserProfile({
    required this.userId,
    required this.avatarUrl,
    required this.fullName,
    this.createdAt,
  });

  factory UserProfile.fromMap(String userId, Map<String, dynamic> map) => UserProfile(
        userId: userId,
        avatarUrl: map['avatar_url'] ?? '',
        fullName: map['full_name'] ?? '',
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'avatar_url': avatarUrl,
        'full_name': fullName,
        'created_at': createdAt,
      };
}

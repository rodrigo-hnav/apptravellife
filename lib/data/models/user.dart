import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String passwordHash;
  final String avatarUrl;
  final Timestamp? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.avatarUrl,
    this.createdAt,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> map) => UserModel(
        id: id,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        passwordHash: map['password_hash'] ?? '',
        avatarUrl: map['avatar_url'] ?? '',
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'password_hash': passwordHash,
        'avatar_url': avatarUrl,
        'created_at': createdAt,
      };
}

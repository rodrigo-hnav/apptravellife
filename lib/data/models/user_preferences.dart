import 'package:cloud_firestore/cloud_firestore.dart';

class UserPreferences {
  final String userId;
  final bool receiveNotifications;
  final String defaultCurrency;
  final String dateFormat;
  final Timestamp? updatedAt;

  UserPreferences({
    required this.userId,
    required this.receiveNotifications,
    required this.defaultCurrency,
    required this.dateFormat,
    this.updatedAt,
  });

  factory UserPreferences.fromMap(String userId, Map<String, dynamic> map) => UserPreferences(
        userId: userId,
        receiveNotifications: map['receive_notifications'] ?? false,
        defaultCurrency: map['default_currency'] ?? '',
        dateFormat: map['date_format'] ?? '',
        updatedAt: map['updated_at'],
      );

  Map<String, dynamic> toMap() => {
        'receive_notifications': receiveNotifications,
        'default_currency': defaultCurrency,
        'date_format': dateFormat,
        'updated_at': updatedAt,
      };
}

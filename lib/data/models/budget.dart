import 'package:cloud_firestore/cloud_firestore.dart';

class Budget {
  final String? id;
  final String tripId;
  final double plannedAmount;
  final double actualAmount;
  final String currency;
  final Timestamp? createdAt;

  Budget({
    this.id,
    required this.tripId,
    required this.plannedAmount,
    required this.actualAmount,
    required this.currency,
    this.createdAt,
  });

  factory Budget.fromMap(String? id, Map<String, dynamic> map) => Budget(
        id: id,
        tripId: map['trip_id'] ?? '',
        plannedAmount: (map['planned_amount'] ?? 0).toDouble(),
        actualAmount: (map['actual_amount'] ?? 0).toDouble(),
        currency: map['currency'] ?? '',
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'trip_id': tripId,
        'planned_amount': plannedAmount,
        'actual_amount': actualAmount,
        'currency': currency,
        'created_at': createdAt,
      };
}

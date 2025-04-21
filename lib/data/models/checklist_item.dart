import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistItem {
  final String? id;
  final String tripId;
  final String item;
  final bool isCompleted;
  final Timestamp? createdAt;

  ChecklistItem({
    this.id,
    required this.tripId,
    required this.item,
    required this.isCompleted,
    this.createdAt,
  });

  factory ChecklistItem.fromMap(String? id, Map<String, dynamic> map) => ChecklistItem(
        id: id,
        tripId: map['trip_id'] ?? '',
        item: map['item'] ?? '',
        isCompleted: map['is_completed'] ?? false,
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'trip_id': tripId,
        'item': item,
        'is_completed': isCompleted,
        'created_at': createdAt,
      };
}

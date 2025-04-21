import 'package:cloud_firestore/cloud_firestore.dart';

class SupportFaq {
  final String? id;
  final String question;
  final String answer;
  final String category;
  final bool isActive;
  final Timestamp? createdAt;

  SupportFaq({
    this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.isActive,
    this.createdAt,
  });

  factory SupportFaq.fromMap(String? id, Map<String, dynamic> map) => SupportFaq(
        id: id,
        question: map['question'] ?? '',
        answer: map['answer'] ?? '',
        category: map['category'] ?? '',
        isActive: map['is_active'] ?? false,
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'question': question,
        'answer': answer,
        'category': category,
        'is_active': isActive,
        'created_at': createdAt,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';

class WeatherSnapshot {
  final String? id;
  final String tripId;
  final Timestamp snapshotDate;
  final String location;
  final String weatherSummary;
  final double temperature;
  final Timestamp? createdAt;

  WeatherSnapshot({
    this.id,
    required this.tripId,
    required this.snapshotDate,
    required this.location,
    required this.weatherSummary,
    required this.temperature,
    this.createdAt,
  });

  factory WeatherSnapshot.fromMap(String? id, Map<String, dynamic> map) => WeatherSnapshot(
        id: id,
        tripId: map['trip_id'] ?? '',
        snapshotDate: map['snapshot_date'],
        location: map['location'] ?? '',
        weatherSummary: map['weather_summary'] ?? '',
        temperature: (map['temperature'] ?? 0).toDouble(),
        createdAt: map['created_at'],
      );

  Map<String, dynamic> toMap() => {
        'trip_id': tripId,
        'snapshot_date': snapshotDate,
        'location': location,
        'weather_summary': weatherSummary,
        'temperature': temperature,
        'created_at': createdAt,
      };
}

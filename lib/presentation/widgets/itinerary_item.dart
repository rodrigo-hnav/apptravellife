import 'package:flutter/material.dart';

class ItineraryItem extends StatelessWidget {
  final int day;
  const ItineraryItem({super.key, required this.day});
  @override
  Widget build(BuildContext context) {
    final itinerary = [
      {'title': 'Departure', 'desc': 'Flight LHR to CDG'},
      {'title': 'Arrival', 'desc': 'Hotel Check-in'},
      {'title': 'City Tour', 'desc': 'Guided Tour'},
      {'title': 'Museum Visit', 'desc': 'Louvre Museum'},
      {'title': 'Wine Tasting', 'desc': 'Local Vineyard'},
    ];
    final item = itinerary[day - 1];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF232323),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            alignment: Alignment.center,
            child: Text(
              'Day $day',
              style: const TextStyle(
                color: Color(0xFFFF2D95),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  item['desc']!,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

/// Ejecuta todas las queries para poblar Firestore y retorna un log detallado
Future<List<String>> seedAllWithLogs() async {
  final db = FirebaseFirestore.instance;
  final List<String> logs = [];

  // 1️⃣ Users
  final users = [
    {
      'id': '1',
      'data': {
        'name': 'John Doe',
        'email': 'johndoe@email.com',
        'password_hash': 'hashed_password_here',
        'avatar_url': 'https://example.com/avatar.jpg',
        'created_at': FieldValue.serverTimestamp(),
      },
    },
  ];
  for (var u in users) {
    await db.collection('users').doc(u['id'] as String).set(u['data'] as Map<String, dynamic>);
    logs.add('users/${u['id']}: OK');
  }

  // 2️⃣ User Profiles (subcolección bajo users/{userId})
  final userProfiles = [
    {
      'userId': '1',
      'data': {
        'avatar_url': 'https://example.com/avatar.jpg',
        'full_name': 'John Doe',
        'created_at': FieldValue.serverTimestamp(),
      },
    },
  ];
  for (var p in userProfiles) {
    await db.collection('users').doc(p['userId'] as String).collection('profiles').doc('profile').set(p['data'] as Map<String, dynamic>);
    logs.add('users/${p['userId']}/profiles/profile: OK');
  }

  // 3️⃣ User Preferences (subcolección bajo users/{userId})
  final userPreferences = [
    {
      'userId': '1',
      'data': {
        'receive_notifications': true,
        'default_currency': 'USD',
        'date_format': 'MM/DD/YYYY',
        'updated_at': FieldValue.serverTimestamp(),
      },
    },
  ];
  for (var p in userPreferences) {
    await db.collection('users').doc(p['userId'] as String).collection('preferences').doc('prefs').set(p['data'] as Map<String, dynamic>);
    logs.add('users/${p['userId']}/preferences/prefs: OK');
  }

  // 4️⃣ Trips
  final trips = [
    {
      'id': '1',
      'data': {
        'user_id': '1',
        'destination': 'New York City',
        'start_date': Timestamp.fromDate(DateTime(2025, 3, 15)),
        'end_date': Timestamp.fromDate(DateTime(2025, 3, 22)),
        'status': 'Upcoming',
        'created_at': FieldValue.serverTimestamp(),
      },
    },
    {
      'id': '2',
      'data': {
        'user_id': '1',
        'destination': 'Spain',
        'start_date': Timestamp.fromDate(DateTime(2025, 4, 5)),
        'end_date': Timestamp.fromDate(DateTime(2025, 4, 15)),
        'status': 'Planning',
        'created_at': FieldValue.serverTimestamp(),
      },
    },
    {
      'id': '3',
      'data': {
        'user_id': '1',
        'destination': 'London',
        'start_date': Timestamp.fromDate(DateTime(2025, 5, 10)),
        'end_date': Timestamp.fromDate(DateTime(2025, 5, 17)),
        'status': 'Active',
        'created_at': FieldValue.serverTimestamp(),
      },
    },
    {
      'id': '4',
      'data': {
        'user_id': '1',
        'destination': 'Paris',
        'start_date': Timestamp.fromDate(DateTime(2025, 6, 1)),
        'end_date': Timestamp.fromDate(DateTime(2025, 6, 8)),
        'status': 'Planning',
        'created_at': FieldValue.serverTimestamp(),
      },
    },
    {
      'id': '5',
      'data': {
        'user_id': '1',
        'destination': 'Bali',
        'start_date': Timestamp.fromDate(DateTime(2025, 7, 1)),
        'end_date': Timestamp.fromDate(DateTime(2025, 7, 10)),
        'status': 'Planning',
        'created_at': FieldValue.serverTimestamp(),
      },
    },
  ];
  for (var t in trips) {
    await db.collection('trips').doc(t['id'] as String).set(t['data'] as Map<String, dynamic>);
    logs.add('trips/${t['id']}: OK');
  }

  // 5️⃣ Itinerary Items
  final itineraryItems = [
    {'trip_id': '4', 'day_number': 1, 'title': 'Departure', 'description': 'Flight LH to CDG'},
    {'trip_id': '4', 'day_number': 2, 'title': 'Arrival', 'description': 'Hotel Check‐in'},
    {'trip_id': '4', 'day_number': 3, 'title': 'City Tour', 'description': 'Guided Tour'},
    {'trip_id': '4', 'day_number': 4, 'title': 'Museum Visit', 'description': 'Louvre Museum'},
    {'trip_id': '4', 'day_number': 5, 'title': 'Wine Tasting', 'description': 'Local Vineyard'},
  ];
  for (var i = 0; i < itineraryItems.length; i++) {
    final doc = await db.collection('itinerary_items').add({
      ...itineraryItems[i],
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('itinerary_items/${doc.id}: OK');
  }

  // 6️⃣ Checklist Items
  final checklistItems = [
    {'trip_id': '2', 'item': 'Pack Luggage'},
    {'trip_id': '2', 'item': 'Book Tours'},
    {'trip_id': '2', 'item': 'Confirm Hotels'},
    {'trip_id': '2', 'item': 'Request'},
    {'trip_id': '2', 'item': 'Travel Insurance'},
  ];
  for (var i = 0; i < checklistItems.length; i++) {
    final doc = await db.collection('checklist_items').add({
      ...checklistItems[i],
      'is_completed': false,
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('checklist_items/${doc.id}: OK');
  }

  // 7️⃣ Budgets
  final budgets = [
    {'trip_id': '5', 'planned_amount': 3500.00, 'actual_amount': 2800.00, 'currency': 'USD'},
  ];
  for (var i = 0; i < budgets.length; i++) {
    final doc = await db.collection('budgets').add({
      ...budgets[i],
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('budgets/${doc.id}: OK');
  }

  // 8️⃣ Activities
  final activities = [
    {'user_id': '1', 'trip_id': '2', 'title': 'Packing list updated', 'type': 'Packing'},
    {'user_id': '1', 'trip_id': '1', 'title': 'Flight booked', 'type': 'Booking'},
    {'user_id': '1', 'trip_id': '2', 'title': 'New trip created', 'type': 'Creation'},
  ];
  for (var i = 0; i < activities.length; i++) {
    final doc = await db.collection('activities').add({
      ...activities[i],
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('activities/${doc.id}: OK');
  }

  // 9️⃣ Bookings
  final bookings = [
    {'trip_id': '1', 'booking_type': 'Flight', 'provider': 'Delta Airlines', 'details': 'Flight to NYC', 'booking_date': DateTime(2025, 3, 15)},
    {'trip_id': '2', 'booking_type': 'Hotel', 'provider': 'Madrid Central', 'details': 'Hotel booked in Madrid', 'booking_date': DateTime(2025, 4, 5)},
  ];
  for (var i = 0; i < bookings.length; i++) {
    final doc = await db.collection('bookings').add({
      ...bookings[i],
      'booking_date': Timestamp.fromDate(bookings[i]['booking_date'] as DateTime),
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('bookings/${doc.id}: OK');
  }

  // 🔟 Documents
  final documents = [
    {'trip_id': '1', 'name': 'Flight Ticket', 'file_url': 'https://example.com/ticket.pdf'},
    {'trip_id': '2', 'name': 'Hotel Booking', 'file_url': 'https://example.com/hotel.pdf'},
  ];
  for (var i = 0; i < documents.length; i++) {
    final doc = await db.collection('documents').add({
      ...documents[i],
      'uploaded_at': FieldValue.serverTimestamp(),
    });
    logs.add('documents/${doc.id}: OK');
  }

  // 1️⃣1️⃣ Weather Snapshots
  final weatherSnapshots = [
    {'trip_id': '2', 'snapshot_date': DateTime(2025, 4, 6), 'location': 'Madrid', 'weather_summary': 'Sunny', 'temperature': 26.5},
  ];
  for (var i = 0; i < weatherSnapshots.length; i++) {
    final doc = await db.collection('weather_snapshots').add({
      ...weatherSnapshots[i],
      'snapshot_date': Timestamp.fromDate(weatherSnapshots[i]['snapshot_date'] as DateTime),
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('weather_snapshots/${doc.id}: OK');
  }

  // 1️⃣2️⃣ Local Guides
  final localGuides = [
    {'trip_id': '2', 'name': 'Carlos Ruiz', 'contact_info': 'carlos@example.com', 'recommendation': 'Wine route in La Rioja'},
  ];
  for (var i = 0; i < localGuides.length; i++) {
    final doc = await db.collection('local_guides').add({
      ...localGuides[i],
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('local_guides/${doc.id}: OK');
  }

  // 1️⃣3️⃣ Trip Photos
  final tripPhotos = [
    {'trip_id': '1', 'photo_url': 'https://example.com/photo1.jpg', 'caption': 'Times Square'},
  ];
  for (var i = 0; i < tripPhotos.length; i++) {
    final doc = await db.collection('trip_photos').add({
      ...tripPhotos[i],
      'uploaded_at': FieldValue.serverTimestamp(),
    });
    logs.add('trip_photos/${doc.id}: OK');
  }

  // 1️⃣4️⃣ Calendar Events
  final calendarEvents = [
    {'user_id': '1', 'trip_id': '1', 'title': 'New York City', 'start_date': DateTime(2025, 6, 4), 'end_date': DateTime(2025, 6, 4), 'color': 'pink', 'source': 'Internal'},
    {'user_id': '1', 'trip_id': '4', 'title': 'Paris', 'start_date': DateTime(2025, 6, 5), 'end_date': DateTime(2025, 6, 5), 'color': 'magenta', 'source': 'Internal'},
    {'user_id': '1', 'trip_id': '2', 'title': 'Spain', 'start_date': DateTime(2025, 6, 8), 'end_date': DateTime(2025, 6, 8), 'color': 'orange', 'source': 'Internal'},
    {'user_id': '1', 'trip_id': null, 'title': 'Danlicco', 'start_date': DateTime(2025, 6, 13), 'end_date': DateTime(2025, 6, 13), 'color': 'green', 'source': 'Internal'},
  ];
  for (var i = 0; i < calendarEvents.length; i++) {
    final doc = await db.collection('calendar_events').add({
      ...calendarEvents[i],
      'start_date': Timestamp.fromDate(calendarEvents[i]['start_date'] as DateTime),
      'end_date': Timestamp.fromDate(calendarEvents[i]['end_date'] as DateTime),
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('calendar_events/${doc.id}: OK');
  }

  // 1️⃣5️⃣ Support Topics
  final supportTopics = [
    {'title': 'Booking Issues', 'description': 'Help with flights and hotels', 'icon': 'flight_icon'},
    {'title': 'Payment & Billing', 'description': 'Manage your payments', 'icon': 'wallet_icon'},
    {'title': 'Account Settings', 'description': 'Manage your profile', 'icon': 'user_icon'},
    {'title': 'Privacy & Security', 'description': 'Keep your account safe', 'icon': 'shield_icon'},
  ];
  for (var i = 0; i < supportTopics.length; i++) {
    final doc = await db.collection('support_topics').add({
      ...supportTopics[i],
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('support_topics/${doc.id}: OK');
  }

  // 1️⃣6️⃣ Support FAQs
  final supportFaqs = [
    {'question': 'How to change my password?', 'answer': 'Go to Account Settings and click Change Password.', 'category': 'Account Settings', 'is_active': true},
    {'question': 'How to cancel a booking?', 'answer': 'Contact support via the email button.', 'category': 'Booking Issues', 'is_active': true},
  ];
  for (var i = 0; i < supportFaqs.length; i++) {
    final doc = await db.collection('support_faqs').add({
      ...supportFaqs[i],
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('support_faqs/${doc.id}: OK');
  }

  // 1️⃣7️⃣ Support Tutorials
  final supportTutorials = [
    {'title': 'How to plan your first trip', 'description': 'Walkthrough for first-time users', 'video_url': 'https://example.com/tutorial1.mp4', 'is_active': true},
  ];
  for (var i = 0; i < supportTutorials.length; i++) {
    final doc = await db.collection('support_tutorials').add({
      ...supportTutorials[i],
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('support_tutorials/${doc.id}: OK');
  }

  // 1️⃣8️⃣ Support Requests
  final supportRequests = [
    {'user_id': '1', 'email': 'johndoe@email.com', 'subject': 'Issue with payment', 'message': 'Payment failed during checkout.', 'status': 'New'},
  ];
  for (var i = 0; i < supportRequests.length; i++) {
    final doc = await db.collection('support_requests').add({
      ...supportRequests[i],
      'created_at': FieldValue.serverTimestamp(),
    });
    logs.add('support_requests/${doc.id}: OK');
  }

  logs.add('🔥 Seed de Firestore completado');
  log(logs.join('\n'), name: 'seed_firestore');
  return logs;
}

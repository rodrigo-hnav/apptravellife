import 'package:apptravellife/config/head/app_head.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  static const String name = 'calendar_screen';

  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppHead(
        title: 'Calendar',
        avatarUrl:
            'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-2.jpg',
        userName: 'John Doe',
      ),
      body: const Center(child: Text('Calendar Screen')),
    );
  }
}

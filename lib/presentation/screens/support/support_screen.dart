import 'package:apptravellife/config/head/app_head.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  static const String name = 'support_screen';

  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppHead(
        title: 'Support',
        avatarUrl:
            'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-2.jpg',
        userName: 'John Doe',
      ),
      body: const Center(child: Text('Support Screen')),
    );
  }
}

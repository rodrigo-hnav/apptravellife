import 'package:apptravellife/config/head/app_head.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const String name = 'account_screen';

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppHead(
        title: 'Account',
        avatarUrl:
            'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-2.jpg',
        userName: 'John Doe',
      ),
      body: const Center(child: Text('Account Screen')),
    );
  }
}

import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      drawer: buildDrawer(context),
      body: const Center(
        child: Text('This is the Profile Page'),
      ),
    );
  }
}

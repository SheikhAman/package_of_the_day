import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String id;
  const ProfilePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 100,
              color: Color(0xFF6366F1),
            ),
            const SizedBox(height: 16),
            const Text(
              'PASSED PATH PARAMETER:',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'User ID: $id',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

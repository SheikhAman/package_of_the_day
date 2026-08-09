import 'package:flutter/material.dart';

class NotificationPayloadPage extends StatelessWidget {
  final String? payload;
  const NotificationPayloadPage({super.key, this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.data_object_rounded,
              size: 80,
              color: Color(0xFF6366F1),
            ),
            const SizedBox(height: 24),
            const Text(
              'PASSED PAYLOAD:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Text(
              payload ?? 'Empty',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

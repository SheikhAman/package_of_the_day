import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Feed')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 5,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.1),
              child: const Icon(Icons.person, color: Color(0xFF6366F1)),
            ),
            title: Text(
              'User Profile #${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Tap to view profile via deep-link'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () =>
                Routemaster.of(context).push('/feed/profile/${index + 1}'),
          ),
        ),
      ),
    );
  }
}

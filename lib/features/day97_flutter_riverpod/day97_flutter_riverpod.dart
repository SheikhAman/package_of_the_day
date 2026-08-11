import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/profile_provider.dart';
import 'widgets/profile_widgets.dart';

const _accent = Color(0xFF6366F1);

class Day97FlutterRiverpod extends StatelessWidget {
  const Day97FlutterRiverpod({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: _ProfilePage());
  }
}

class _ProfilePage extends ConsumerWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Day 97 - Riverpod')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ProfilePreviewCard(user: user),
            const SizedBox(height: 32),

            // Settings Tiles
            TextField(
              onChanged: (val) =>
                  ref.read(profileProvider.notifier).updateName(val),
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person, color: _accent),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (val) =>
                  ref.read(profileProvider.notifier).updateEmail(val),
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email, color: _accent),
              ),
            ),

            ListTile(
              title: const Text("Availability Status"),
              trailing: Switch(
                value: user.isOnline,
                onChanged: (_) =>
                    ref.read(profileProvider.notifier).toggleStatus(),
                activeThumbColor: _accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

const _accent = Color(0xFF6366F1); // Modern Indigo

class Day98Timeago extends StatefulWidget {
  const Day98Timeago({super.key});

  @override
  State<Day98Timeago> createState() => _Day98TimeagoState();
}

class _Day98TimeagoState extends State<Day98Timeago> {
  // Mock data representing various events in the past
  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'App deployed to Production',
      'time': DateTime.now().subtract(const Duration(seconds: 30)),
      'icon': Icons.rocket_launch_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'New User Registered',
      'time': DateTime.now().subtract(const Duration(minutes: 15)),
      'icon': Icons.person_add_outlined,
      'color': Colors.blue,
    },
    {
      'title': 'Database Backup Completed',
      'time': DateTime.now().subtract(const Duration(hours: 4)),
      'icon': Icons.storage_rounded,
      'color': Colors.teal,
    },
    {
      'title': 'Monthly Security Audit',
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'icon': Icons.shield_outlined,
      'color': Colors.indigo,
    },
    {
      'title': 'Started 100 Days Challenge',
      'time': DateTime.now().subtract(const Duration(days: 98)),
      'icon': Icons.auto_awesome_rounded,
      'color': Colors.pinkAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 98 - Timeago Feed',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Text(
                'Static dates are hard for users to process. Timeago converts '
                'timestamps into natural "fuzzy" time like "5 minutes ago."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'RECENT SYSTEM LOGS',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.black38,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            // ── Dynamic List View ──────────────────────────────────
            Expanded(
              child: ListView.builder(
                itemCount: _activities.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = _activities[index];
                  final DateTime timestamp = item['time'];
                  final Color itemColor = item['color'];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.04),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: itemColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(item['icon'], color: itemColor, size: 22),
                      ),
                      title: Text(
                        item['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      // ── THE MAGIC LINE ──
                      subtitle: Text(
                        timeago.format(
                          timestamp,
                        ), // Automatically converts date to string
                        style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.black12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

const _accent = Color(0xFF6C5CE7);

class Day60AnotherFlushbar extends StatelessWidget {
  const Day60AnotherFlushbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 60 - Another Flushbar',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Text(
                'another_flushbar displays beautiful floating notifications with custom colors, icons, animations, and durations. It is a modern alternative to the overlay_support package.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            FilledButton.icon(
              onPressed: () => _showFlushbar(
                context,
                title: 'Success',
                message: 'Profile updated successfully.',
                color: Colors.green,
                icon: Icons.check_circle_rounded,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 52),
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Success Notification'),
            ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: () => _showFlushbar(
                context,
                title: 'Information',
                message: 'A new Flutter package is available.',
                color: Colors.blue,
                icon: Icons.info_outline_rounded,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 52),
              ),
              icon: const Icon(Icons.info_outline),
              label: const Text('Info Notification'),
            ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: () => _showFlushbar(
                context,
                title: 'Warning',
                message: 'Your storage is almost full.',
                color: Colors.orange,
                icon: Icons.warning_amber_rounded,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 52),
              ),
              icon: const Icon(Icons.warning_amber_rounded),
              label: const Text('Warning Notification'),
            ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: () => _showFlushbar(
                context,
                title: 'Error',
                message: 'Something went wrong. Please try again.',
                color: Colors.red,
                icon: Icons.error_outline_rounded,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 52),
              ),
              icon: const Icon(Icons.error_outline),
              label: const Text('Error Notification'),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _showFlushbar(
    BuildContext context, {
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(icon, color: Colors.white),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      backgroundColor: color,
      animationDuration: const Duration(milliseconds: 350),
      boxShadows: [
        BoxShadow(
          color: color.withValues(alpha: .35),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ).show(context);
  }
}

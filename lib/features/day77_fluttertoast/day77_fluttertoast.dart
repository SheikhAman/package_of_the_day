import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const _accent = Color(0xFF6C5CE7);

class Day77Fluttertoast extends StatelessWidget {
  const Day77Fluttertoast({super.key});

  /// Displays a basic toast message at the bottom of the screen.
  /// This is the most common use case for simple notifications.
  void _showBasicToast() {
    Fluttertoast.showToast(
      msg: "This is a basic toast message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  /// Displays a customized toast at the center of the screen.
  /// Useful for drawing more attention to specific events.
  void _showAccentToast() {
    Fluttertoast.showToast(
      msg: "Action Successful!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: _accent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Immediately cancels any currently visible toasts.
  void _cancelToast() {
    Fluttertoast.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 77 - Fluttertoast',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'fluttertoast allows you to display brief, non-intrusive '
                'messages that disappear automatically. It is perfect for '
                'confirming actions or providing simple feedback.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            // ── Illustration / Icon ───────────────────────────────
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.message_rounded,
                  color: _accent,
                  size: 64,
                ),
              ),
            ),

            const Spacer(),

            // ── Buttons ────────────────────────────────────────────
            _ToastButton(
              label: 'Show Basic Toast',
              icon: Icons.notifications_none_rounded,
              color: Colors.black87,
              onPressed: _showBasicToast,
            ),
            const SizedBox(height: 12),
            _ToastButton(
              label: 'Show Accent Toast',
              icon: Icons.check_circle_outline_rounded,
              color: _accent,
              onPressed: _showAccentToast,
            ),
            const SizedBox(height: 12),
            _ToastButton(
              label: 'Cancel All Toasts',
              icon: Icons.close_rounded,
              color: Colors.redAccent,
              onPressed: _cancelToast,
            ),
          ],
        ),
      ),
    );
  }
}

/// A reusable button widget for toast actions to maintain UI consistency.
class _ToastButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _ToastButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }
}

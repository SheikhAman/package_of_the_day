import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _accent = Color(0xFF6C5CE7);

class Day44UrlLauncher extends StatelessWidget {
  const Day44UrlLauncher({super.key});

  static final Uri _website = Uri.parse('https://youtube.com');
  static final Uri _phoneCall = Uri(scheme: 'tel', path: '+8801515631065');
  static final Uri _sms = Uri(scheme: 'sms', path: '+8801515631065');

  // The original's "Call / SMS" button only ever launched SMS — the `tel`
  // URI was commented out, so the label didn't match what actually
  // happened. Split into two distinct actions so each button does
  // exactly what it says.
  Future<void> _launch(
    BuildContext context,
    Uri uri,
    String failureLabel,
  ) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Couldn't $failureLabel on this device")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 44 · URL Launcher',
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
                'url_launcher opens links, phone dialers, SMS composers, '
                'and email clients using the device\'s default handler for '
                'each URI scheme.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 28),

            _ActionTile(
              icon: Icons.public_rounded,
              title: 'Open Website',
              subtitle: 'youtube.com',
              onTap: () => _launch(context, _website, 'open that link'),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              icon: Icons.call_rounded,
              title: 'Call',
              subtitle: '+880 1515 631065',
              onTap: () => _launch(context, _phoneCall, 'start a call'),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              icon: Icons.sms_rounded,
              title: 'Send SMS',
              subtitle: '+880 1515 631065',
              onTap: () => _launch(context, _sms, 'open messages'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: _accent, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}

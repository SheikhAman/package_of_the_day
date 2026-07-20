import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _accent = Color(0xFF6C5CE7);

class Day07FontAwesomeFlutter extends StatelessWidget {
  const Day07FontAwesomeFlutter({super.key});

  // A small, varied set of icons — brand icons + common UI icons.
  static const List<Map<String, dynamic>> _icons = [
    {'icon': FontAwesomeIcons.github, 'label': 'GitHub'},
    {'icon': FontAwesomeIcons.google, 'label': 'Google'},
    {'icon': FontAwesomeIcons.linkedin, 'label': 'LinkedIn'},
    {'icon': FontAwesomeIcons.bell, 'label': 'Bell'},
    {'icon': FontAwesomeIcons.heart, 'label': 'Heart'},
    {'icon': FontAwesomeIcons.solidStar, 'label': 'Star'},
    {'icon': FontAwesomeIcons.paperPlane, 'label': 'Send'},
    {'icon': FontAwesomeIcons.magnifyingGlass, 'label': 'Search'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 07 · Font Awesome',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
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
                'font_awesome_flutter brings 2000+ Font Awesome icons '
                '(solid, regular, and brand) to Flutter as simple FaIcon '
                'widgets — a drop-in replacement for the standard Icon.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Icon Showcase',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // ── Icon grid ────────────────────────────────────────────
            Expanded(
              child: GridView.builder(
                itemCount: _icons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = _icons[index];
                  return _IconTile(
                    icon: item['icon'] as FaIconData,
                    label: item['label'] as String,
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

class _IconTile extends StatelessWidget {
  final FaIconData icon;
  final String label;

  const _IconTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FaIcon(icon, color: _accent, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 10.5, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

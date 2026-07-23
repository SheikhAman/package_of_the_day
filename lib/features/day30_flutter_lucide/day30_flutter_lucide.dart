import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

const _accent = Color(0xFF6C5CE7);

class Day30FlutterLucide extends StatelessWidget {
  const Day30FlutterLucide({super.key});

  static const List<Map<String, dynamic>> _icons = [
    {'icon': LucideIcons.aperture, 'label': 'Aperture'},
    {'icon': LucideIcons.cast, 'label': 'Cast'},
    {'icon': LucideIcons.refresh_cw, 'label': 'Refresh'},
    {'icon': LucideIcons.anchor, 'label': 'Anchor'},
    {'icon': LucideIcons.chart_pie, 'label': 'Pie Chart'},
    {'icon': LucideIcons.chart_bar, 'label': 'Bar Chart'},
    {'icon': LucideIcons.key, 'label': 'Key'},
    {'icon': LucideIcons.clock, 'label': 'Clock'},
    {'icon': LucideIcons.camera, 'label': 'Camera'},
    {'icon': LucideIcons.lock, 'label': 'Lock'},
    {'icon': LucideIcons.calendar, 'label': 'Calendar'},
    {'icon': LucideIcons.shopping_cart, 'label': 'Cart'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 30 - Flutter Lucide',
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
                'Lucide is a set of simple, consistent outline icons on a '
                '24x24 grid — a clean alternative to Material\'s filled '
                'icon set.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),

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
                    icon: item['icon'] as IconData,
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
  final IconData icon;
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
            child: Icon(icon, color: _accent, size: 22),
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

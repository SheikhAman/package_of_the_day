import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

const _accent = Color(0xFF6C5CE7);

class Day35PhosphorFlutterIcons extends StatelessWidget {
  const Day35PhosphorFlutterIcons({super.key});

  static const List<_DemoIcon> _icons = [
    _DemoIcon(icon: PhosphorIcons.taxi, label: 'Taxi'),
    _DemoIcon(icon: PhosphorIcons.bus, label: 'Bus'),
    _DemoIcon(icon: PhosphorIcons.carSimple, label: 'Car'),
    _DemoIcon(icon: PhosphorIcons.bicycle, label: 'Cycling'),
    _DemoIcon(icon: PhosphorIcons.radio, label: 'Radio'),
    _DemoIcon(icon: PhosphorIcons.pencilSimple, label: 'Pen'),
    _DemoIcon(icon: PhosphorIcons.calendarBlank, label: 'Calendar'),
    _DemoIcon(icon: PhosphorIcons.chatCircle, label: 'Chat'),
    _DemoIcon(icon: PhosphorIcons.signIn, label: 'Sign In'),
    _DemoIcon(icon: PhosphorIcons.signOut, label: 'Sign Out'),
    _DemoIcon(icon: PhosphorIcons.trash, label: 'Delete'),
    _DemoIcon(icon: PhosphorIcons.cloudArrowDown, label: 'Download'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 35 - Phosphor Icons',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                'Phosphor is a flexible, actively maintained icon family with '
                '6 weight styles — Thin, Light, Regular, Bold, Fill and Duotone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                itemCount: _icons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: .85,
                ),
                itemBuilder: (context, index) {
                  return _IconTile(item: _icons[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoIcon {
  final PhosphorIconData Function([PhosphorIconsStyle]) icon;
  final String label;

  const _DemoIcon({required this.icon, required this.label});
}

class _IconTile extends StatelessWidget {
  final _DemoIcon item;

  const _IconTile({required this.item});

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
              color: _accent.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: PhosphorIcon(
              item.icon(PhosphorIconsStyle.regular),
              color: _accent,
              size: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            style: const TextStyle(fontSize: 10.5, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'pages/aligned_page.dart';
import 'pages/masonry_page.dart';
import 'pages/quilted_page.dart';
import 'pages/staggered_page.dart';
import 'pages/staired_page.dart';
import 'pages/woven_page.dart';
import 'widgets/custom_appbar.dart';

const _accent = Color(0xFF6C5CE7);

class Day36FlutterStaggeredGridView extends StatelessWidget {
  const Day36FlutterStaggeredGridView({super.key});

  static const List<Map<String, dynamic>> _entries = [
    {
      'title': 'Staggered',
      'icon': Icons.view_quilt_rounded,
      'page': StaggeredPage(),
    },
    {
      'title': 'Masonry',
      'icon': Icons.dashboard_customize_rounded,
      'page': MasonryPage(),
    },
    {
      'title': 'Quilted',
      'icon': Icons.grid_view_rounded,
      'page': QuiltedPage(),
    },
    {'title': 'Woven', 'icon': Icons.blur_linear_rounded, 'page': WovenPage()},
    {'title': 'Staired', 'icon': Icons.stairs_rounded, 'page': StairedPage()},
    {
      'title': 'Aligned',
      'icon': Icons.view_column_rounded,
      'page': AlignedPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Day 36 · Staggered Grid View'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
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
              'flutter_staggered_grid_view ships 6 different grid layout '
              'delegates — pick a style below to see it in action with '
              'real (network) images.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(_entries.length, (index) {
            final entry = _entries[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _entries.length - 1 ? 0 : 12,
              ),
              child: _MenuTile(
                title: entry['title'],
                icon: entry['icon'],
                page: entry['page'],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// The original loaded thumbnail images from assets/images/staggered_grid_view/
// that aren't available here. Replaced with icon-based cards instead.
class _MenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget page;

  const _MenuTile({
    required this.title,
    required this.icon,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
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
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
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

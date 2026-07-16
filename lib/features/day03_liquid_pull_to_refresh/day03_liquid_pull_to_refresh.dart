import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

const _accent = Color(0xFF6C5CE7);

class Day03LiquidPullToRefresh extends StatefulWidget {
  const Day03LiquidPullToRefresh({super.key});

  @override
  State<Day03LiquidPullToRefresh> createState() =>
      _Day03LiquidPullToRefreshState();
}

class _Day03LiquidPullToRefreshState extends State<Day03LiquidPullToRefresh> {
  int _refreshCount = 0;
  DateTime? _lastRefreshed;

  final List<Map<String, dynamic>> _items = const [
    {
      'icon': Icons.explore_outlined,
      'title': 'Explore',
      'subtitle': 'Discover new content',
    },
    {
      'icon': Icons.favorite_outline,
      'title': 'Favorites',
      'subtitle': 'Things you love',
    },
    {
      'icon': Icons.notifications_none,
      'title': 'Notifications',
      'subtitle': 'Stay up to date',
    },
    {
      'icon': Icons.settings_outlined,
      'title': 'Settings',
      'subtitle': 'Customize your app',
    },
    {
      'icon': Icons.person_outline,
      'title': 'Profile',
      'subtitle': 'Manage your account',
    },
  ];

  Future<void> _handleRefresh() async {
    // Simulates a network call / reloading data.
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _refreshCount++;
      _lastRefreshed = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 03 · Liquid Pull to Refresh',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // ── Info card ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Container(
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.water_drop_outlined,
                      color: _accent,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Pull down on the list to trigger an animated '
                      'liquid-fill refresh effect.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Refresh stats ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.refresh_rounded,
                    label: 'Refreshes',
                    value: '$_refreshCount',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.schedule_rounded,
                    label: 'Last refreshed',
                    value: _lastRefreshed == null
                        ? '—'
                        : '${_lastRefreshed!.hour.toString().padLeft(2, '0')}:'
                              '${_lastRefreshed!.minute.toString().padLeft(2, '0')}:'
                              '${_lastRefreshed!.second.toString().padLeft(2, '0')}',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Pull to refresh list ────────────────────────────────
          Expanded(
            child: LiquidPullToRefresh(
              onRefresh: _handleRefresh,
              color: _accent,
              backgroundColor: Colors.white,
              height: 180,
              animSpeedFactor: 2,
              showChildOpacityTransition: false,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return _ListTileCard(
                    icon: item['icon'] as IconData,
                    title: item['title'] as String,
                    subtitle: item['subtitle'] as String,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        children: [
          Icon(icon, size: 18, color: _accent),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black45, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListTileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ListTileCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
                  style: const TextStyle(fontSize: 12.5, color: Colors.black45),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.black26),
        ],
      ),
    );
  }
}

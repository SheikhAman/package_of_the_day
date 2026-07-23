import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

const _accent = Color(0xFF6C5CE7);

class Day33CurvedLabeledNavBar extends StatefulWidget {
  const Day33CurvedLabeledNavBar({super.key});

  @override
  State<Day33CurvedLabeledNavBar> createState() =>
      _Day33CurvedLabeledNavBarState();
}

class _Day33CurvedLabeledNavBarState extends State<Day33CurvedLabeledNavBar> {
  int _selectedIndex = 2;

  static const List<_NavDestination> _destinations = [
    _NavDestination(icon: Icons.home_rounded, label: 'Home'),
    _NavDestination(icon: Icons.explore_rounded, label: 'Discovery'),
    _NavDestination(icon: Icons.add_rounded, label: 'Add'),
    _NavDestination(icon: Icons.mail_rounded, label: 'Message'),
    _NavDestination(icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final destination = _destinations[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Day 33 - ${destination.label}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      // IndexedStack keeps each page's widget alive when switching tabs,
      // instead of rebuilding it from scratch every time (what
      // _pages[_selectIndex] does in the original).
      body: IndexedStack(
        index: _selectedIndex,
        children: _destinations
            .map((d) => _PageContent(destination: d))
            .toList(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: const Color(0xFFF7F7FB),
        color: _accent,
        buttonBackgroundColor: _accent,
        items: _destinations
            .map(
              (d) => CurvedNavigationBarItem(
                child: Icon(d.icon, color: Colors.white),
                label: d.label,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            )
            .toList(),
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _NavDestination {
  final IconData icon;
  final String label;
  const _NavDestination({required this.icon, required this.label});
}

// Replaces the 5 nearly-identical page files (HomePage, DiscoveryPage,
// AddPage, MessagePage, ProfilePage) — each was the same layout with a
// different string — with one reusable content widget driven by data.
class _PageContent extends StatelessWidget {
  final _NavDestination destination;
  const _PageContent({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(destination.icon, color: _accent, size: 42),
          ),
          const SizedBox(height: 20),
          Text(
            '${destination.label} Page',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Curved Labeled Navigation Bar',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

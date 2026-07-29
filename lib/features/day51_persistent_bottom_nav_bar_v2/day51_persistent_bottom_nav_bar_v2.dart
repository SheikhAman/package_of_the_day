import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

const _accent = Color(0xFF6C5CE7);

class Day51PersistentBottomNavBarV2 extends StatefulWidget {
  const Day51PersistentBottomNavBarV2({super.key});

  @override
  State<Day51PersistentBottomNavBarV2> createState() =>
      _Day51PersistentBottomNavBarV2State();
}

class _Day51PersistentBottomNavBarV2State
    extends State<Day51PersistentBottomNavBarV2> {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<PersistentTabConfig> get _tabs => [
    _tab(title: 'Home', icon: Icons.home_rounded),
    _tab(title: 'Explore', icon: Icons.explore_rounded),
    _tab(title: 'Add', icon: Icons.add_circle_rounded),
    _tab(title: 'Inbox', icon: Icons.mail_rounded),
    _tab(title: 'Profile', icon: Icons.person_rounded),
  ];

  PersistentTabConfig _tab({required String title, required IconData icon}) {
    return PersistentTabConfig(
      screen: _Page(title: title, icon: icon),
      item: ItemConfig(
        icon: Icon(icon),
        title: title,
        activeForegroundColor: _accent,
        inactiveForegroundColor: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: _tabs,
      navBarBuilder: (navBarConfig) =>
          Style3BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}

class _Page extends StatelessWidget {
  final String title;
  final IconData icon;

  const _Page({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Center(
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_accent, Color(0xFF8E7CFF)],
            ),
            boxShadow: [
              BoxShadow(
                color: _accent.withOpacity(.25),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 72, color: Colors.white),
              const SizedBox(height: 18),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

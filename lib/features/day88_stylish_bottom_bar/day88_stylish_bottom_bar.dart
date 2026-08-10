import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

const _accent = Color(0xFF6366F1);

class Day88StylishBottomBar extends StatefulWidget {
  const Day88StylishBottomBar({super.key});

  @override
  State<Day88StylishBottomBar> createState() => _Day88StylishBottomBarState();
}

class _Day88StylishBottomBarState extends State<Day88StylishBottomBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 88 - Stylish Bar',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        children: const [
          _NavPage(
            title: 'Home',
            icon: Icons.grid_view_rounded,
            color: Colors.indigo,
          ),
          _NavPage(
            title: 'Inventory',
            icon: Icons.inventory_2_outlined,
            color: Colors.orange,
          ),
          _NavPage(
            title: 'Messages',
            icon: Icons.chat_bubble_outline_rounded,
            color: Colors.pink,
          ),
          _NavPage(
            title: 'Settings',
            icon: Icons.settings_outlined,
            color: Colors.teal,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: StylishBottomBar(
          option: BubbleBarOptions(
            barStyle: BubbleBarStyle.vertical,
            bubbleFillStyle: BubbleFillStyle.fill,
            opacity: 0.1,
            // unselectedIconColor was removed from here
          ),
          items: [
            BottomBarItem(
              icon: const Icon(Icons.grid_view_rounded),
              title: const Text('Home'),
              selectedColor: Colors.indigo,
            ),
            BottomBarItem(
              icon: const Icon(Icons.inventory_2_rounded),
              title: const Text('Inventory'),
              selectedColor: Colors.orange,
            ),
            BottomBarItem(
              icon: const Icon(Icons.chat_bubble_rounded),
              title: const Text('Messages'),
              selectedColor: Colors.pink,
            ),
            BottomBarItem(
              icon: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              selectedColor: Colors.teal,
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuint,
            );
          },
        ),
      ),
    );
  }
}

class _NavPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _NavPage({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(icon, size: 80, color: color),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: color.withOpacity(0.8),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Modern Navigation implementation',
            style: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

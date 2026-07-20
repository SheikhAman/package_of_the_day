import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const _accent = Color(0xFF6C5CE7);

class Day06SmoothPageIndicator extends StatefulWidget {
  const Day06SmoothPageIndicator({super.key});

  @override
  State<Day06SmoothPageIndicator> createState() =>
      _Day06SmoothPageIndicatorState();
}

class _Day06SmoothPageIndicatorState extends State<Day06SmoothPageIndicator> {
  final _controller = PageController();
  int _currentPage = 0;

  static const List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.flight_takeoff_rounded,
      'title': 'Welcome Aboard',
      'subtitle': 'A quick tour of what you can do here',
      'gradient': [Color(0xFF6C5CE7), Color(0xFF8E7CFF)],
    },
    {
      'icon': Icons.dashboard_customize_rounded,
      'title': 'Build Your Space',
      'subtitle': 'Arrange widgets exactly the way you like',
      'gradient': [Color(0xFFEC4899), Color(0xFFF472B6)],
    },
    {
      'icon': Icons.groups_rounded,
      'title': 'Work Together',
      'subtitle': 'Invite your team and share progress in real time',
      'gradient': [Color(0xFF14B8A6), Color(0xFF2DD4BF)],
    },
    {
      'icon': Icons.rocket_launch_rounded,
      'title': 'Ready to Go',
      'subtitle': 'You\'re all set — let\'s get started',
      'gradient': [Color(0xFF64748B), Color(0xFF94A3B8)],
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage == _pages.length - 1) return;
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 06 · Smooth Page Indicator',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // ── Info card ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
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
                    child: const Icon(Icons.swipe_rounded, color: _accent),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'smooth_page_indicator pairs with any PageView to add '
                      'polished, animated dot indicators — a staple of '
                      'onboarding flows.',
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

          // ── Onboarding page view — fixed, reasonable height ─────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  children: _pages.map((page) {
                    return _OnboardingPage(
                      icon: page['icon'] as IconData,
                      title: page['title'] as String,
                      subtitle: page['subtitle'] as String,
                      gradient: page['gradient'] as List<Color>,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          SmoothPageIndicator(
            controller: _controller,
            count: _pages.length,
            effect: ExpandingDotsEffect(
              activeDotColor: _accent,
              dotColor: _accent.withValues(alpha: 0.2),
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 3,
              spacing: 6,
            ),
          ),

          const SizedBox(height: 24),

          // ── Next / Get started button ───────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLast ? null : _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: _accent.withValues(alpha: 0.4),
                  disabledForegroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  isLast ? 'You\'re all set' : 'Next',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
      ),
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 44),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

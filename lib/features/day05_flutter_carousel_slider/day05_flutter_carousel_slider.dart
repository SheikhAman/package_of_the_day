import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

const _accent = Color(0xFF6C5CE7);

class Day05FlutterCarouselSlider extends StatelessWidget {
  const Day05FlutterCarouselSlider({super.key});

  static const List<Map<String, dynamic>> _slides = [
    {
      'icon': Icons.rocket_launch_rounded,
      'title': 'Launch Fast',
      'subtitle': 'Ship features without reinventing the wheel',
      'gradient': [Color(0xFF6C5CE7), Color(0xFF8E7CFF)],
    },
    {
      'icon': Icons.palette_rounded,
      'title': 'Look Great',
      'subtitle': 'Smooth transitions with almost no setup',
      'gradient': [Color(0xFFEC4899), Color(0xFFF472B6)],
    },
    {
      'icon': Icons.bolt_rounded,
      'title': 'Stay Light',
      'subtitle': 'A small package with a big visual payoff',
      'gradient': [Color(0xFF14B8A6), Color(0xFF2DD4BF)],
    },
    {
      'icon': Icons.tune_rounded,
      'title': 'Fully Configurable',
      'subtitle': 'Swap transforms and indicators in one line',
      'gradient': [Color(0xFF64748B), Color(0xFF94A3B8)],
    },
  ];

  static const List<Map<String, dynamic>> _highlights = [
    {
      'icon': Icons.speed_rounded,
      'title': 'Smooth by default',
      'subtitle': 'Transitions run at 60fps out of the box',
    },
    {
      'icon': Icons.widgets_outlined,
      'title': 'Any widget as a slide',
      'subtitle': 'Cards, images, forms — anything goes',
    },
    {
      'icon': Icons.autorenew_rounded,
      'title': 'Loops seamlessly',
      'subtitle': 'unlimitedMode wraps around in both directions',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 05 · Carousel Slider',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
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
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.view_carousel_rounded,
                    color: _accent,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'flutter_carousel_slider ships fun 3D transitions '
                    '(like a cube flip) with built-in slide indicators, '
                    'great for onboarding and featured-content banners.',
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

          const SizedBox(height: 20),

          // ── Carousel banner — fixed height, not full screen ─────
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 220,
              child: CarouselSlider(
                slideTransform: const CubeTransform(),
                slideIndicator: CircularSlideIndicator(
                  padding: const EdgeInsets.only(bottom: 16),
                  currentIndicatorColor: Colors.white,
                ),
                unlimitedMode: true,
                children: _slides.map((slide) {
                  return _CarouselCard(
                    icon: slide['icon'] as IconData,
                    title: slide['title'] as String,
                    subtitle: slide['subtitle'] as String,
                    gradient: slide['gradient'] as List<Color>,
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'Why use it',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),

          // ── Supporting content below the banner ─────────────────
          ...List.generate(_highlights.length, (index) {
            final item = _highlights[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _highlights.length - 1 ? 0 : 12,
              ),
              child: _HighlightTile(
                icon: item['icon'] as IconData,
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;

  const _CarouselCard({
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _HighlightTile({
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
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
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
        ],
      ),
    );
  }
}

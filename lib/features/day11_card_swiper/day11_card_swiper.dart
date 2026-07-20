import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

const _accent = Color(0xFF6C5CE7);

class Day11CardSwiper extends StatelessWidget {
  const Day11CardSwiper({super.key});

  // In the original example these were asset images (assets/images/banner/*).
  // Swapped for styled gradient cards so this runs without needing image
  // assets bundled in the project.
  static const List<Map<String, dynamic>> _banners = [
    {
      'title': '11.11 Sale',
      'subtitle': 'Up to 50% off storewide',
      'icon': Icons.shopping_bag_rounded,
      'gradient': [Color(0xFF6C5CE7), Color(0xFF8E7CFF)],
    },
    {
      'title': 'Black Friday',
      'subtitle': 'Biggest deals of the year',
      'icon': Icons.local_fire_department_rounded,
      'gradient': [Color(0xFF111827), Color(0xFF374151)],
    },
    {
      'title': 'Cyber Monday',
      'subtitle': 'Online-only exclusive offers',
      'icon': Icons.laptop_mac_rounded,
      'gradient': [Color(0xFF0EA5E9), Color(0xFF38BDF8)],
    },
    {
      'title': 'Christmas',
      'subtitle': 'Festive picks, gift-wrapped',
      'icon': Icons.card_giftcard_rounded,
      'gradient': [Color(0xFFDC2626), Color(0xFFF87171)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 11 · Card Swiper',
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
            child: const Text(
              'card_swiper turns a list of widgets into an auto-playing, '
              'swipeable carousel with pagination dots — a common pattern '
              'for promo banners.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── Promo banner swiper — fixed, sensible height ────────
          SizedBox(
            height: 190,
            child: Swiper(
              itemCount: _banners.length,
              autoplay: true,
              autoplayDelay: 4000,
              curve: Curves.easeInOut,
              layout: SwiperLayout.DEFAULT,
              pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  color: Colors.black26,
                  activeColor: _accent,
                ),
              ),
              itemBuilder: (context, index) {
                final banner = _banners[index];
                return _BannerCard(
                  title: banner['title'] as String,
                  subtitle: banner['subtitle'] as String,
                  icon: banner['icon'] as IconData,
                  gradient: banner['gradient'] as List<Color>,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;

  const _BannerCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

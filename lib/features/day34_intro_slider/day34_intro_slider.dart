import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

const _accent = Color(0xFF6C5CE7);

class Day34IntroSlider extends StatefulWidget {
  const Day34IntroSlider({super.key});

  @override
  State<Day34IntroSlider> createState() => _Day34IntroSliderState();
}

class _Day34IntroSliderState extends State<Day34IntroSlider> {
  // The original loaded local asset images (pathImage). Replaced with
  // `centerWidget` — an icon in a soft circle — so this runs without any
  // bundled image assets.
  final List<ContentConfig> _slides = [
    ContentConfig(
      title: 'Hello Food!',
      description:
          'The easiest way to order food from your favorite restaurant.',
      centerWidget: _SlideIcon(Icons.lunch_dining_rounded),
      colorBegin: _accent,
      colorEnd: const Color(0xFF8E7CFF),
    ),
    ContentConfig(
      title: 'Movie Tickets',
      description: 'Book movie tickets for your family and friends!',
      centerWidget: _SlideIcon(Icons.local_movies_rounded),
      colorBegin: const Color(0xFFEC4899),
      colorEnd: const Color(0xFFF472B6),
    ),
    ContentConfig(
      title: 'Great Discounts!',
      description: 'Best discounts on every single service we offer.',
      centerWidget: _SlideIcon(Icons.local_offer_rounded),
      colorBegin: const Color(0xFF14B8A6),
      colorEnd: const Color(0xFF2DD4BF),
    ),
    ContentConfig(
      title: 'Travel the World',
      description: 'Book tickets for any transportation and travel the world.',
      centerWidget: _SlideIcon(Icons.flight_takeoff_rounded),
      colorBegin: const Color(0xFFF59E0B),
      colorEnd: const Color(0xFFFBBF24),
    ),
  ];

  void _onDonePress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const _HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      listContentConfig: _slides,
      renderSkipBtn: const Text(
        'Skip',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      renderNextBtn: const Text(
        'Next',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      renderDoneBtn: const Text(
        'Done',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      indicatorConfig: const IndicatorConfig(
        colorIndicator: Colors.white38,
        colorActiveIndicator: Colors.white,
        sizeIndicator: 8,
        typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
      ),
      navigationBarConfig: NavigationBarConfig(
        navPosition: NavPosition.bottom,
        backgroundColor: Colors.black.withValues(alpha: 0.15),
      ),
      scrollPhysics: const BouncingScrollPhysics(),
      onDonePress: _onDonePress,
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 34 - Intro Slider',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
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
              child: const Icon(
                Icons.celebration_rounded,
                color: _accent,
                size: 44,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideIcon extends StatelessWidget {
  final IconData icon;
  const _SlideIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 52),
    );
  }
}

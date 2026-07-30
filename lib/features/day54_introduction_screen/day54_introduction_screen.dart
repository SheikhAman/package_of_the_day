import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

const _accent = Color(0xFF6C5CE7);

class Day54IntroductionScreen extends StatelessWidget {
  const Day54IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: 'Welcome',
          body:
              'Build beautiful Flutter apps with powerful packages and easy-to-understand examples.',
          image: _buildIcon(Icons.flutter_dash_rounded),
        ),
        PageViewModel(
          title: 'Learn Faster',
          body:
              'Discover useful widgets, animations, and packages through beginner-friendly demos.',
          image: _buildIcon(Icons.auto_awesome_rounded),
        ),
        PageViewModel(
          title: 'Start Building',
          body:
              'Apply what you learn to create modern Flutter applications with confidence.',
          image: _buildIcon(Icons.rocket_launch_rounded),
        ),
      ],

      showSkipButton: true,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),

      next: const Icon(Icons.arrow_forward_rounded, color: _accent),

      done: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: _accent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          'Done',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      onDone: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Onboarding Completed!')));
      },

      dotsDecorator: DotsDecorator(
        activeColor: _accent,
        color: Colors.grey.shade300,
        activeSize: const Size(24, 8),
        size: const Size(8, 8),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      curve: Curves.easeInOut,
      animationDuration: 350,
    );
  }

  static Widget _buildIcon(IconData icon) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_accent, Color(0xFF8E7CFF)],
        ),
        boxShadow: [
          BoxShadow(
            color: _accent.withValues(alpha: .25),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 90),
    );
  }
}

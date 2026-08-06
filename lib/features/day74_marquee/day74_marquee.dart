import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

const _accent = Color(0xFF6C5CE7);

class Day74Marquee extends StatelessWidget {
  const Day74Marquee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 74 - Marquee',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Info Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'The marquee package creates smooth scrolling text animations. '
                'It is commonly used for news tickers, announcements, notifications, and promotional banners.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Marquee Banner
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Marquee(
                text:
                    '🔥 Welcome to Widget of the Day!   •   Learn Flutter Packages Easily   •   Marquee provides smooth scrolling text animations.   ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                scrollAxis: Axis.horizontal,
                blankSpace: 60,
                velocity: 60,
                pauseAfterRound: const Duration(seconds: 1),
                startPadding: 20,
                accelerationDuration: const Duration(milliseconds: 600),
                decelerationDuration: const Duration(milliseconds: 600),
                accelerationCurve: Curves.easeIn,
                decelerationCurve: Curves.easeOut,
              ),
            ),

            const SizedBox(height: 40),

            Icon(Icons.campaign_rounded, size: 90, color: _accent),

            const SizedBox(height: 20),

            const Text(
              'Announcement Banner',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Marquee automatically scrolls long text horizontally, making it perfect for banners and breaking news.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.6,
              ),
            ),

            const Spacer(),

            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Marquee is scrolling automatically!'),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Show SnackBar'),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

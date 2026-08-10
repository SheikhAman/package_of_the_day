import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

const _accent = Color(0xFF6366F1);
const _bg = Color(0xFFF8FAFC);

class Day90AnimateDo extends StatefulWidget {
  const Day90AnimateDo({super.key});

  @override
  State<Day90AnimateDo> createState() => _Day90AnimateDoState();
}

class _Day90AnimateDoState extends State<Day90AnimateDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(title: const Text('Day 90 - Animate Do'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Card (Entrance Animation) ─────────────────────
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: _accent.withValues(alpha: 0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Text(
                  'animate_do is a high-performance library that brings your UI to life. '
                  'Use it to create attention-grabbing effects like bounce, pulse, and '
                  'swing on any widget.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            // ── Bouncing Button (Infinite Attention Grabber) ───────
            const _Label(text: 'ATTENTION GRABBER (BOUNCE)'),
            Bounce(
              infinite: true,
              child: _DemoButton(
                label: 'SALE ENDING SOON!',
                color: Colors.orange,
                onTap: () {},
              ),
            ),

            const SizedBox(height: 32),

            // ── Pulsing Button (Soft Interaction) ──────────────────
            const _Label(text: 'LIVE STATUS (PULSE)'),
            Pulse(
              infinite: true,
              child: _DemoButton(
                label: 'LIVE SUPPORT ONLINE',
                color: const Color(0xFF10B981), // Fixed: Emerald color
                onTap: () {},
              ),
            ),

            const SizedBox(height: 32),

            // ── Elastic Entrance ───────────────────────────────────
            const _Label(text: 'ELASTIC ENTRANCE'),
            ElasticIn(
              delay: const Duration(milliseconds: 500),
              child: _DemoButton(
                label: 'GET STARTED FREE',
                color: _accent,
                onTap: () {},
              ),
            ),

            const SizedBox(height: 32),

            // ── Jello Effect ───────────────────────────────────────
            const _Label(text: 'PLAYFUL FEEDBACK (JELLO)'),
            JelloIn(
              child: _DemoButton(
                label: 'ADD TO CART',
                color: Colors.pinkAccent,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple label widget to organize the UI
class _Label extends StatelessWidget {
  final String text;
  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Colors.black38,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

/// A standard button used to demonstrate the animations
class _DemoButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DemoButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

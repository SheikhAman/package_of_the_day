import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

const _accent = Color(0xFF6C5CE7);

class Day31SimpleGradientText extends StatelessWidget {
  const Day31SimpleGradientText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 31 - Gradient Text',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                'simple_gradient_text paints any string with a linear or '
                'radial color gradient — a quick way to make a headline '
                'or logo text stand out.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── Hero gradient title ──────────────────────────────────
            Center(
              child: GradientText(
                'Package of\nthe Day',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
                colors: [_accent, Color(0xFFEC4899), Color(0xFFF59E0B)],
              ),
            ),

            const SizedBox(height: 48),

            const Text(
              'Linear Gradient',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            _GradientCard(
              child: GradientText(
                'Ocean Breeze',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                colors: const [Color(0xFF0EA5E9), Color(0xFF14B8A6)],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Radial Gradient',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            _GradientCard(
              child: GradientText(
                'Sunset Glow',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                gradientType: GradientType.radial,
                radius: 2.0,
                colors: const [
                  Color(0xFFF59E0B),
                  Color(0xFFEC4899),
                  Color(0xFF6C5CE7),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientCard extends StatelessWidget {
  final Widget child;
  const _GradientCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 28),
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
      child: child,
    );
  }
}

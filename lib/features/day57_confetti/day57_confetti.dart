import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

const _accent = Color(0xFF6C5CE7);

class Day57Confetti extends StatefulWidget {
  const Day57Confetti({super.key});

  @override
  State<Day57Confetti> createState() => _Day57ConfettiState();
}

class _Day57ConfettiState extends State<Day57Confetti> {
  // A short, one-shot burst reads better as a demo than an endless loop —
  // set a fixed duration instead of shouldLoop: true.
  late final ConfettiController _controller = ConfettiController(
    duration: const Duration(seconds: 2),
  );

  @override
  void dispose() {
    // Always dispose controllers you create, or they leak.
    _controller.dispose();
    super.dispose();
  }

  void _celebrate() {
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 57 - Confetti',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      // Scaffold stays the top-level widget for this screen (the standard
      // pattern) — the confetti overlay lives inside the body's Stack,
      // rather than wrapping the whole Scaffold in one.
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Info card ──────────────────────────────────────
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
                    'confetti plays a short particle burst — a nice bit of '
                    'delight for success screens, achievements, or "you\'re '
                    'all set" moments.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: ElevatedButton(
                    onPressed: _celebrate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Celebrate 🎉',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Positioned at the top center so particles fall down into the
          // screen, a common confetti placement.
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 20,
              emissionFrequency: 0.5,
              minBlastForce: 10,
              maxBlastForce: 100,
              colors: const [
                _accent,
                Color(0xFFEC4899),
                Color(0xFFF59E0B),
                Color(0xFF14B8A6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:confetti/confetti.dart';

const _accent = Color(0xFF6366F1); // Modern Indigo

class Day79SlideCountdown extends StatefulWidget {
  const Day79SlideCountdown({super.key});

  @override
  State<Day79SlideCountdown> createState() => _Day79SlideCountdownState();
}

class _Day79SlideCountdownState extends State<Day79SlideCountdown> {
  late ConfettiController _confettiController;

  // Use a Key to reset the SlideCountdown widget easily
  Key _countdownKey = UniqueKey();
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _resetCountdown() {
    setState(() {
      _countdownKey = UniqueKey();
      _isFinished = false;
      _confettiController.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 79 - Slide Countdown',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          // ── Confetti Layer ──────────────────────────────────────
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              createParticlePath: _drawStar,
            ),
          ),

          // ── UI Layer ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Info Card
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
                    'slide_countdown provides a highly customizable, animated '
                    'timer with sliding digit transitions. Perfect for '
                    'product launches, sales, or event kick-offs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const Spacer(),

                // Status Text
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    _isFinished ? 'CELEBRATION!' : 'COUNTDOWN STARTED',
                    key: ValueKey(_isFinished),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: _isFinished ? Colors.pink : Colors.black38,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // The Countdown
                Center(
                  child: SlideCountdownSeparated(
                    key: _countdownKey,
                    duration: const Duration(seconds: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    separatorStyle: const TextStyle(
                      color: _accent,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: BoxDecoration(
                      color: _accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onDone: () {
                      setState(() => _isFinished = true);
                      _confettiController.play();
                    },
                  ),
                ),

                const Spacer(),

                // Reset Button
                ElevatedButton.icon(
                  onPressed: _resetCountdown,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('RESET TIMER'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Path _drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }
}

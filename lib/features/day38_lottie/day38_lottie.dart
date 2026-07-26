import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const _accent = Color(0xFF6C5CE7);

class Day38Lottie extends StatefulWidget {
  const Day38Lottie({super.key});

  @override
  State<Day38Lottie> createState() => _Day38LottieState();
}

class _Day38LottieState extends State<Day38Lottie>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _bookmarked = false;

  static const String _bookmarkAnimUrl =
      'https://assets3.lottiefiles.com/packages/lf20_xdfeea13.json';
  static const String _ambientAnimUrl =
      'https://assets9.lottiefiles.com/packages/lf20_kkflmtur.json';

  @override
  void initState() {
    super.initState();
    // Duration is set once the real animation loads (see onLoaded below),
    // since hardcoding a guessed duration can make the animation play
    // faster or slower than it was designed for.
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // Dispose the controller BEFORE calling super.dispose() — the original
    // had this backwards, which can leave the controller's ticker attached
    // to a widget tree that's already being torn down.
    _controller.dispose();
    super.dispose();
  }

  void _toggleBookmark() {
    setState(() {
      _bookmarked = !_bookmarked;
      if (_bookmarked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 38 - Lottie',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
                'lottie plays After Effects animations exported as JSON — '
                'smooth, scalable, and far lighter than a video file. Tap '
                'the bookmark below to play it.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Interactive bookmark animation ───────────────────────
            Center(
              child: GestureDetector(
                onTap: _toggleBookmark,
                child: Container(
                  width: 140,
                  height: 140,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Lottie.network(
                    _bookmarkAnimUrl,
                    controller: _controller,
                    onLoaded: (composition) {
                      // Match the controller's duration to the actual
                      // animation length instead of guessing.
                      _controller.duration = composition.duration;
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.bookmark_border_rounded,
                        color: _accent,
                        size: 48,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _bookmarked ? 'Saved' : 'Tap to save',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black45,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'Ambient Loop',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // ── Looping ambient animation ─────────────────────────────
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Lottie.network(
                  _ambientAnimUrl,
                  repeat: true,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.black26,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

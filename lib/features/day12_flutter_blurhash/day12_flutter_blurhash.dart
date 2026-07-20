import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _accent = Color(0xFF6C5CE7);

class Day12FlutterBlurHash extends StatefulWidget {
  const Day12FlutterBlurHash({super.key});

  @override
  State<Day12FlutterBlurHash> createState() => _Day12FlutterBlurHashState();
}

class _Day12FlutterBlurHashState extends State<Day12FlutterBlurHash> {
  // Bumping this rebuilds the BlurHash widget with a fresh key, so you can
  // replay the blur-to-image transition without restarting the app.
  int _replayCount = 0;

  static const String _hash = 'LB9amjso4Txuq@t8yYMxD4IUysx]';
  static const String _imageUrl =
      'https://images.theconversation.com/files/350865/original/'
      'file-20200803-24-50u91u.jpg?ixlib=rb-1.1.0&rect=37%2C29%2C4955%2C3293'
      '&q=45&auto=format&w=926&fit=clip';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 12 · BlurHash',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.image,
                      color: _accent,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'BlurHash decodes a short string into a soft blurred '
                      'preview, shown instantly while the real image loads '
                      'over the network. Generate hashes at blurha.sh.',
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

            const SizedBox(height: 28),

            // ── BlurHash demo card ───────────────────────────────────
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: BlurHash(
                    key: ValueKey(_replayCount),
                    hash: _hash,
                    imageFit: BoxFit.cover,
                    duration: const Duration(seconds: 2),
                    image: _imageUrl,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              'Blurred placeholder fades into the real image once it loads.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black45),
            ),

            const SizedBox(height: 20),

            Center(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _replayCount++),
                icon: const Icon(Icons.replay_rounded, size: 18),
                label: const Text('Replay transition'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _accent,
                  side: const BorderSide(color: _accent),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

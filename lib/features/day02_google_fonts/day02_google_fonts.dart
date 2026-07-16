import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Day02GoogleFonts extends StatefulWidget {
  const Day02GoogleFonts({super.key});

  @override
  State<Day02GoogleFonts> createState() => _Day02GoogleFontsState();
}

class _Day02GoogleFontsState extends State<Day02GoogleFonts> {
  double _fontSize = 28;
  bool _isBold = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day 02 - Google Fonts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF4F46E5).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'GoogleFonts gives instant access to 1500+ fonts from '
                'fonts.google.com, no manual downloads or pubspec asset '
                'setup required. Great for quick typography experiments.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, height: 1.6),
              ),
            ),

            const SizedBox(height: 40),

            // ── Example: curated font showcase ─────────────────────
            const Text(
              'Popular Fonts',
              style: TextStyle(fontSize: 13, letterSpacing: 1),
            ),
            const SizedBox(height: 16),
            _FontPreview(
              label: 'pressStart2p',
              style: GoogleFonts.pressStart2p(fontSize: 18),
              sample: 'SPACE INVADERS',
            ),
            const SizedBox(height: 20),
            _FontPreview(
              label: 'ubuntuMono',
              style: GoogleFonts.ubuntuMono(fontSize: 28),
              sample: 'ubuntuMono',
            ),
            const SizedBox(height: 20),
            _FontPreview(
              label: 'molengo',
              style: GoogleFonts.molengo(fontSize: 28),
              sample: 'molengo',
            ),
            const SizedBox(height: 20),
            _FontPreview(
              label: 'shadowsIntoLight',
              style: GoogleFonts.shadowsIntoLight(fontSize: 28),
              sample: 'shadowsIntoLight',
            ),

            const SizedBox(height: 50),

            // ── Interactive: live font size + weight control ───────
            const Text(
              'Live Preview',
              style: TextStyle(fontSize: 13, letterSpacing: 1),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black45.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Flutter Rocks',
                style: GoogleFonts.poppins(
                  fontSize: _fontSize,
                  color: const Color(0xFF4F46E5),
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.text_fields, color: Colors.white54, size: 18),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 14,
                    max: 48,
                    activeColor: const Color(0xFF4F46E5),
                    onChanged: (value) => setState(() => _fontSize = value),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Toggle button ──────────────────────────────────────
            ElevatedButton.icon(
              onPressed: () => setState(() => _isBold = !_isBold),
              icon: Icon(
                _isBold ? Icons.format_bold : Icons.format_bold_outlined,
              ),
              label: Text(_isBold ? 'Bold: On' : 'Bold: Off'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FontPreview extends StatelessWidget {
  final String label;
  final TextStyle style;
  final String sample;

  const _FontPreview({
    required this.label,
    required this.style,
    required this.sample,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
        const SizedBox(height: 4),
        Text(sample, style: style, textAlign: TextAlign.center),
      ],
    );
  }
}

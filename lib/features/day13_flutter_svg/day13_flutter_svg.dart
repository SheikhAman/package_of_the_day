import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _accent = Color(0xFF6C5CE7);

// Used small inline SVG strings — rendered with SvgPicture.string
// so the example runs standalone. SvgPicture.asset(...) and
// SvgPicture.network(...) work the same way once you have real files/URLs.

const String _sunSvg = '''
<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <g stroke="#F59E0B" stroke-width="6" stroke-linecap="round">
    <line x1="50" y1="6" x2="50" y2="18"/>
    <line x1="50" y1="82" x2="50" y2="94"/>
    <line x1="6" y1="50" x2="18" y2="50"/>
    <line x1="82" y1="50" x2="94" y2="50"/>
    <line x1="18" y1="18" x2="27" y2="27"/>
    <line x1="73" y1="73" x2="82" y2="82"/>
    <line x1="82" y1="18" x2="73" y2="27"/>
    <line x1="27" y1="73" x2="18" y2="82"/>
  </g>
  <circle cx="50" cy="50" r="22" fill="#F59E0B"/>
</svg>
''';

const String _mountainSvg = '''
<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="72" cy="22" r="10" fill="#FBBF24"/>
  <polygon points="10,85 40,35 60,65 75,45 92,85" fill="#6C5CE7"/>
  <polygon points="40,35 50,50 30,50" fill="#8E7CFF"/>
</svg>
''';

const String _rocketSvg = '''
<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <path d="M50 8 C65 22, 68 45, 60 68 L40 68 C32 45, 35 22, 50 8 Z" fill="#EC4899"/>
  <circle cx="50" cy="34" r="8" fill="#FDE68A"/>
  <polygon points="40,60 26,80 40,74" fill="#F472B6"/>
  <polygon points="60,60 74,80 60,74" fill="#F472B6"/>
  <polygon points="44,68 56,68 50,84" fill="#FB923C"/>
</svg>
''';

class Day13FlutterSvg extends StatelessWidget {
  const Day13FlutterSvg({super.key});

  static const List<Map<String, String>> _samples = [
    {'label': 'Sun', 'svg': _sunSvg},
    {'label': 'Mountains', 'svg': _mountainSvg},
    {'label': 'Rocket', 'svg': _rocketSvg},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 13 · Flutter SVG',
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
                'flutter_svg renders vector graphics with SvgPicture.asset, '
                '.network, or .string — crisp at any size, unlike raster '
                'images.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── SVG gallery ──────────────────────────────────────────
            Expanded(
              child: GridView.builder(
                itemCount: _samples.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  final sample = _samples[index];
                  return _SvgCard(label: sample['label']!, svg: sample['svg']!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SvgCard extends StatelessWidget {
  final String label;
  final String svg;

  const _SvgCard({required this.label, required this.svg});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: SvgPicture.string(svg, fit: BoxFit.contain)),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

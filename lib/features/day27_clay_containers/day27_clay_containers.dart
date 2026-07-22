import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

// Like neumorphism (Day 25), clay containers rely on one shared flat base
// color for the soft light/shadow effect to render correctly, so this
// screen keeps a single base color throughout rather than the series'
// usual white-card-on-light-gray style.
const _baseColor = Color(0xFFE7E4F5);
const _accent = Color(0xFF6C5CE7);

class Day27ClayContainers extends StatelessWidget {
  const Day27ClayContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 27 - Clay Containers',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info card (clay style, not a white card) ────────────
            ClayContainer(
              color: _baseColor,
              borderRadius: 16,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'clay_containers renders soft, moldable "clay" shapes '
                  'using layered shadows — flat, embossed, concave, or '
                  'convex — all from one base color.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Real example: a profile-style card ───────────────────
            const Text(
              'In Practice',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            ClayContainer(
              color: _baseColor,
              borderRadius: 20,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    ClayContainer(
                      color: _baseColor,
                      height: 84,
                      width: 84,
                      borderRadius: 42,
                      curveType: CurveType.concave,
                      child: const Icon(
                        Icons.person_rounded,
                        color: _accent,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClayText(
                      'Ava Thompson',
                      size: 20,
                      textColor: Colors.black87,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Product Designer',
                      style: TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'Curve Types',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // ── Curve type comparison ────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _LabeledClay(label: 'Concave', curveType: CurveType.concave),
                _LabeledClay(label: 'Flat', curveType: CurveType.none),
                _LabeledClay(label: 'Convex', curveType: CurveType.convex),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              'Custom Shapes',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // ── Border radius variety ────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClayContainer(
                  color: _baseColor,
                  height: 80,
                  width: 80,
                  borderRadius: 16,
                ),
                ClayContainer(
                  color: _baseColor,
                  height: 80,
                  width: 80,
                  borderRadius: 40,
                ),
                ClayContainer(
                  color: _baseColor,
                  height: 80,
                  width: 80,
                  customBorderRadius: const BorderRadius.only(
                    topRight: Radius.elliptical(60, 60),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledClay extends StatelessWidget {
  final String label;
  final CurveType curveType;

  const _LabeledClay({required this.label, required this.curveType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClayContainer(
          color: _baseColor,
          height: 70,
          width: 70,
          borderRadius: 35,
          curveType: curveType,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 11.5, color: Colors.black54),
        ),
      ],
    );
  }
}

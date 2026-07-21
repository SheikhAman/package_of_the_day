import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const _accent = Color(0xFF6C5CE7);

class Day20FlutterSpinkit extends StatefulWidget {
  const Day20FlutterSpinkit({super.key});

  @override
  State<Day20FlutterSpinkit> createState() => _Day20FlutterSpinkitState();
}

class _Day20FlutterSpinkitState extends State<Day20FlutterSpinkit> {
  bool _isLoading = false;

  static final List<Map<String, dynamic>> _spinners = [
    {
      'label': 'Rotating Circle',
      'widget': const SpinKitRotatingCircle(color: _accent, size: 36),
    },
    {
      'label': 'Fading Cube',
      'widget': const SpinKitFadingCube(color: _accent, size: 30),
    },
    {
      'label': 'Three Bounce',
      'widget': const SpinKitThreeBounce(color: _accent, size: 24),
    },
    {'label': 'Wave', 'widget': const SpinKitWave(color: _accent, size: 30)},
    {'label': 'Pulse', 'widget': const SpinKitPulse(color: _accent, size: 36)},
    {
      'label': 'Ripple',
      'widget': const SpinKitRipple(color: _accent, size: 40),
    },
    {
      'label': 'Dual Ring',
      'widget': const SpinKitDualRing(color: _accent, size: 36),
    },
    {
      'label': 'Chasing Dots',
      'widget': const SpinKitChasingDots(color: _accent, size: 32),
    },
    {
      'label': 'Circle',
      'widget': const SpinKitCircle(color: _accent, size: 36),
    },
  ];

  Future<void> _simulateLoad() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 20 · Flutter Spinkit',
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
              child: const Text(
                'flutter_spinkit ships 20+ animated loading indicators — a '
                'drop-in upgrade from the default CircularProgressIndicator.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Real usage: a loading button ─────────────────────────
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
            Container(
              padding: const EdgeInsets.all(20),
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
              child: Column(
                children: [
                  const Text(
                    'A button that shows a spinner while "submitting", '
                    'instead of freezing with no feedback.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.black45,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _simulateLoad,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accent,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: _accent.withValues(alpha: 0.6),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 18,
                            )
                          : const Text(
                              'Submit',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Spinner Gallery',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // ── Curated gallery — same accent color for cohesion ────
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _spinners.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final spinner = _spinners[index];
                return _SpinnerTile(
                  label: spinner['label'] as String,
                  spinner: spinner['widget'] as Widget,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SpinnerTile extends StatelessWidget {
  final String label;
  final Widget spinner;

  const _SpinnerTile({required this.label, required this.spinner});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Center(child: spinner)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

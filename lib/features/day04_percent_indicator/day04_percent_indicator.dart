import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

const _accent = Color(0xFF6C5CE7);

class Day04PercentIndicator extends StatefulWidget {
  const Day04PercentIndicator({super.key});

  @override
  State<Day04PercentIndicator> createState() => _Day04PercentIndicatorState();
}

class _Day04PercentIndicatorState extends State<Day04PercentIndicator> {
  double _progress = 0.4;

  final List<Map<String, dynamic>> _stats = const [
    {'label': 'Storage used', 'value': 0.72, 'icon': Icons.storage_rounded},
    {
      'label': 'Battery',
      'value': 0.55,
      'icon': Icons.battery_charging_full_rounded,
    },
    {'label': 'Downloads', 'value': 0.88, 'icon': Icons.download_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 04 · Percent Indicator',
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
                    child: const Icon(
                      Icons.donut_large_rounded,
                      color: _accent,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'percent_indicator draws animated circular and linear '
                      'progress bars, perfect for stats, downloads, and '
                      'onboarding screens.',
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

            const SizedBox(height: 24),

            // ── Interactive circular indicator ──────────────────────
            Container(
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
              child: Column(
                children: [
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 600,
                    radius: 90,
                    lineWidth: 16,
                    percent: _progress,
                    progressColor: _accent,
                    backgroundColor: _accent.withValues(alpha: 0.12),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '${(_progress * 100).round()}%',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.tune_rounded,
                          size: 18,
                          color: Colors.black38,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Slider(
                            value: _progress,
                            activeColor: _accent,
                            onChanged: (value) =>
                                setState(() => _progress = value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Quick Stats',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),

            // ── Linear indicators ───────────────────────────────────
            ...List.generate(_stats.length, (index) {
              final stat = _stats[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == _stats.length - 1 ? 0 : 14,
                ),
                child: _StatBar(
                  icon: stat['icon'] as IconData,
                  label: stat['label'] as String,
                  value: stat['value'] as double,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;

  const _StatBar({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: _accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearPercentIndicator(
            animation: true,
            animationDuration: 700,
            lineHeight: 10,
            percent: value,
            padding: EdgeInsets.zero,
            barRadius: const Radius.circular(8),
            progressColor: _accent,
            backgroundColor: _accent.withValues(alpha: 0.12),
          ),
        ],
      ),
    );
  }
}

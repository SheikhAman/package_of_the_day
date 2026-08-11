import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

const _accent = Color(0xFF6366F1); // Modern Indigo

class Day94FlChart extends StatefulWidget {
  const Day94FlChart({super.key});

  @override
  State<Day94FlChart> createState() => _Day94FlChartState();
}

class _Day94FlChartState extends State<Day94FlChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 94 - fl_chart',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _accent.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Text(
                'fl_chart is the most popular open-source library for data visualization. '
                'It provides smooth animations and full control over chart interaction.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Line Chart Section ────────────────────────────────
            const _ChartLabel(text: 'REVENUE TRENDS (LINE CHART)'),
            _ChartContainer(
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(2, 4),
                        FlSpot(4, 3.5),
                        FlSpot(6, 5),
                        FlSpot(8, 4.2),
                        FlSpot(10, 6),
                      ],
                      isCurved: true,
                      color: _accent,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: _accent.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Bar Chart Section ─────────────────────────────────
            const _ChartLabel(text: 'WEEKLY ACTIVITY (BAR CHART)'),
            _ChartContainer(
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: [
                    _makeGroupData(0, 12, Colors.orange),
                    _makeGroupData(1, 15, Colors.pinkAccent),
                    _makeGroupData(2, 18, _accent),
                    _makeGroupData(3, 14, const Color(0xFF10B981)), // Emerald
                    _makeGroupData(4, 11, Colors.amber),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to create Bar Groups easily
  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}

/// Helper Label Widget
class _ChartLabel extends StatelessWidget {
  final String text;
  const _ChartLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Colors.black38,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

/// Helper Chart Container
class _ChartContainer extends StatelessWidget {
  final Widget child;
  const _ChartContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: child,
    );
  }
}

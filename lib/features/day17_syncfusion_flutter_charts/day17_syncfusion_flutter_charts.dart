import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const _accent = Color(0xFF6C5CE7);

class _BidData {
  final String day;
  final int value;
  const _BidData(this.day, this.value);
}

class Day17SyncfusionFlutterCharts extends StatelessWidget {
  const Day17SyncfusionFlutterCharts({super.key});

  static final List<_BidData> _runningBids = const [
    _BidData('Mon', 2),
    _BidData('Tue', 4),
    _BidData('Wed', 3),
    _BidData('Thu', 6),
    _BidData('Fri', 5),
    _BidData('Sat', 7),
    _BidData('Sun', 5),
  ];

  static final List<_BidData> _completedBids = const [
    _BidData('Mon', 8),
    _BidData('Tue', 12),
    _BidData('Wed', 10),
    _BidData('Thu', 15),
    _BidData('Fri', 18),
    _BidData('Sat', 22),
    _BidData('Sun', 25),
  ];

  static final List<_BidData> _totalAmount = const [
    _BidData('Mon', 4200),
    _BidData('Tue', 6100),
    _BidData('Wed', 5300),
    _BidData('Thu', 8900),
    _BidData('Fri', 10200),
    _BidData('Sat', 13500),
    _BidData('Sun', 15600),
  ];

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat('#,##0', 'en_US');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 17 · Syncfusion Charts',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
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
              'syncfusion_flutter_charts provides production-ready bar, '
              'line, and pie charts with built-in tooltips, legends, and '
              'animation — free for individuals and small businesses.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── Summary stats ─────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.timelapse_rounded,
                  label: 'Running bids',
                  value: '5',
                  color: const Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.check_circle_rounded,
                  label: 'Completed',
                  value: '54',
                  color: const Color(0xFFEC4899),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.payments_rounded,
                  label: 'Total (BDT)',
                  value: currency.format(50230),
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Running bids (bar chart) ─────────────────────────────
          _ChartCard(
            title: 'Running Bids',
            child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_BidData, String>>[
                ColumnSeries<_BidData, String>(
                  dataSource: _runningBids,
                  xValueMapper: (d, _) => d.day,
                  yValueMapper: (d, _) => d.value,
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Completed bids (line chart) ──────────────────────────
          _ChartCard(
            title: 'Completed Bids',
            child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_BidData, String>>[
                LineSeries<_BidData, String>(
                  dataSource: _completedBids,
                  xValueMapper: (d, _) => d.day,
                  yValueMapper: (d, _) => d.value,
                  color: const Color(0xFFEC4899),
                  width: 3,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Total amount (area chart) ────────────────────────────
          _ChartCard(
            title: 'Total Amount (BDT)',
            child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_BidData, String>>[
                AreaSeries<_BidData, String>(
                  dataSource: _totalAmount,
                  xValueMapper: (d, _) => d.day,
                  yValueMapper: (d, _) => d.value,
                  color: const Color(0xFF10B981).withValues(alpha: 0.25),
                  borderColor: const Color(0xFF10B981),
                  borderWidth: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 10.5, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 8),
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(height: 220, child: child),
        ],
      ),
    );
  }
}

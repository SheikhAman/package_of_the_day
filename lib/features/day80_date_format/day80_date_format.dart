import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

const _accent = Color(0xFF6366F1);

class Day80DateFormat extends StatelessWidget {
  const Day80DateFormat({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 80 - Date Format',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Card ──────────────────────────────────────────
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
                'date_format provides a flexible way to convert DateTime '
                'objects into highly readable strings using simple tokens '
                'like [yyyy, mm, dd, HH, nn, ss].',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Raw DateTime display
            _SectionHeader(label: 'RAW DATETIME OBJECT'),
            _FormatResultTile(
              label: 'DateTime.now()',
              value: now.toString(),
              isRaw: true,
            ),

            const SizedBox(height: 16),

            // Date Formats
            _SectionHeader(label: 'DATE FORMATS'),
            _FormatResultTile(
              label: '[yyyy, "-", mm, "-", dd]',
              value: formatDate(now, [yyyy, '-', mm, '-', dd]),
            ),
            _FormatResultTile(
              label: '[D, ", ", M, " ", d, ", ", yyyy]',
              value: formatDate(now, [D, ', ', M, ' ', d, ', ', yyyy]),
            ),

            const SizedBox(height: 16),

            // Time Formats
            _SectionHeader(label: 'TIME FORMATS'),
            _FormatResultTile(
              label: '[HH, ":", nn, ":", ss]',
              value: formatDate(now, [HH, ':', nn, ':', ss]),
            ),
            _FormatResultTile(
              label: '[hh, ":", nn, " ", am]',
              value: formatDate(now, [hh, ':', nn, ' ', am]),
            ),
            _FormatResultTile(
              label: '[HH, ":", nn, ":", ss, " ", z]',
              value: formatDate(now, [HH, ':', nn, ':', ss, ' ', z]),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: Colors.black45,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _FormatResultTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isRaw;

  const _FormatResultTile({
    required this.label,
    required this.value,
    this.isRaw = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isRaw ? Colors.grey[50] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: isRaw ? Colors.black45 : _accent,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

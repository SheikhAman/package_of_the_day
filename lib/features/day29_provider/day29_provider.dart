import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';

const _accent = Color(0xFF6C5CE7);

class Day29Provider extends StatelessWidget {
  const Day29Provider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 29 - Provider',
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
                'provider is a lightweight state-management wrapper around '
                'InheritedWidget. Only the widget that reads the value '
                '(via context.watch) rebuilds — not the whole screen.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            // ── Count display ────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              // Split into its own widget so only this Text rebuilds when
              // the count changes — the info card and buttons above/below
              // don't need to.
              child: const _CountDisplay(),
            ),

            const Spacer(),

            // ── Controls ───────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _CounterButton(
                    icon: Icons.remove_rounded,
                    filled: false,
                    onTap: () => context.read<Counter>().decrement(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CounterButton(
                    icon: Icons.restart_alt_rounded,
                    filled: false,
                    onTap: () => context.read<Counter>().restart(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CounterButton(
                    icon: Icons.add_rounded,
                    filled: true,
                    onTap: () => context.read<Counter>().increment(),
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

// The only widget that watches Counter — keeping this isolated means
// tapping +/- only rebuilds this Text, not the entire _HomePage.
class _CountDisplay extends StatelessWidget {
  const _CountDisplay();

  @override
  Widget build(BuildContext context) {
    final count = context.watch<Counter>().count;
    return Text(
      '$count',
      style: const TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const _CounterButton({
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? _accent : Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: filled
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black12),
                ),
          alignment: Alignment.center,
          child: Icon(icon, color: filled ? Colors.white : Colors.black54),
        ),
      ),
    );
  }
}

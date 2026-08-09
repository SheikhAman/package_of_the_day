import 'package:flutter/material.dart';
import 'package:package_of_the_day/features/day84_rxdart/counter_bloc.dart';

const _accent = Color(0xFF6366F1);

class Day84RxDart extends StatefulWidget {
  const Day84RxDart({super.key});

  @override
  State<Day84RxDart> createState() => _Day84RxDartState();
}

class _Day84RxDartState extends State<Day84RxDart> {
  final _bloc = CounterBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 84 - RxDart BLoC',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // ── Info Card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _accent,
                    child: Icon(Icons.rebase_edit, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'RxDart extends the capabilities of Dart Streams. '
                      'It is the foundation for reactive state management and BLoC patterns.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Reactive Counter Display ───────────────────────────
            StreamBuilder<int>(
              stream: _bloc.counterStream,
              builder: (context, snapshot) {
                final count = snapshot.data ?? 0;
                return Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$count',
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          letterSpacing: -4,
                        ),
                      ),
                      const Text(
                        'STREAM VALUE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: _accent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const Spacer(),

            // ── Controls ───────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _BlocButton(
                    label: 'DECREMENT',
                    icon: Icons.remove_rounded,
                    onPressed: _bloc.decrement,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _BlocButton(
                    label: 'INCREMENT',
                    icon: Icons.add_rounded,
                    onPressed: _bloc.increment,
                    color: Colors.greenAccent.shade700,
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

class _BlocButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const _BlocButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withValues(alpha: 0.2)),
        ),
      ),
    );
  }
}

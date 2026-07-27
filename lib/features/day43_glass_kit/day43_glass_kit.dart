import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class Day43GlassKit extends StatelessWidget {
  const Day43GlassKit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6C5CE7),
                  Color(0xFFEC4899),
                  Color(0xFFF59E0B),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Day 43 · Glass Kit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Frosted-glass panels over a colorful backdrop.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),

                  const SizedBox(height: 24),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final fullWidth = constraints.maxWidth;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _GlassLabel('Clear Glass'),
                          const SizedBox(height: 10),
                          GlassContainer.clearGlass(
                            height: 100,
                            width: fullWidth,
                            borderRadius: BorderRadius.circular(18),
                          ),

                          const SizedBox(height: 24),

                          _GlassLabel('Frosted Glass'),
                          const SizedBox(height: 10),
                          GlassContainer.frostedGlass(
                            height: 100,
                            width: fullWidth,
                            borderRadius: BorderRadius.circular(18),
                          ),

                          const SizedBox(height: 24),

                          _GlassLabel('In Practice'),
                          const SizedBox(height: 10),
                          GlassContainer.frostedGlass(
                            height: 110,
                            width: fullWidth,
                            borderRadius: BorderRadius.circular(18),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: _Stat(
                                    icon: Icons.directions_walk_rounded,
                                    label: 'Steps',
                                    value: '8,214',
                                  ),
                                ),
                                _StatDivider(),
                                Expanded(
                                  child: _Stat(
                                    icon: Icons.local_fire_department_rounded,
                                    label: 'Calories',
                                    value: '412',
                                  ),
                                ),
                                _StatDivider(),
                                Expanded(
                                  child: _Stat(
                                    icon: Icons.map_rounded,
                                    label: 'Distance',
                                    value: '5.2 km',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassLabel extends StatelessWidget {
  final String text;
  const _GlassLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _Stat({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      color: Colors.white.withValues(alpha: 0.25),
    );
  }
}

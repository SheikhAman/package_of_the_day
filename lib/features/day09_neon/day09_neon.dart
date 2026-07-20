import 'package:flutter/material.dart';
import 'package:neon/neon.dart';

class Day09Neon extends StatelessWidget {
  const Day09Neon({super.key});

  static const List<Map<String, dynamic>> _signs = [
    {'text': 'Cyberpunk', 'color': Colors.blue, 'font': NeonFont.Cyberpunk},
    {
      'text': 'Night Club',
      'color': Colors.purple,
      'font': NeonFont.NightClub70s,
    },
    {'text': 'Text Me', 'color': Colors.teal, 'font': NeonFont.TextMeOne},
    {'text': 'Retro', 'color': Colors.green, 'font': NeonFont.Membra},
    {'text': 'Beon', 'color': Colors.red, 'font': NeonFont.Beon},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Day 09 · Neon',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          // ── Info card ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: const Text(
              'neon renders glowing sign-style text with a handful of '
              'built-in retro fonts, colors, and an optional flicker '
              'effect — dark backgrounds make the glow pop.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: Colors.white70,
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ── Neon sign board ──────────────────────────────────────
          ...List.generate(_signs.length, (index) {
            final sign = _signs[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _signs.length - 1 ? 0 : 20,
              ),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
                child: Neon(
                  text: sign['text'],
                  color: sign['color'],
                  fontSize: 34,
                  font: sign['font'],
                  flickeringText: false,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

const _accent = Color(0xFF6366F1); // Modern Indigo

class Day91AnimatedToggleSwitch extends StatefulWidget {
  const Day91AnimatedToggleSwitch({super.key});

  @override
  State<Day91AnimatedToggleSwitch> createState() =>
      _Day91AnimatedToggleSwitchState();
}

class _Day91AnimatedToggleSwitchState extends State<Day91AnimatedToggleSwitch> {
  int _value = 0;
  bool _isNotificationsEnabled = true;
  String _themeMode = 'Auto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 91 - Animated Toggle',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Card (Consistent Branding) ─────────────────────
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
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _accent,
                    child: Icon(Icons.sync_alt_rounded, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'This package provides buttery-smooth animations for switches '
                      'that handle multiple values, not just on/off.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // ── 1. The "Rolling" Toggle (Icon Based) ──────────────
            const _Label(text: 'SMOOTH ROLLING SELECTION'),
            AnimatedToggleSwitch<int>.rolling(
              current: _value,
              values: const [0, 1, 2],
              onChanged: (i) => setState(() => _value = i),
              iconBuilder: (value, size) {
                final icons = [
                  Icons.person_outline_rounded,
                  Icons.group_outlined,
                  Icons.business_outlined,
                ];
                return Icon(
                  icons[value],
                  size: 24,
                  color: _value == value ? Colors.white : Colors.black38,
                );
              },
              style: ToggleStyle(
                backgroundColor: Colors.white,
                indicatorColor: _accent,
                borderColor: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            const SizedBox(height: 32),

            // ── 2. Size Style (Text Pill Based) ───────────────────
            const _Label(text: 'MODERN SEGMENTED STYLE'),
            AnimatedToggleSwitch<String>.size(
              current: _themeMode,
              values: const ['Light', 'Dark', 'Auto'],
              onChanged: (v) => setState(() => _themeMode = v),
              indicatorSize: const Size.fromWidth(100),
              iconBuilder: (value) => Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: _themeMode == value ? Colors.white : Colors.black38,
                ),
              ),
              style: ToggleStyle(
                indicatorColor: Colors.black87,
                backgroundColor: Colors.white,
                borderColor: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            const SizedBox(height: 32),

            // ── 3. Dual/Simple Switch (Action Based) ──────────────
            const _Label(text: 'SWITCH REPLACEMENT'),
            AnimatedToggleSwitch<bool>.dual(
              current: _isNotificationsEnabled,
              first: false,
              second: true,
              onChanged: (b) => setState(() => _isNotificationsEnabled = b),
              spacing: 50.0,
              style: const ToggleStyle(
                borderColor: Colors.transparent,
                indicatorColor: Colors.white,
              ),
              borderWidth: 5.0,
              height: 55,
              styleBuilder: (b) => ToggleStyle(
                backgroundColor: b ? const Color(0xFF10B981) : Colors.redAccent,
              ),
              iconBuilder: (value) => Icon(
                value ? Icons.notifications_active : Icons.notifications_off,
                size: 28,
                color: _isNotificationsEnabled
                    ? const Color(0xFF10B981)
                    : Colors.redAccent,
              ),
              textBuilder: (value) => value
                  ? const Center(
                      child: Text(
                        'ON',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),

            const SizedBox(height: 48),

            // Result Display
            Center(
              child: Text(
                'Current State: persona($_value) • mode($_themeMode)',
                style: const TextStyle(
                  color: Colors.black26,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Private helper widget for organized labels
class _Label extends StatelessWidget {
  final String text;
  const _Label({required this.text});

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

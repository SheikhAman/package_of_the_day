import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Day01AvatarGlow extends StatefulWidget {
  const Day01AvatarGlow({super.key});

  @override
  State<Day01AvatarGlow> createState() => _Day01AvatarGlowState();
}

class _Day01AvatarGlowState extends State<Day01AvatarGlow> {
  bool _isGlowing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day 01 - Avatar Glow')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Info card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color(0xFF4F46E5).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF4F46E5).withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'AvatarGlow adds an animated glowing ring around any widget. '
                'Perfect for profile pictures, live indicators, call buttons, '
                'and active status badges.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, height: 1.6),
              ),
            ),

            const SizedBox(height: 60),

            // ── Example 1: Profile glow ────────────────────────────
            const Text(
              'Profile Avatar',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 13,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            AvatarGlow(
              animate: _isGlowing,
              glowColor: Color(0xFF4F46E5),
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF4F46E5),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 40),
              ),
            ),

            const SizedBox(height: 40),

            // ── Example 2: Live indicator ──────────────────────────
            const Text(
              'Live Indicator',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 13,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            AvatarGlow(
              animate: _isGlowing,
              glowColor: Colors.redAccent,
              duration: const Duration(milliseconds: 1500),
              repeat: true,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── Example 3: Online status ───────────────────────────
            const Text(
              'Online Status',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 13,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            AvatarGlow(
              animate: _isGlowing,
              glowColor: Colors.greenAccent,
              duration: const Duration(milliseconds: 2500),
              repeat: true,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(height: 50),

            // ── Toggle button ──────────────────────────────────────
            ElevatedButton.icon(
              onPressed: () => setState(() => _isGlowing = !_isGlowing),
              icon: Icon(_isGlowing ? Icons.pause : Icons.play_arrow),
              label: Text(_isGlowing ? 'Pause Glow' : 'Resume Glow'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

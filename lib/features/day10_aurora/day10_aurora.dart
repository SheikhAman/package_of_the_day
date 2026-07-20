import 'dart:ui';

import 'package:aurora/aurora.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Day10Aurora extends StatelessWidget {
  const Day10Aurora({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // ── Aurora blobs ─────────────────────────────────────────
            Positioned(
              top: -10,
              left: -100,
              child: Aurora(
                size: 300,
                colors: [
                  const Color(0xffc2e59c).withValues(alpha: 1),
                  const Color(0xff64b3f4).withValues(alpha: 1),
                ],
              ),
            ),
            const Positioned(
              top: -50,
              right: -50,
              child: Aurora(
                size: 200,
                colors: [Color(0xFFfbd07c), Color(0xFFf7f779)],
              ),
            ),
            const Positioned(
              bottom: -100,
              right: -300,
              child: Aurora(
                size: 600,
                colors: [Color(0xFFff0f7b), Color(0xFFf89b29)],
              ),
            ),
            const Positioned(
              bottom: -50,
              left: -100,
              child: Aurora(
                size: 200,
                colors: [Color(0xFF595cff), Color(0xFFc6f8ff)],
              ),
            ),

            // ── Frosted-glass content card on top ───────────────────
            Positioned.fill(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Aurora',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Gradients',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withValues(alpha: 0.7),
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Soft, animated blurred blobs — a quick way '
                              'to give a screen an ambient, colorful backdrop.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                            ),
                            const SizedBox(height: 22),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

const _accent = Color(0xFF6C5CE7);

class Day14FlutterCustomClippers extends StatelessWidget {
  const Day14FlutterCustomClippers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ── Wave header banner ───────────────────────────────────
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_accent, Color(0xFF8E7CFF)],
                ),
              ),
              padding: const EdgeInsets.only(top: 50),
              alignment: Alignment.topCenter,
              child: const Column(
                children: [
                  Text(
                    'Day 14',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Custom Clippers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Info card ──────────────────────────────────────
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
                    'flutter_custom_clippers ships ready-made ClipPath '
                    'shapes — waves, arcs, tickets, diagonals — for '
                    'headers, banners, and cards without hand-drawn paths.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Movie ticket / coupon card ───────────────────────
                const Text(
                  'MovieTicketClipper',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                ClipPath(
                  clipper: MovieTicketClipper(),
                  child: Container(
                    height: 110,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFEC4899), Color(0xFFF472B6)],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.local_movies_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '20% Off Your Order',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Use code WELCOME20 at checkout',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Arc accent banner ────────────────────────────────
                const Text(
                  'ArcClipper',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                ClipPath(
                  clipper: ArcClipper(),
                  child: Container(
                    height: 130,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 24),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF14B8A6), Color(0xFF2DD4BF)],
                      ),
                    ),
                    child: const Text(
                      'Limited Time Offer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ── Oval bottom profile card ─────────────────────────
                const Text(
                  'OvalBottomBorderClipper',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: 130,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF64748B), Color(0xFF94A3B8)],
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Profile Header',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

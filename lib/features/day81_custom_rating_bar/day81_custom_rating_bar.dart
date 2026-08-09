import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

const _accent = Color(0xFF6366F1);
const _bg = Color(0xFFF8FAFC);

class Day81CustomRatingBar extends StatefulWidget {
  const Day81CustomRatingBar({super.key});

  @override
  State<Day81CustomRatingBar> createState() => _Day81CustomRatingBarState();
}

class _Day81CustomRatingBarState extends State<Day81CustomRatingBar> {
  double _userRating = 4.0;

  String _getFeedback(double rating) {
    if (rating >= 5) return 'EXCELLENT!';
    if (rating >= 4) return 'GREAT!';
    if (rating >= 3) return 'GOOD';
    if (rating >= 2) return 'POOR';
    return 'TERRIBLE';
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Rate Your Experience',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'How would you rate our app services?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 32),
            RatingBar(
              alignment: Alignment.center, // Centered in Dialog
              filledIcon: Icons.star_rounded,
              emptyIcon: Icons.star_outline_rounded,
              onRatingChanged: (value) => setState(() => _userRating = value),
              initialRating: _userRating,
              maxRating: 5,
              filledColor: Colors.amber,
              emptyColor: Colors.grey.shade200,
              size: 42,
            ),
            const SizedBox(height: 16),
            Text(
              _getFeedback(_userRating),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                color: _accent,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: const Text('SUBMIT RATING'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        title: const Text(
          'Day 81 - Custom Rating Bar',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // ── Enhanced Info Card ─────────────────────────────────
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
                    child: Icon(Icons.info_outline, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'A modern, lightweight package for elegant star-based feedback.',
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

            const Spacer(),

            // ── Rating Score Display ───────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
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
                    _userRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      letterSpacing: -2,
                    ),
                  ),
                  Text(
                    _getFeedback(_userRating),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: _accent,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // ── Interactive Rating Bar ──────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: RatingBar(
                alignment: Alignment.center, // Centered on main screen
                filledIcon: Icons.star_rounded,
                emptyIcon: Icons.star_outline_rounded,
                onRatingChanged: (value) => setState(() => _userRating = value),
                initialRating: _userRating,
                maxRating: 5,
                filledColor: Colors.amber,
                emptyColor: Colors.grey.shade200,
                size: 44,
              ),
            ),

            const Spacer(),

            // ── Modern Action Button ───────────────────────────────
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: _showRatingDialog,
                icon: const Icon(Icons.rate_review_rounded, size: 20),
                label: const Text('LEAVE A REVIEW'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

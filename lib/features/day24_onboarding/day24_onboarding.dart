import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

const _accent = Color(0xFF6C5CE7);
const _background = Color(0xFFF7F7FB);

class _Slide {
  final IconData icon;
  final String title;
  final String description;
  const _Slide(this.icon, this.title, this.description);
}

const _slides = [
  _Slide(
    Icons.backup_rounded,
    'Secured Backup',
    'Keep your files in a safe place so you never lose them.',
  ),
  _Slide(
    Icons.group_rounded,
    'Share With Ease',
    'Give others access to any file or folder you choose.',
  ),
  _Slide(
    Icons.devices_rounded,
    'Access Anywhere',
    'Reach your files anytime, from any device, anywhere.',
  ),
];

class Day24Onboarding extends StatefulWidget {
  const Day24Onboarding({super.key});

  @override
  State<Day24Onboarding> createState() => _Day24OnboardingState();
}

class _Day24OnboardingState extends State<Day24Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: Onboarding(
        swipeableBody: _slides.map(_SlideView.new).toList(),
        startIndex: 0,
        animationInMilliseconds: 400,
        onPageChanges: (_, __, ___, ____) {},
        buildFooter: (context, drag, total, current, setIndex, direction) {
          final isLast = current == total - 1;

          return DecoratedBox(
            decoration: const BoxDecoration(color: _background),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Indicator<CirclePainter>(
                    painter: CirclePainter(
                      currentPageIndex: current,
                      pagesLength: total,
                      netDragPercent: drag,
                      slideDirection: direction,
                      activePainter: Paint()..color = _accent,
                      inactivePainter: Paint()
                        ..color = _accent.withValues(alpha: 0.2),
                    ),
                  ),
                  _FooterButton(
                    label: isLast ? 'Get Started' : 'Skip',
                    filled: isLast,
                    onTap: () {
                      if (isLast) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Onboarding complete!')),
                        );
                      } else {
                        setIndex(_slides.length - 1);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// A single onboarding page: icon, title, description — centered for a
// cleaner, more symmetrical look.
class _SlideView extends StatelessWidget {
  final _Slide slide;
  const _SlideView(this.slide);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_accent, _accent.withValues(alpha: 0.7)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.25),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Icon(slide.icon, color: Colors.white, size: 52),
            ),
            const SizedBox(height: 40),
            Text(
              slide.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              slide.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _FooterButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? _accent : Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Text(
            label,
            style: TextStyle(
              color: filled ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

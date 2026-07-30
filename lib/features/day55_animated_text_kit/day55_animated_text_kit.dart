import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

const _accent = Color(0xFF6C5CE7);

class Day55AnimatedTextKit extends StatelessWidget {
  const Day55AnimatedTextKit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 55 - Animated Text Kit',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _infoCard(),

          const SizedBox(height: 24),

          _animationCard(
            title: 'Rotate',
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: _accent,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  RotateAnimatedText('Flutter'),
                  RotateAnimatedText('Packages'),
                  RotateAnimatedText('Animations'),
                ],
              ),
            ),
          ),

          _animationCard(
            title: 'Typewriter',
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black87,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Build beautiful Flutter apps.',
                    speed: const Duration(milliseconds: 70),
                  ),
                ],
              ),
            ),
          ),

          _animationCard(
            title: 'Fade',
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: _accent,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FadeAnimatedText('Fast'),
                  FadeAnimatedText('Beautiful'),
                  FadeAnimatedText('Powerful'),
                ],
              ),
            ),
          ),

          _animationCard(
            title: 'Scale',
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: _accent,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ScaleAnimatedText('Think'),
                  ScaleAnimatedText('Build'),
                  ScaleAnimatedText('Ship'),
                ],
              ),
            ),
          ),

          _animationCard(
            title: 'Colorize',
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                ColorizeAnimatedText(
                  'Flutter',
                  textStyle: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: const [
                    Colors.blue,
                    Colors.purple,
                    Colors.orange,
                    Colors.red,
                  ],
                ),
              ],
            ),
          ),

          _animationCard(
            title: 'Wavy',
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 28,
                color: _accent,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  WavyAnimatedText('Hello Flutter 👋'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _infoCard() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .05),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: const Text(
      'animated_text_kit provides beautiful pre-built text animations like Rotate, Fade, Typewriter, Scale, Colorize, and Wavy with just a few lines of code.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        height: 1.6,
        color: Colors.black54,
      ),
    ),
  );
}

Widget _animationCard({
  required String title,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .05),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _accent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 70,
          child: Center(child: child),
        ),
      ],
    ),
  );
}
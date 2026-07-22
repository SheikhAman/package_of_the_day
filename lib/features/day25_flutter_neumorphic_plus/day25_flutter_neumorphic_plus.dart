import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

// Neumorphism needs every element to share one flat base color for the
// embossed light/shadow effect to read correctly, so this screen uses
// flutter_neumorphic's own theming (NeumorphicTheme/NeumorphicBackground)
// instead of the white-card style used elsewhere in this series.

class Day25FlutterNeumorphicPlus extends StatefulWidget {
  const Day25FlutterNeumorphicPlus({super.key});

  @override
  State<Day25FlutterNeumorphicPlus> createState() =>
      _Day25FlutterNeumorphicPlusState();
}

class _Day25FlutterNeumorphicPlusState
    extends State<Day25FlutterNeumorphicPlus> {
  bool _isDark = false;
  double _sliderValue = 4;
  bool _switchOn = false;

  Color get _textColor => _isDark ? Colors.white70 : Colors.black87;

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: const NeumorphicThemeData(
        baseColor: NeumorphicColors.darkBackground,
        accentColor: NeumorphicColors.darkAccent,
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      theme: const NeumorphicThemeData(
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.topLeft,
        depth: 8,
      ),
      child: Scaffold(
        body: NeumorphicBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Header with dark mode toggle ────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Day 25 - Neumorphic',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _textColor,
                        ),
                      ),
                      NeumorphicButton(
                        style: const NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.stadium(),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 14,
                        ),
                        onPressed: () => setState(() => _isDark = !_isDark),
                        child: Icon(
                          _isDark
                              ? Icons.dark_mode_rounded
                              : Icons.light_mode_rounded,
                          size: 18,
                          color: _textColor,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // ── Progress bar ──────────────────────────────────
                  Text(
                    'Progress',
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const NeumorphicProgress(height: 14, percent: 0.55),

                  const SizedBox(height: 32),

                  // ── Button ─────────────────────────────────────────
                  Text(
                    'Button',
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  NeumorphicButton(
                    style: const NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.stadium(),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Press Me',
                      style: TextStyle(color: _textColor),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Slider ─────────────────────────────────────────
                  Text(
                    'Slider',
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicSlider(
                          height: 14,
                          value: _sliderValue,
                          min: 0,
                          max: 10,
                          onChanged: (v) => setState(() => _sliderValue = v),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '${_sliderValue.round()}',
                        style: TextStyle(color: _textColor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ── Switch ─────────────────────────────────────────
                  Row(
                    children: [
                      Text(
                        'Switch',
                        style: TextStyle(
                          color: _textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      NeumorphicSwitch(
                        value: _switchOn,
                        onChanged: (v) => setState(() => _switchOn = v),
                      ),
                    ],
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

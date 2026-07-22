import 'package:flutter/material.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:package_of_the_day/features/day28_day_night_switch/theme/app_theme.dart'
    show AppTheme;

const _accent = Color(0xFF6C5CE7);

class Day28DayNightSwitch extends StatefulWidget {
  const Day28DayNightSwitch({super.key});

  @override
  State<Day28DayNightSwitch> createState() => _Day28DayNightSwitchState();
}

class _Day28DayNightSwitchState extends State<Day28DayNightSwitch> {
  bool _isDark = false;

  void _toggleTheme(bool value) {
    setState(() {
      _isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Day/Night Switch',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Day 28 - Day/Night Switch',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _isDark
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Text(
                    'A StatefulWidget manages the current ThemeMode. '
                    'When the switch changes, setState() rebuilds the '
                    'MaterialApp and the entire app theme updates.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: _isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                DayNightSwitch(
                  value: _isDark,
                  dayColor: _accent,
                  nightColor: const Color(0xFF253341),
                  onChanged: _toggleTheme,
                ),

                const SizedBox(height: 32),

                Text(
                  _isDark ? 'Dark mode is on' : 'Dark mode is off',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

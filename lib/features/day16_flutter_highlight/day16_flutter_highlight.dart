import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark-reasonable.dart';

const _accent = Color(0xFF6C5CE7);

class Day16FlutterHighlight extends StatefulWidget {
  const Day16FlutterHighlight({super.key});

  @override
  State<Day16FlutterHighlight> createState() => _Day16FlutterHighlightState();
}

class _Day16FlutterHighlightState extends State<Day16FlutterHighlight> {
  int _selected = 0;

  static const List<Map<String, String>> _snippets = [
    {'label': 'Dart', 'language': 'dart', 'code': _dartSnippet},
    {'label': 'JSON', 'language': 'json', 'code': _jsonSnippet},
  ];

  static const String _dartSnippet = '''
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() => setState(() => _count++);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _increment,
      child: Text('Count: \$_count'),
    );
  }
}
''';

  static const String _jsonSnippet = '''
{
  "name": "package_of_the_day",
  "day": 16,
  "package": "flutter_highlight",
  "tags": ["syntax", "code", "editor"]
}
''';

  Future<void> _copyToClipboard(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    final current = _snippets[_selected];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 16 · Flutter Highlight',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info card ──────────────────────────────────────────
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
                'flutter_highlight adds syntax-colored code blocks with '
                'themes borrowed from highlight.js — handy for tutorials, '
                'docs, and code-sharing screens.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Language switcher ────────────────────────────────────
            Row(
              children: List.generate(_snippets.length, (index) {
                final isSelected = index == _selected;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(_snippets[index]['label']!),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selected = index),
                    selectedColor: _accent,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : Colors.black12,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),

            // ── Highlighted code card ────────────────────────────────
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: const Color(0xFF282C34),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Text(
                              current['label']!,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.copy_rounded,
                              color: Colors.white54,
                              size: 18,
                            ),
                            onPressed: () => _copyToClipboard(current['code']!),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: HighlightView(
                            current['code']!,
                            language: current['language']!,
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            theme: atomOneDarkReasonableTheme,
                            textStyle: GoogleFonts.firaCode(fontSize: 13.5),
                          ),
                        ),
                      ),
                    ],
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

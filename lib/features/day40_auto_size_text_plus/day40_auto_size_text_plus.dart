import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';

const _accent = Color(0xFF6C5CE7);

class Day40AutoSizeTextPlus extends StatefulWidget {
  const Day40AutoSizeTextPlus({super.key});

  @override
  State<Day40AutoSizeTextPlus> createState() => _Day40AutoSizeTextPlusState();
}

class _Day40AutoSizeTextPlusState extends State<Day40AutoSizeTextPlus> {
  final _textController = TextEditingController(
    text: 'Flutter automatically scales this text\ndown to fit its container!',
  );

  double _maxLines = 2;
  double _containerWidth = 320;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 40 · Auto Size Text',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Info Header ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'auto_size_text_plus scales text to fit inside bounded containers without overflowing. Ideal for responsive screens and dynamic input strings.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Interactive Controls ──────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Interactive Controls',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _textController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: 'Text Content',
                      filled: true,
                      fillColor: const Color(0xFFF7F7FB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text('Max Lines: ${_maxLines.toInt()}'),
                      Expanded(
                        child: Slider(
                          value: _maxLines,
                          min: 1,
                          max: 4,
                          divisions: 3,
                          activeColor: _accent,
                          onChanged: (val) => setState(() => _maxLines = val),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Card Width: ${_containerWidth.toInt()}px'),
                      Expanded(
                        child: Slider(
                          value: _containerWidth,
                          min: 180,
                          max: 360,
                          activeColor: _accent,
                          onChanged: (val) =>
                              setState(() => _containerWidth = val),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Real-Time Comparison Cards ────────────────────────────
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: _containerWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Standard Flutter Text Card (Overflow Bug)
                    _ResultCard(
                      title: 'Standard Text (Clips / Overflows)',
                      accentColor: Colors.redAccent,
                      child: Text(
                        _textController.text,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        maxLines: _maxLines.toInt(),
                        overflow: TextOverflow.clip,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // AutoSizeText Card (Smooth Scale)
                    _ResultCard(
                      title: 'AutoSizeText (Auto Scaled)',
                      accentColor: Colors.green,
                      child: AutoSizeText(
                        _textController.text,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                        maxLines: _maxLines.toInt(),
                        minFontSize: 10,
                        stepGranularity: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // AutoSizeText with Preset Sizes
                    _ResultCard(
                      title: 'AutoSizeText (Preset Sizes: 22, 16, 12)',
                      accentColor: _accent,
                      child: AutoSizeText(
                        _textController.text,
                        presetFontSizes: const [22, 16, 12],
                        maxLines: _maxLines.toInt(),
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Color accentColor;

  const _ResultCard({
    required this.title,
    required this.child,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(height: 60, child: child),
        ],
      ),
    );
  }
}

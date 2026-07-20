import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

const _accent = Color(0xFF6C5CE7);

class Day15FlutterTts extends StatefulWidget {
  const Day15FlutterTts({super.key});

  @override
  State<Day15FlutterTts> createState() => _Day15FlutterTtsState();
}

class _Day15FlutterTtsState extends State<Day15FlutterTts> {
  final FlutterTts _flutterTts = FlutterTts();

  static const String _sampleText =
      'Flutter TTS turns any string of text into spoken audio, right on '
      'the device. Try adjusting the speech rate and pitch below, then '
      'press play to hear the difference.';

  bool _isPlaying = false;
  double _rate = 0.5;
  double _pitch = 1.0;

  @override
  void initState() {
    super.initState();
    _flutterTts.setStartHandler(() => setState(() => _isPlaying = true));
    _flutterTts.setCompletionHandler(() => setState(() => _isPlaying = false));
    _flutterTts.setCancelHandler(() => setState(() => _isPlaying = false));
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleSpeech() async {
    if (_isPlaying) {
      await _flutterTts.stop();
      setState(() => _isPlaying = false);
      return;
    }
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(_rate);
    await _flutterTts.setPitch(_pitch);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.speak(_sampleText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 15 · Flutter TTS',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
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
                'flutter_tts converts text into spoken audio using the '
                'platform\'s built-in speech engine — no server or API key '
                'required.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Sample text card ─────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                _sampleText,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Rate / pitch controls ────────────────────────────────
            Container(
              padding: const EdgeInsets.all(18),
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
                children: [
                  _SliderRow(
                    icon: Icons.speed_rounded,
                    label: 'Speech rate',
                    value: _rate,
                    onChanged: (v) => setState(() => _rate = v),
                  ),
                  const SizedBox(height: 12),
                  _SliderRow(
                    icon: Icons.graphic_eq_rounded,
                    label: 'Pitch',
                    min: 0.5,
                    max: 2.0,
                    value: _pitch,
                    onChanged: (v) => setState(() => _pitch = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Play / stop button ───────────────────────────────────
            Center(
              child: Material(
                color: _accent,
                shape: const CircleBorder(),
                elevation: 4,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _toggleSpeech,
                  child: Container(
                    width: 76,
                    height: 76,
                    alignment: Alignment.center,
                    child: Icon(
                      _isPlaying
                          ? Icons.stop_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36,
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

class _SliderRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: _accent),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: _accent,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

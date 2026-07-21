import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

const _accent = Color(0xFF6C5CE7);

class Day21AudioPlayers extends StatefulWidget {
  const Day21AudioPlayers({super.key});

  @override
  State<Day21AudioPlayers> createState() => _Day21AudioPlayersState();
}

class _Day21AudioPlayersState extends State<Day21AudioPlayers> {
  // The original used AudioCache + local assets (audio file, cover image)
  // that aren't available here, and PlayerMode.LOW_LATENCY / AudioCache
  // are from a much older audioplayers API. audioplayers 6.x plays sources
  // directly off an AudioPlayer instance instead.
  final AudioPlayer _player = AudioPlayer();
  static const String _trackUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  PlayerState _state = PlayerState.stopped;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _state = state);
    });
    _player.onDurationChanged.listen((d) {
      if (mounted) setState(() => _duration = d);
    });
    _player.onPositionChanged.listen((p) {
      if (mounted) setState(() => _position = p);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (_state == PlayerState.playing) {
      await _player.pause();
    } else if (_state == PlayerState.paused) {
      await _player.resume();
    } else {
      await _player.play(UrlSource(_trackUrl));
    }
  }

  String _format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = _state == PlayerState.playing;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 21 · Audioplayers',
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
                'audioplayers plays audio from assets, files, or URLs — '
                'this example streams a sample track from a URL, with a '
                'live progress bar.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            // ── Album art placeholder ────────────────────────────────
            Center(
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_accent, Color(0xFF8E7CFF)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _accent.withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.music_note_rounded,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Sample Track',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'SoundHelix',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black45),
            ),

            const SizedBox(height: 24),

            // ── Progress bar ─────────────────────────────────────────
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              ),
              child: Slider(
                value: _position.inMilliseconds
                    .clamp(
                      0,
                      _duration.inMilliseconds == 0
                          ? 1
                          : _duration.inMilliseconds,
                    )
                    .toDouble(),
                min: 0,
                max: _duration.inMilliseconds == 0
                    ? 1
                    : _duration.inMilliseconds.toDouble(),
                activeColor: _accent,
                inactiveColor: _accent.withValues(alpha: 0.15),
                onChanged: (value) {
                  _player.seek(Duration(milliseconds: value.toInt()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _format(_position),
                    style: const TextStyle(fontSize: 11, color: Colors.black45),
                  ),
                  Text(
                    _format(_duration),
                    style: const TextStyle(fontSize: 11, color: Colors.black45),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Play / pause button ──────────────────────────────────
            Center(
              child: Material(
                color: _accent,
                shape: const CircleBorder(),
                elevation: 4,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _togglePlay,
                  child: Container(
                    width: 72,
                    height: 72,
                    alignment: Alignment.center,
                    child: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

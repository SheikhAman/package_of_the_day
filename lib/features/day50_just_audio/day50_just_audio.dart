import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

const _accent = Color(0xFF6C5CE7);

class Day50JustAudio extends StatefulWidget {
  const Day50JustAudio({super.key});

  @override
  State<Day50JustAudio> createState() => _Day50JustAudioState();
}

class _Day50JustAudioState extends State<Day50JustAudio> {
  final _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  static const _url =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

  @override
  void initState() {
    super.initState();
    _loadAudio();

    // Keep the UI in sync with what the player is actually doing.
    _player.playingStream.listen((playing) {
      setState(() => _isPlaying = playing);
    });
    _player.positionStream.listen((position) {
      setState(() => _position = position);
    });
    _player.durationStream.listen((duration) {
      setState(() => _duration = duration ?? Duration.zero);
    });
  }

  Future<void> _loadAudio() async {
    await _player.setUrl(_url);
  }

  void _togglePlay() {
    _isPlaying ? _player.pause() : _player.play();
  }

  String _format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 50 - Just Audio',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
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
                'just_audio streams and plays audio with full playback '
                'control — play, pause, and seek.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const Spacer(),

            // ── Album art ──────────────────────────────────────────
            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
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
                  Icons.graphic_eq_rounded,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'SoundHelix Track',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 24),

            // ── Progress ───────────────────────────────────────────
            Slider(
              value: _position.inSeconds
                  .clamp(0, _duration.inSeconds == 0 ? 1 : _duration.inSeconds)
                  .toDouble(),
              max: _duration.inSeconds == 0
                  ? 1
                  : _duration.inSeconds.toDouble(),
              activeColor: _accent,
              inactiveColor: _accent.withValues(alpha: 0.15),
              onChanged: (value) =>
                  _player.seek(Duration(seconds: value.toInt())),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _format(_position),
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                  Text(
                    _format(_duration),
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Play / pause button ───────────────────────────────
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
                      _isPlaying
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

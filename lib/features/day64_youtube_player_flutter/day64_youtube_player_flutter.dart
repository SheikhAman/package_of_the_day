import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

const _accent = Color(0xFF6C5CE7);

class Day64YoutubePlayerFlutter extends StatefulWidget {
  const Day64YoutubePlayerFlutter({super.key});

  @override
  State<Day64YoutubePlayerFlutter> createState() =>
      _Day64YoutubePlayerFlutterState();
}

class _Day64YoutubePlayerFlutterState extends State<Day64YoutubePlayerFlutter> {
  static const _videoUrl = 'https://youtu.be/lPWrd08swlw?si=LZSKhXwLIky-RF-3';

  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Extract the video ID from the URL, then create the controller.
    final videoId = YoutubePlayer.convertUrlToId(_videoUrl)!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    // Rebuild the UI whenever the player's state changes
    // (e.g. play/pause, ready, metadata loaded).
    _controller.addListener(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onPlayerStateChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // YoutubePlayerBuilder gives us fullscreen support out of the box.
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: _accent,
        // The player already shows its own loading spinner while it
        // connects — no need to add a second one on top of it.
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Day 64 - YouTube Player',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildInfoCard(),
                const SizedBox(height: 24),

                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: player,
                ),
                const SizedBox(height: 24),

                _buildMetadataCard(),
                const SizedBox(height: 24),

                _buildPlayPauseButton(),
                const SizedBox(height: 12),

                _buildFullscreenButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard() {
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
        'youtube_player_flutter embeds YouTube videos directly inside a '
        'Flutter app with built-in playback controls and fullscreen mode.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, height: 1.6, color: Colors.black54),
      ),
    );
  }

  Widget _buildMetadataCard() {
    final metadata = _controller.metadata;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metadata.title.isEmpty ? 'Loading...' : metadata.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Channel: ${metadata.author}',
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Text(
            'Duration: ${_formatDuration(metadata.duration)}',
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    final isPlaying = _controller.value.isPlaying;

    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: _accent,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () {
        isPlaying ? _controller.pause() : _controller.play();
      },
      icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
      label: Text(isPlaying ? 'Pause' : 'Play'),
    );
  }

  Widget _buildFullscreenButton() {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: _accent,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: _controller.toggleFullScreenMode,
      icon: const Icon(Icons.fullscreen_rounded),
      label: const Text('Fullscreen'),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

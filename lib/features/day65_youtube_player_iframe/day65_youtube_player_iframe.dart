import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

const _accentColor = Color(0xFF6C5CE7);
const _videoUrl = 'https://youtu.be/lPWrd08swlw?si=LZSKhXwLIky-RF-3';

class Day65YoutubePlayerIframe extends StatefulWidget {
  const Day65YoutubePlayerIframe({super.key});

  @override
  State<Day65YoutubePlayerIframe> createState() =>
      _Day65YoutubePlayerIframeState();
}

class _Day65YoutubePlayerIframeState extends State<Day65YoutubePlayerIframe> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(_videoUrl)!,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day 65 - YouTube IFrame')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInfoCard(),
            const SizedBox(height: 24),
            _buildVideoPlayer(),
            const SizedBox(height: 24),
            _buildPlaybackButtons(),
          ],
        ),
      ),
    );
  }

  // A short description card explaining the package.
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
        'youtube_player_iframe embeds the official YouTube IFrame Player '
        'inside your Flutter app, with support for fullscreen playback '
        'and built-in YouTube controls.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, height: 1.6, color: Colors.black54),
      ),
    );
  }

  // The actual video player widget.
  Widget _buildVideoPlayer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: YoutubePlayer(controller: _controller),
      ),
    );
  }

  // Play / Pause / Fullscreen buttons.
  Widget _buildPlaybackButtons() {
    return Column(
      children: [
        _actionButton(
          icon: Icons.play_arrow_rounded,
          label: 'Play',
          onPressed: _controller.playVideo,
        ),
        const SizedBox(height: 12),
        _actionButton(
          icon: Icons.pause_rounded,
          label: 'Pause',
          onPressed: _controller.pauseVideo,
        ),
        const SizedBox(height: 12),
        _actionButton(
          icon: Icons.fullscreen_rounded,
          label: 'Enter Fullscreen',
          onPressed: _controller.enterFullScreen,
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: _accentColor,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

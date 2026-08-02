import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const _accent = Color(0xFF6C5CE7);

class Day58Chewie extends StatefulWidget {
  const Day58Chewie({super.key});

  @override
  State<Day58Chewie> createState() => _Day58ChewieState();
}

class _Day58ChewieState extends State<Day58Chewie> {
  late final VideoPlayerController _videoController;
  late final ChewieController _chewieController;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );

    await _videoController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: false,
      looping: true,
      aspectRatio: 16 / 9,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
      allowMuting: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: _accent,
        handleColor: _accent,
        bufferedColor: Colors.grey.shade300,
        backgroundColor: Colors.grey.shade200,
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoController.dispose();
    super.dispose();
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
        'Chewie is a customizable video player built on top of video_player. It adds play controls, fullscreen mode, playback speed, progress indicators, and a polished Material Design interface.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, height: 1.6, color: Colors.black54),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 58 - Chewie',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _infoCard(),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: _accent),
                      )
                    : Chewie(controller: _chewieController),
              ),
            ),
            const SizedBox(height: 24),
            Container(
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
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.play_circle_outline, color: _accent),
                      SizedBox(width: 12),
                      Expanded(child: Text('Built-in play & pause controls')),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(Icons.fullscreen, color: _accent),
                      SizedBox(width: 12),
                      Expanded(child: Text('Fullscreen support')),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(Icons.speed, color: _accent),
                      SizedBox(width: 12),
                      Expanded(child: Text('Playback speed control')),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(Icons.loop, color: _accent),
                      SizedBox(width: 12),
                      Expanded(child: Text('Loop video playback')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

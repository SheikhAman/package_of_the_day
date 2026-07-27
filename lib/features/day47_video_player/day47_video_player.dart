import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_player_widget.dart';

const _accent = Color(0xFF6C5CE7);

class Day47VideoPlayer extends StatelessWidget {
  const Day47VideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 47 - Video Player',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Playing video from internet URL
            VideoPlayerWidget(
              controller: VideoPlayerController.networkUrl(
                Uri.parse(
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                ),
                videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
              ),
              looping: true,
            ),

            const SizedBox(height: 40),

            /// Playing video from local assets
            ///
            /// Add video file in:
            /// assets/videos/bullfinch.mp4
            ///
            /// Also add it to pubspec.yaml
            VideoPlayerWidget(
              controller: VideoPlayerController.asset(
                'assets/videos/bullfinch.mp4',
                videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
              ),
              looping: true,
              muted: true,
            ),
          ],
        ),
      ),
    );
  }
}

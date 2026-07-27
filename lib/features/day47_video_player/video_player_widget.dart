import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const _accent = Color(0xFF6C5CE7);

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final bool looping;
  final bool muted;

  const VideoPlayerWidget({
    super.key,
    required this.controller,
    this.looping = false,
    this.muted = false,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller;

    initializeVideo();
  }

  Future<void> initializeVideo() async {
    await _controller.setLooping(widget.looping);

    await _controller.setVolume(widget.muted ? 0 : 1);

    await _controller.initialize();

    if (mounted) {
      setState(() {});
    }

    // Auto play after initialization
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator(color: _accent)),
      );
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(_controller),

              /// Custom video controls overlay
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  },

                  child: Container(
                    color: Colors.transparent,

                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, value, child) {
                          if (value.isPlaying) {
                            return const SizedBox();
                          }

                          return const Icon(
                            Icons.play_circle_fill,
                            size: 80,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              /// Video progress bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(playedColor: _accent),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        /// Mute / Unmute button
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, child) {
            final muted = value.volume == 0;

            return CircleAvatar(
              backgroundColor: muted ? Colors.red : Colors.green,

              child: IconButton(
                icon: Icon(
                  muted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),

                onPressed: () {
                  _controller.setVolume(muted ? 1 : 0);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

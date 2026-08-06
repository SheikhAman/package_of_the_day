import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

const _accent = Color(0xFF6C5CE7);

class Day72SharePlus extends StatefulWidget {
  const Day72SharePlus({super.key});

  @override
  State<Day72SharePlus> createState() => _Day72SharePlusState();
}

class _Day72SharePlusState extends State<Day72SharePlus> {
  static const _imageUrl =
      'https://images.unsplash.com/photo-1654099521678-bfb05b565b03?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080';

  bool _isSharing = false;

  Future<void> _shareImage() async {
    setState(() => _isSharing = true);

    try {
      final tempDir = await getTemporaryDirectory();
      final imagePath = '${tempDir.path}/share_image.jpg';

      await Dio().download(_imageUrl, imagePath);

      await SharePlus.instance.share(
        ShareParams(
          text: 'Let\'s explore the world! 🌍',
          files: [XFile(imagePath)],
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to share image.\n$e')));
    }

    if (mounted) {
      setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 72 - Share Plus',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'share_plus makes it easy to share text, images, files, and links using the device\'s native share sheet.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                _imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                minimumSize: const Size(double.infinity, 52),
              ),
              onPressed: _isSharing ? null : _shareImage,
              icon: _isSharing
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.share),
              label: Text(_isSharing ? 'Sharing...' : 'Share Image'),
            ),
          ],
        ),
      ),
    );
  }
}

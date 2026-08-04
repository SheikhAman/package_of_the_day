import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

const _accent = Color(0xFF6C5CE7);

class Day69Gal extends StatelessWidget {
  const Day69Gal({super.key});

  static const String imageUrl =
      'https://images.unsplash.com/photo-1648737963059-59ec8e2d50c5'
      '?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080';

  Future<void> downloadImage(BuildContext context) async {
    try {
      // Get temporary directory
      final directory = await getTemporaryDirectory();

      final imagePath = '${directory.path}/flutter_gallery_image.jpg';

      // Download image
      await Dio().download(imageUrl, imagePath);

      // Save image to gallery
      await Gal.putImage(imagePath);

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Image saved to Gallery')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 69 - Gal Gallery Saver',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),

              child: Image.network(
                imageUrl,

                height: 350,

                width: double.infinity,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                minimumSize: const Size(200, 50),
              ),

              icon: const Icon(Icons.download),

              label: const Text('Save Image'),

              onPressed: () => downloadImage(context),
            ),
          ],
        ),
      ),
    );
  }
}

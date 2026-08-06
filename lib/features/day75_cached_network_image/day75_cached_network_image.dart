import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const _accent = Color(0xFF6C5CE7);

class Day75CachedNetworkImage extends StatefulWidget {
  const Day75CachedNetworkImage({super.key});

  @override
  State<Day75CachedNetworkImage> createState() =>
      _Day75CachedNetworkImageState();
}

class _Day75CachedNetworkImageState extends State<Day75CachedNetworkImage> {
  // Clears every cached image so you can see them re-download on next load.
  Future<void> _clearCache() async {
    await DefaultCacheManager().emptyCache();
    setState(() {}); // rebuild the list so images fetch fresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 75 · Cached Network Image',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // ── Info card ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'cached_network_image downloads an image once and reuses it '
                'from disk after that — scroll away and back, and it loads '
                'instantly instead of re-downloading.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ),
          ),

          // ── Image list ─────────────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: 30,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) => _ImageCard(index: index),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final int index;
  const _ImageCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            // The original loaded source.unsplash.com — that service was
            // fully shut down in mid-2024, so every image would fail to
            // load. picsum.photos is a reliable, currently-working
            // alternative for random placeholder photos.
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/id/${index + 10}/200/200',
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              // No key needed here — the original set `key: UniqueKey()`,
              // which forces Flutter to treat every rebuild as a brand
              // new widget. That defeats the whole point of caching: every
              // time setState() runs (like after clearing the cache), all
              // 30 images would be torn down and rebuilt from scratch
              // instead of reusing what's already loaded.
              placeholder: (context, url) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: _accent,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image_outlined,
                  color: Colors.black38,
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            'Image ${index + 1}',
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

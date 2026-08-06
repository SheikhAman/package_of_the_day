import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const _accent = Color(0xFF6C5CE7);

class Day76FlutterCacheManager extends StatefulWidget {
  const Day76FlutterCacheManager({super.key});

  @override
  State<Day76FlutterCacheManager> createState() =>
      _Day76FlutterCacheManagerState();
}

class _Day76FlutterCacheManagerState extends State<Day76FlutterCacheManager> {
  static final _cacheManager = CacheManager(
    Config(
      'day76CustomCache',
      maxNrOfCacheObjects: 50,
      stalePeriod: const Duration(days: 7),
    ),
  );

  static final List<String> _urls = List.generate(
    8,
    (i) => 'https://picsum.photos/id/${i + 20}/300/300',
  );

  int _reloadToken = 0;

  Future<void> _clearCache() async {
    await _cacheManager.emptyCache();
    setState(() => _reloadToken++); // forces the FutureBuilders to re-fetch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 76 - Flutter Cache Manager',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: _clearCache,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
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
                'flutter_cache_manager downloads and caches any file to '
                'disk with getSingleFile() — the low-level building block '
                'behind image-caching widgets like CachedNetworkImage.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ),
          ),

          // ── Cached file grid ─────────────────────────────────────
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: _urls.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return _CachedTile(
                  key: ValueKey('${_urls[index]}-$_reloadToken'),
                  url: _urls[index],
                  cacheManager: _cacheManager,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CachedTile extends StatelessWidget {
  final String url;
  final CacheManager cacheManager;

  const _CachedTile({super.key, required this.url, required this.cacheManager});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      // getSingleFile() downloads the file on first request and hands
      // back the on-disk File directly on every subsequent call — no
      // network round trip needed until the cache entry goes stale.
      child: FutureBuilder<File>(
        future: cacheManager.getSingleFile(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _accent,
                ),
              ),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Container(
              color: Colors.black12,
              alignment: Alignment.center,
              child: const Icon(
                Icons.broken_image_outlined,
                color: Colors.black38,
              ),
            );
          }
          return Image.file(snapshot.data!, fit: BoxFit.cover);
        },
      ),
    );
  }
}

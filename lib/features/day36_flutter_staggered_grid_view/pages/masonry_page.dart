import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/custom_appbar.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/image_tile.dart';

// ── Masonry ──────────────────────────────────────────────────────────

class MasonryPage extends StatefulWidget {
  const MasonryPage({super.key});

  @override
  State<MasonryPage> createState() => _MasonryPageState();
}

class _MasonryPageState extends State<MasonryPage> {
  final rnd = Random();
  late final List<int> extents = List<int>.generate(
    300,
    (i) => rnd.nextInt(5) + 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Masonry'),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: MasonryGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: extents.length,
          itemBuilder: (context, index) {
            return ImageTile(
              index: index,
              width: 100,
              height: extents[index] * 100,
            );
          },
        ),
      ),
    );
  }
}

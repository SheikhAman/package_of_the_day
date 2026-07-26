import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/custom_appbar.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/image_tile.dart';

// ── Quilted ──────────────────────────────────────────────────────────

class QuiltedPage extends StatelessWidget {
  const QuiltedPage({super.key});

  static const pattern = [
    QuiltedGridTile(2, 2),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Quilted'),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: pattern,
          ),
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            final tile = pattern[index % pattern.length];
            return ImageTile(
              index: index,
              width: tile.crossAxisCount * 100,
              height: tile.mainAxisCount * 100,
            );
          }),
        ),
      ),
    );
  }
}

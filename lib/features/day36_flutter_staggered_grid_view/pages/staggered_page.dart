import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/custom_appbar.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/image_tile.dart';

class StaggeredPage extends StatelessWidget {
  const StaggeredPage({super.key});

  static const tiles = [
    _GridTile(2, 2),
    _GridTile(2, 1),
    _GridTile(1, 2),
    _GridTile(1, 1),
    _GridTile(2, 2),
    _GridTile(1, 2),
    _GridTile(1, 1),
    _GridTile(3, 1),
    _GridTile(1, 1),
    _GridTile(4, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Staggered'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            for (int index = 0; index < tiles.length; index++)
              StaggeredGridTile.count(
                crossAxisCellCount: tiles[index].crossAxisCount,
                mainAxisCellCount: tiles[index].mainAxisCount,
                child: ImageTile(
                  index: index,
                  width: tiles[index].crossAxisCount * 100,
                  height: tiles[index].mainAxisCount * 100,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Staggered ────────────────────────────────────────────────────────

class _GridTile {
  const _GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}

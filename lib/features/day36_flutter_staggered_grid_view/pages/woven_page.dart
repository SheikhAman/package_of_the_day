import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/custom_appbar.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/image_tile.dart';

// ── Woven ────────────────────────────────────────────────────────────

class WovenPage extends StatelessWidget {
  const WovenPage({super.key});

  static const pattern = [
    WovenGridTile(1),
    WovenGridTile(
      5 / 7,
      crossAxisRatio: 0.9,
      alignment: AlignmentDirectional.centerEnd,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Woven'),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            pattern: pattern,
          ),
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            final tile = pattern[index % pattern.length];
            return ImageTile(
              index: index,
              width: (200 * tile.aspectRatio).ceil(),
              height: 200,
            );
          }),
        ),
      ),
    );
  }
}

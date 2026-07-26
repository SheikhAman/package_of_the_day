import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/custom_appbar.dart';
import 'package:package_of_the_day/features/day36_flutter_staggered_grid_view/widgets/image_tile.dart';

class AlignedPage extends StatefulWidget {
  const AlignedPage({super.key});

  @override
  State<AlignedPage> createState() => _AlignedPageState();
}

class _AlignedPageState extends State<AlignedPage> {
  final rnd = Random();
  late final List<int> extents = List<int>.generate(
    300,
    (i) => rnd.nextInt(7) + 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Aligned'),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AlignedGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: extents.length,
          itemBuilder: (context, index) {
            return ImageTile(
              index: index,
              width: 100,
              height: extents[index] * 40,
            );
          },
        ),
      ),
    );
  }
}

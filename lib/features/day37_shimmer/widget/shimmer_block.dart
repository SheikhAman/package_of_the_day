import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBlock extends StatelessWidget {
  final double? width;
  final double height;
  final ShapeBorder shape;

  const ShimmerBlock.rectangular({
    this.width = double.infinity,
    required this.height,
  }) : shape = const RoundedRectangleBorder(
         borderRadius: BorderRadius.all(Radius.circular(4)),
       );

  const ShimmerBlock.circular({required double size})
    : width = size,
      height = size,
      shape = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(color: Colors.grey[300]!, shape: shape),
      ),
    );
  }
}

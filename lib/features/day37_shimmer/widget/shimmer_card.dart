import 'package:flutter/material.dart';
import 'package:package_of_the_day/features/day37_shimmer/widget/shimmer_block.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Row(
        children: [
          ShimmerBlock.circular(size: 56),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBlock.rectangular(height: 15, width: 120),
                SizedBox(height: 8),
                ShimmerBlock.rectangular(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

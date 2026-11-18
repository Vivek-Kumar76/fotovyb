import 'package:flutter/material.dart';
import '../../tokens/tokens.dart';
import 'app_shimmer.dart';
import 'shimmer_primitives.dart';

class HorizontalSectionSkeleton extends StatelessWidget {
  final Widget cardSkeleton;
  final double cardSpacing;
  final int itemCount;

  const HorizontalSectionSkeleton({
    super.key,
    required this.cardSkeleton,
    this.cardSpacing = 16.0,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Standardized Section Header Skeleton (Title + "View All")
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
          child: AppShimmer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerBox(width: 170, height: 20, borderRadius: 6),
                ShimmerBox(width: 55, height: 16, borderRadius: 6),
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.space3),

        // Horizontal Row Skeleton
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
          child: Row(
            children: List.generate(
              itemCount,
              (index) => Padding(
                padding: EdgeInsets.only(
                  right: index == itemCount - 1 ? 0 : cardSpacing,
                ),
                child: cardSkeleton,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
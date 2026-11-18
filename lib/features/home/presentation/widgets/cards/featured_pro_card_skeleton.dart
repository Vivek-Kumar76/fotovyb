import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../../../core/widgets/shimmer/app_shimmer.dart';
import '../../../../../core/widgets/shimmer/shimmer_primitives.dart';

class FeaturedProCardSkeleton extends StatelessWidget {
  const FeaturedProCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return AppShimmer(
      child: Container(
        height: 175,
        margin: const EdgeInsets.only(bottom: AppSpacing.space3),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Image Skeleton (36%)
            const Expanded(
              flex: 36,
              child: ShimmerBox(width: double.infinity, height: double.infinity, borderRadius: 0),
            ),

            // Right Body Skeleton (64%)
            Expanded(
              flex: 64,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        ShimmerBox(width: 85, height: 14, borderRadius: 4),
                        ShimmerCircle(size: 26),
                      ],
                    ),
                    const ShimmerBox(width: 65, height: 11, borderRadius: 4),
                    const ShimmerBox(width: 100, height: 10, borderRadius: 4),
                    Row(
                      children: const [
                        ShimmerBox(width: 45, height: 18, borderRadius: 8),
                        SizedBox(width: 4),
                        ShimmerBox(width: 45, height: 18, borderRadius: 8),
                      ],
                    ),
                    Row(
                      children: const [
                        ShimmerBox(width: 45, height: 10, borderRadius: 4),
                        Spacer(),
                        ShimmerBox(width: 45, height: 26, borderRadius: 13),
                        SizedBox(width: 4),
                        ShimmerBox(width: 60, height: 26, borderRadius: 13),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
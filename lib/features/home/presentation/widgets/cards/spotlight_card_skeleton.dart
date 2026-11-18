import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../../../core/widgets/shimmer/app_shimmer.dart';
import '../../../../../core/widgets/shimmer/shimmer_primitives.dart';

class SpotlightCardSkeleton extends StatelessWidget {
  const SpotlightCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return AppShimmer(
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image Aspect Ratio Skeleton
            const AspectRatio(
              aspectRatio: 1.15,
              child: ShimmerBox(width: double.infinity, height: double.infinity, borderRadius: 0),
            ),

            // Card Body Skeleton
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        ShimmerCircle(size: 24),
                        SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerBox(width: 65, height: 10, borderRadius: 3),
                              SizedBox(height: 3),
                              ShimmerBox(width: 45, height: 8, borderRadius: 3),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        ShimmerBox(width: 45, height: 9, borderRadius: 3),
                        ShimmerBox(width: 25, height: 9, borderRadius: 3),
                      ],
                    ),
                    Row(
                      children: const [
                        ShimmerBox(width: 38, height: 14, borderRadius: 4),
                        SizedBox(width: 4),
                        ShimmerBox(width: 38, height: 14, borderRadius: 4),
                      ],
                    ),
                    const ShimmerBox(width: double.infinity, height: 28, borderRadius: 16),
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
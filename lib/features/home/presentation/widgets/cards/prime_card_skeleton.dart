import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../../../core/widgets/shimmer/app_shimmer.dart';
import '../../../../../core/widgets/shimmer/shimmer_primitives.dart';

class PrimeCardSkeleton extends StatelessWidget {
  const PrimeCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return AppShimmer(
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image 70%
            const Expanded(
              flex: 7,
              child: ShimmerBox(width: double.infinity, height: double.infinity, borderRadius: 0),
            ),
            // Bottom Details 30%
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ShimmerBox(width: 80, height: 10, borderRadius: 3),
                    ShimmerBox(width: 40, height: 9, borderRadius: 3),
                    ShimmerBox(width: 60, height: 12, borderRadius: 4),
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
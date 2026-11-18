import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../../../core/widgets/shimmer/app_shimmer.dart';
import '../../../../../core/widgets/shimmer/shimmer_primitives.dart';

class CreativeProCardSkeleton extends StatelessWidget {
  const CreativeProCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return AppShimmer(
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.space4),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cover Image Area Skeleton (180px)
            const ShimmerBox(
              width: double.infinity,
              height: 180,
              borderRadius: 0,
            ),

            // Card Body Skeleton
            Padding(
              padding: const EdgeInsets.all(AppSpacing.space3 + 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar + Role Row
                  Row(
                    children: const [
                      ShimmerCircle(size: 36),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerBox(width: 120, height: 14, borderRadius: 4),
                            SizedBox(height: 5),
                            ShimmerBox(width: 70, height: 10, borderRadius: 4),
                          ],
                        ),
                      ),
                      ShimmerBox(width: 45, height: 20, borderRadius: 8),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.space3),

                  // Industry Chips Skeleton
                  const ShimmerBox(width: 65, height: 10, borderRadius: 4),
                  const SizedBox(height: AppSpacing.space1),
                  Row(
                    children: const [
                      ShimmerBox(width: 60, height: 22, borderRadius: 6),
                      SizedBox(width: 6),
                      ShimmerBox(width: 55, height: 22, borderRadius: 6),
                      SizedBox(width: 6),
                      ShimmerBox(width: 65, height: 22, borderRadius: 6),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.space2 + 2),

                  // Skills Chips Skeleton
                  const ShimmerBox(width: 65, height: 10, borderRadius: 4),
                  const SizedBox(height: AppSpacing.space1),
                  Row(
                    children: const [
                      ShimmerBox(width: 75, height: 22, borderRadius: 6),
                      SizedBox(width: 6),
                      ShimmerBox(width: 70, height: 22, borderRadius: 6),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.space4),

                  // Action Buttons Skeleton
                  Row(
                    children: const [
                      Expanded(flex: 3, child: ShimmerBox(height: 36, borderRadius: 20)),
                      SizedBox(width: 8),
                      Expanded(flex: 3, child: ShimmerBox(height: 36, borderRadius: 20)),
                      SizedBox(width: 8),
                      ShimmerCircle(size: 36),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
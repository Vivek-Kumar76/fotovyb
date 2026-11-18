import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class RisingStarCardSkeleton extends StatelessWidget {
  const RisingStarCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color baseSkeletonColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);

    return Container(
      width: 144,
      margin: const EdgeInsets.only(right: AppSpacing.space3),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover placeholder
          Container(
            height: 120,
            width: 144,
            decoration: BoxDecoration(
              color: baseSkeletonColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
            ),
          ),

          // Details placeholder
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space2),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: baseSkeletonColor,
                ),
                const SizedBox(width: AppSpacing.space1 + 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: baseSkeletonColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 8,
                        width: 60,
                        decoration: BoxDecoration(
                          color: baseSkeletonColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 7,
                        width: 45,
                        decoration: BoxDecoration(
                          color: baseSkeletonColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
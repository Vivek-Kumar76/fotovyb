import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class HighPriorityGigCardSkeleton extends StatelessWidget {
  final double width;
  final EdgeInsetsGeometry? margin;

  const HighPriorityGigCardSkeleton({
    super.key,
    this.width = 330,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color baseColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
    final Color highlightColor = isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1);
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Container(
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: AppRadius.radiusXl,
        border: Border.all(color: borderColor),
        boxShadow: isDark ? null : AppShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Media Thumbnail placeholder
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl - 1)),
            ),
          ),

          // Body placeholders
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space3 + 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Seller row
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: highlightColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space2 + 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 12,
                          decoration: BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 70,
                          height: 9,
                          decoration: BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 35,
                      height: 14,
                      decoration: BoxDecoration(
                        color: highlightColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space3),

                // Title lines
                Container(
                  width: double.infinity,
                  height: 14,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 200,
                  height: 14,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: AppSpacing.space3),

                // Tags placeholder
                Row(
                  children: List.generate(
                    3,
                    (idx) => Container(
                      width: 65,
                      height: 20,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: AppRadius.radiusFull,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.space3),

                // Metadata row
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 11,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 70,
                      height: 11,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space3 + 2),

                // Package tiers boxes
                Row(
                  children: List.generate(
                    3,
                    (idx) => Expanded(
                      child: Container(
                        height: 44,
                        margin: EdgeInsets.only(right: idx < 2 ? 8 : 0),
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: AppRadius.radiusMd,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.space3 + 2),

                // Buttons row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: AppRadius.radiusFull,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: baseColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
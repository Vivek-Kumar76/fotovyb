import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class FeaturedGigCardSkeleton extends StatelessWidget {
  final double width;
  final EdgeInsetsGeometry? margin;

  const FeaturedGigCardSkeleton({
    super.key,
    this.width = 240,
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
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadius.xl - 1),
              ),
            ),
          ),

          // Bottom Details placeholder
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space3,
              vertical: AppSpacing.space3,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 9,
                      decoration: BoxDecoration(
                        color: highlightColor,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 55,
                      height: 14,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.space2),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: highlightColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 45,
                        height: 9,
                        decoration: BoxDecoration(
                          color: highlightColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 58,
                  height: 28,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: AppRadius.radiusFull,
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
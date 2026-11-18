import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class ProMasterGigCardSkeleton extends StatelessWidget {
  final double? width;
  final EdgeInsetsGeometry? margin;

  const ProMasterGigCardSkeleton({
    super.key,
    this.width,
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
      height: 160,
      margin: margin,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: AppRadius.radiusXl,
        border: Border.all(color: borderColor),
        boxShadow: isDark ? null : AppShadows.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: Media thumbnail placeholder
          Container(
            width: 136,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(AppRadius.xl - 1),
              ),
            ),
          ),

          // Right: Content placeholders
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space3,
                vertical: AppSpacing.space2 + 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Headline lines
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 12,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 120,
                        height: 12,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),

                  // Seller row placeholder
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: highlightColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 70,
                        height: 10,
                        decoration: BoxDecoration(
                          color: highlightColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 28,
                        height: 10,
                        decoration: BoxDecoration(
                          color: highlightColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ],
                  ),

                  // Tag chips placeholder
                  Row(
                    children: List.generate(
                      3,
                      (idx) => Container(
                        width: 44,
                        height: 18,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: AppRadius.radiusFull,
                        ),
                      ),
                    ),
                  ),

                  // Delivery / Orders metadata placeholder
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 9,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 50,
                        height: 9,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ],
                  ),

                  // Price and View button placeholder
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 65,
                        height: 16,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Container(
                        width: 78,
                        height: 28,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: AppRadius.radiusFull,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
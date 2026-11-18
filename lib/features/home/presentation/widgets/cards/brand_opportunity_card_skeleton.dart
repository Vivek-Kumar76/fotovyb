import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class BrandOpportunityCardSkeleton extends StatelessWidget {
  final double width;
  final EdgeInsetsGeometry? margin;

  const BrandOpportunityCardSkeleton({
    super.key,
    this.width = 320,
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
        borderRadius: AppRadius.radiusLg,
        border: Border.all(color: borderColor),
        boxShadow: isDark ? null : AppShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header Placeholder (Logo, Brand Title, Badge, Days Left)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space3,
              vertical: AppSpacing.space2,
            ),
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg - 1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.space2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 85,
                      height: 10,
                      decoration: BoxDecoration(
                        color: highlightColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 55,
                      height: 8,
                      decoration: BoxDecoration(
                        color: highlightColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 65,
                  height: 18,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: AppRadius.radiusSm,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  width: 55,
                  height: 18,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: AppRadius.radiusSm,
                  ),
                ),
              ],
            ),
          ),

          // ── Body Placeholder (Title, Description, Skills, Budget & Actions)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title line
                Container(
                  width: double.infinity,
                  height: 14,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: AppSpacing.space2),

                // Description lines
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 190,
                  height: 10,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: AppSpacing.space3),

                // Looking For + Budget
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 75,
                            height: 8,
                            decoration: BoxDecoration(
                              color: baseColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: baseColor,
                                  borderRadius: AppRadius.radiusSm,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 55,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: baseColor,
                                  borderRadius: AppRadius.radiusSm,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 16,
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space3 + 2),

                // Action Buttons (Apply & Save)
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 33,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: AppRadius.radiusFull,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 33,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: AppRadius.radiusFull,
                        ),
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
import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class GigFeaturedCardSkeleton extends StatelessWidget {
  const GigFeaturedCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xFFE2E8F0);
    final shimmerTone = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFE2E8F0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;
        final coverH = cardW * 0.54;
        final radius = cardW * 0.055;

        return Container(
          width: cardW,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: cardW,
                height: coverH,
                color: shimmerTone,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: cardW * 0.038,
                  vertical: cardW * 0.034,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: cardW * 0.12,
                          height: cardW * 0.026,
                          decoration: BoxDecoration(
                            color: shimmerTone,
                            borderRadius: BorderRadius.circular(cardW * 0.012),
                          ),
                        ),
                        SizedBox(height: cardW * 0.012),
                        Container(
                          width: cardW * 0.24,
                          height: cardW * 0.04,
                          decoration: BoxDecoration(
                            color: shimmerTone,
                            borderRadius: BorderRadius.circular(cardW * 0.015),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: cardW * 0.2,
                      height: cardW * 0.088,
                      decoration: BoxDecoration(
                        color: shimmerTone,
                        borderRadius: BorderRadius.circular(cardW * 0.05),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
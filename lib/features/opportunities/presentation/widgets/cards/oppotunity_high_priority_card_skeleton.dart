import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class OpportunityHighPriorityCardSkeleton extends StatelessWidget {
  const OpportunityHighPriorityCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseBg = isDark ? AppColors.surfaceDark : const Color(0xffE2E8F0);
    final shimmerTone = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xffCBD5E1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;
        final cardH = cardW * 0.86;

        return Container(
          width: cardW,
          height: cardH,
          decoration: BoxDecoration(
            color: baseBg,
            borderRadius: BorderRadius.circular(cardW * 0.062),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Top-right badge placeholder
              Positioned(
                top: cardH * 0.045,
                right: cardW * 0.04,
                child: Container(
                  width: cardW * 0.2,
                  height: cardH * 0.065,
                  decoration: BoxDecoration(
                    color: shimmerTone,
                    borderRadius: BorderRadius.circular(cardW * 0.045),
                  ),
                ),
              ),

              // Bottom content placeholders
              Positioned(
                left: cardW * 0.045,
                right: cardW * 0.045,
                bottom: cardH * 0.052,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: cardW * 0.78,
                      height: cardH * 0.052,
                      decoration: BoxDecoration(
                        color: shimmerTone,
                        borderRadius: BorderRadius.circular(cardW * 0.02),
                      ),
                    ),
                    SizedBox(height: cardH * 0.018),
                    Container(
                      width: cardW * 0.52,
                      height: cardH * 0.048,
                      decoration: BoxDecoration(
                        color: shimmerTone,
                        borderRadius: BorderRadius.circular(cardW * 0.02),
                      ),
                    ),
                    SizedBox(height: cardH * 0.028),
                    Container(
                      width: cardW * 0.42,
                      height: cardH * 0.036,
                      decoration: BoxDecoration(
                        color: shimmerTone,
                        borderRadius: BorderRadius.circular(cardW * 0.02),
                      ),
                    ),
                    SizedBox(height: cardH * 0.028),
                    Row(
                      children: [
                        Container(
                          width: cardW * 0.22,
                          height: cardH * 0.055,
                          decoration: BoxDecoration(
                            color: shimmerTone,
                            borderRadius: BorderRadius.circular(cardW * 0.04),
                          ),
                        ),
                        SizedBox(width: cardW * 0.02),
                        Container(
                          width: cardW * 0.18,
                          height: cardH * 0.055,
                          decoration: BoxDecoration(
                            color: shimmerTone,
                            borderRadius: BorderRadius.circular(cardW * 0.04),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cardH * 0.042),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: cardW * 0.26,
                          height: cardH * 0.068,
                          decoration: BoxDecoration(
                            color: shimmerTone,
                            borderRadius: BorderRadius.circular(cardW * 0.02),
                          ),
                        ),
                        Container(
                          width: cardW * 0.28,
                          height: cardH * 0.095,
                          decoration: BoxDecoration(
                            color: shimmerTone,
                            borderRadius: BorderRadius.circular(cardW * 0.056),
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
      },
    );
  }
}
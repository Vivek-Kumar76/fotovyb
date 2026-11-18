import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class GigProMasterCardSkeleton extends StatelessWidget {
  const GigProMasterCardSkeleton({super.key});

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
        final cardH = cardW * 0.44;
        final radius = cardW * 0.052;

        return Container(
          width: cardW,
          height: cardH,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 36,
                child: Container(color: shimmerTone),
              ),
              Expanded(
                flex: 64,
                child: Padding(
                  padding: EdgeInsets.all(cardW * 0.032),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: cardW * 0.48,
                            height: cardH * 0.095,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.015),
                            ),
                          ),
                          SizedBox(height: cardH * 0.055),
                          Container(
                            width: cardW * 0.34,
                            height: cardH * 0.075,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.015),
                            ),
                          ),
                          SizedBox(height: cardH * 0.055),
                          Container(
                            width: cardW * 0.4,
                            height: cardH * 0.07,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.015),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: cardW * 0.18,
                            height: cardH * 0.11,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.015),
                            ),
                          ),
                          Container(
                            width: cardW * 0.22,
                            height: cardH * 0.19,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.05),
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
      },
    );
  }
}
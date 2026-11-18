import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class OpportunityBoostedCardSkeleton extends StatelessWidget {
  const OpportunityBoostedCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final shimmerTone = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xffE2E8F0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;
        final cardH = cardW * 0.39;

        return Container(
          width: cardW,
          height: cardH,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(cardW * 0.05),
            border: Border.all(color: borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 31,
                child: Container(color: shimmerTone),
              ),
              Expanded(
                flex: 69,
                child: Padding(
                  padding: EdgeInsets.all(cardW * 0.034),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: cardW * 0.22,
                            height: cardH * 0.07,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.015),
                            ),
                          ),
                          SizedBox(height: cardH * 0.045),
                          Container(
                            width: cardW * 0.54,
                            height: cardH * 0.095,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.015),
                            ),
                          ),
                          SizedBox(height: cardH * 0.045),
                          Container(
                            width: cardW * 0.42,
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
                            width: cardW * 0.2,
                            height: cardH * 0.11,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.015),
                            ),
                          ),
                          Container(
                            width: cardW * 0.21,
                            height: cardH * 0.19,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius: BorderRadius.circular(cardW * 0.05),
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
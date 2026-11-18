import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class GigNewCardSkeleton extends StatelessWidget {
  const GigNewCardSkeleton({super.key});

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
        final coverH = cardW * 0.52;
        final radius = cardW * 0.056;

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
                padding: EdgeInsets.all(cardW * 0.042),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: cardW * 0.046,
                          backgroundColor: shimmerTone,
                        ),
                        SizedBox(width: cardW * 0.028),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: cardW * 0.32,
                                height: cardW * 0.034,
                                decoration: BoxDecoration(
                                  color: shimmerTone,
                                  borderRadius:
                                      BorderRadius.circular(cardW * 0.015),
                                ),
                              ),
                              SizedBox(height: cardW * 0.014),
                              Container(
                                width: cardW * 0.42,
                                height: cardW * 0.026,
                                decoration: BoxDecoration(
                                  color: shimmerTone,
                                  borderRadius:
                                      BorderRadius.circular(cardW * 0.015),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cardW * 0.034),
                    Container(
                      width: cardW * 0.74,
                      height: cardW * 0.04,
                      decoration: BoxDecoration(
                        color: shimmerTone,
                        borderRadius: BorderRadius.circular(cardW * 0.015),
                      ),
                    ),
                    SizedBox(height: cardW * 0.018),
                    Container(
                      width: cardW * 0.5,
                      height: cardW * 0.04,
                      decoration: BoxDecoration(
                        color: shimmerTone,
                        borderRadius: BorderRadius.circular(cardW * 0.015),
                      ),
                    ),
                    SizedBox(height: cardW * 0.036),
                    Row(
                      children: List.generate(3, (idx) {
                        return Expanded(
                          child: Container(
                            height: cardW * 0.13,
                            margin: EdgeInsets.only(
                                right: idx < 2 ? cardW * 0.022 : 0),
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.048),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: cardW * 0.036),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: cardW * 0.118,
                            decoration: BoxDecoration(
                              color: shimmerTone,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.064),
                            ),
                          ),
                        ),
                        SizedBox(width: cardW * 0.026),
                        CircleAvatar(
                          radius: cardW * 0.059,
                          backgroundColor: shimmerTone,
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
import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';

class OpportunityFeaturedCardSkeleton extends StatelessWidget {
  const OpportunityFeaturedCardSkeleton({super.key});

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
            : screenWidth * 0.44;

        return Container(
          width: cardW,
          padding: EdgeInsets.all(cardW * 0.072),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(cardW * 0.11),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: cardW * 0.09,
                    backgroundColor: shimmerTone,
                  ),
                  SizedBox(height: cardW * 0.055),
                  Container(
                    width: cardW * 0.78,
                    height: cardW * 0.078,
                    decoration: BoxDecoration(
                      color: shimmerTone,
                      borderRadius: BorderRadius.circular(cardW * 0.025),
                    ),
                  ),
                  SizedBox(height: cardW * 0.025),
                  Container(
                    width: cardW * 0.56,
                    height: cardW * 0.078,
                    decoration: BoxDecoration(
                      color: shimmerTone,
                      borderRadius: BorderRadius.circular(cardW * 0.025),
                    ),
                  ),
                  SizedBox(height: cardW * 0.045),
                  Container(
                    width: cardW * 0.48,
                    height: cardW * 0.058,
                    decoration: BoxDecoration(
                      color: shimmerTone,
                      borderRadius: BorderRadius.circular(cardW * 0.025),
                    ),
                  ),
                  SizedBox(height: cardW * 0.05),
                  Row(
                    children: [
                      Container(
                        width: cardW * 0.36,
                        height: cardW * 0.085,
                        decoration: BoxDecoration(
                          color: shimmerTone,
                          borderRadius: BorderRadius.circular(cardW * 0.06),
                        ),
                      ),
                      SizedBox(width: cardW * 0.03),
                      Container(
                        width: cardW * 0.28,
                        height: cardW * 0.085,
                        decoration: BoxDecoration(
                          color: shimmerTone,
                          borderRadius: BorderRadius.circular(cardW * 0.06),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: cardW * 0.07),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: cardW * 0.34,
                    height: cardW * 0.09,
                    decoration: BoxDecoration(
                      color: shimmerTone,
                      borderRadius: BorderRadius.circular(cardW * 0.025),
                    ),
                  ),
                  Container(
                    width: cardW * 0.32,
                    height: cardW * 0.145,
                    decoration: BoxDecoration(
                      color: shimmerTone,
                      borderRadius: BorderRadius.circular(cardW * 0.095),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
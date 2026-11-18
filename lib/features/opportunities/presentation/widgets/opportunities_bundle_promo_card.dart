import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class OpportunitiesBundlePromoCard extends StatelessWidget {
  final VoidCallback onViewPackagesTap;

  const OpportunitiesBundlePromoCard({
    super.key,
    required this.onViewPackagesTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final hPad = screenW * 0.04;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenW * 0.04),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xff0F2430)
                  : const Color(0xffF0FDFA),
              borderRadius: BorderRadius.circular(screenW * 0.045),
              border: Border.all(
                color: const Color(0xff0D9488).withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Need Multiple Services? Get 20% Off",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: screenW * 0.035,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: screenW * 0.01),
                      Text(
                        "Bundle photography, videography & styling services for discounts",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: screenW * 0.028,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenW * 0.025),
                GestureDetector(
                  onTap: onViewPackagesTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenW * 0.036,
                      vertical: screenW * 0.022,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff0D9488),
                      borderRadius: BorderRadius.circular(screenW * 0.05),
                    ),
                    child: Text(
                      "View Packages",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: screenW * 0.03,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
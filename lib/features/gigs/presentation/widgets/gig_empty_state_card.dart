import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigEmptyStateCard extends StatelessWidget {
  final String message;
  final Color accentColor;
  final IconData icon;
  final VoidCallback? onResetFilters;

  const GigEmptyStateCard({
    super.key,
    required this.message,
    required this.accentColor,
    required this.icon,
    this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final maxW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;

        return Container(
          width: maxW,
          padding: EdgeInsets.symmetric(
            horizontal: maxW * 0.045,
            vertical: maxW * 0.052,
          ),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(maxW * 0.05),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(maxW * 0.026),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: maxW * 0.052,
                  color: accentColor,
                ),
              ),
              SizedBox(width: maxW * 0.032),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: maxW * 0.033,
                    fontWeight: FontWeight.w600,
                    color: textSecondary,
                  ),
                ),
              ),
              if (onResetFilters != null) ...[
                SizedBox(width: maxW * 0.025),
                GestureDetector(
                  onTap: onResetFilters,
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: maxW * 0.032,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff0D9488),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../../shared/widgets/primary_gradient_button.dart';

class GigStickyBottomBar extends StatelessWidget {
  final String packageName;
  final String packagePrice;
  final VoidCallback onChoosePackageTap;
  final VoidCallback onContactSellerTap;

  const GigStickyBottomBar({
    super.key,
    required this.packageName,
    required this.packagePrice,
    required this.onChoosePackageTap,
    required this.onContactSellerTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border(top: BorderSide(color: borderColor, width: 1)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              // Price Label
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$packageName Tier",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: textSecondary,
                      ),
                    ),
                    Text(
                      packagePrice,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Contact Button (Icon)
              IconButton(
                style: IconButton.styleFrom(
                  side: BorderSide(color: borderColor),
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                ),
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
                onPressed: onContactSellerTap,
              ),

              const SizedBox(width: 8),

              // Action CTA Button
              Expanded(
                flex: 6,
                child: PrimaryGradientButton(
                  label: "Choose Package",
                  onPressed: onChoosePackageTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:p1/core/tokens/tokens.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color cardBg = isSelected
        ? (isDark ? AppColors.selectionCardSelectedBgDark : AppColors.selectionCardSelectedBgLight)
        : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);

    final Color borderColor = isSelected
        ? (isDark ? AppColors.selectionCardSelectedBorderDark : AppColors.selectionCardSelectedBorderLight)
        : (isDark ? AppColors.borderDark : AppColors.borderLight);

    final Color iconBg = isSelected
        ? AppColors.primary
        : (isDark ? AppColors.surfaceSecondaryDark : AppColors.selectionCardIconDefaultBgLight);

    final Color iconColor = isSelected ? Colors.white : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    final Color titleColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        padding: const EdgeInsets.all(AppSpacing.space4),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(
            color: borderColor,
            width: isSelected ? 1.8 : 1.0,
          ),
          boxShadow: isSelected && !isDark ? AppShadows.sm : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: AppRadius.radiusMd,
              ),
              child: Icon(icon, size: 22, color: iconColor),
            ),
            const SizedBox(width: AppSpacing.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeMd,
                          fontWeight: AppTypography.bold,
                          color: titleColor,
                        ),
                      ),
                      AnimatedContainer(
                        duration: AppAnimations.fast,
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppColors.primary : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderStrongLight),
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, size: 13, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs,
                      color: subtitleColor,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
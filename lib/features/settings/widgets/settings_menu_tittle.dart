import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class SettingsMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? iconColor;

  const SettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.showDivider = true,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : const Color(0xff94A3B8);
    final Color dividerColor = isDark ? AppColors.borderDark : const Color(0xffF1F5F9);
    final Color effectiveIconColor = iconColor ?? const Color(0xff0D9488);

    return InkWell(
      onTap: onTap,
      splashColor: const Color(0xff0D9488).withValues(alpha: 0.08),
      highlightColor: const Color(0xff0D9488).withValues(alpha: 0.04),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: effectiveIconColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 11.5,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Color(0xff94A3B8),
                ),
              ],
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              indent: 18,
              endIndent: 0,
              color: dividerColor,
            ),
        ],
      ),
    );
  }
}
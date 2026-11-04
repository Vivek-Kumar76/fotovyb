import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProfileStickyBottomBar extends StatelessWidget {
  final String priceText;
  final VoidCallback onBookSession;
  final VoidCallback onChatTap;

  const ProfileStickyBottomBar({
    super.key,
    required this.priceText,
    required this.onBookSession,
    required this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding > 0 ? bottomPadding + 4 : 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Price Info
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "From",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 11,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
              Text(
                priceText,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Primary Book CTA Button (Creative Gradient)
          Expanded(
            child: GestureDetector(
              onTap: onBookSession,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.buttonGradientCreative,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_outlined, color: Colors.white, size: 17),
                    SizedBox(width: 8),
                    Text(
                      "Book a Session",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Circular Chat Button
          GestureDetector(
            onTap: onChatTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? AppColors.surfaceSecondaryDark : Colors.white,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : const Color(0xffE2E8F0),
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
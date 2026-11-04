import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class SubscriptionActiveCard extends StatelessWidget {
  final String activePlanName;

  const SubscriptionActiveCard({
    super.key,
    required this.activePlanName,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final textColor = isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xffE6F4F1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.verified_user_rounded,
                color: Color(0xff0D9488),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Creative Professional Track",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Current active plan: $activePlanName",
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 11,
                      color: Color(0xff64748B),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xff10B981).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xff10B981).withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                children: [
                  CircleAvatar(radius: 3, backgroundColor: Color(0xff10B981)),
                  SizedBox(width: 4),
                  Text(
                    "ACTIVE",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff059669),
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
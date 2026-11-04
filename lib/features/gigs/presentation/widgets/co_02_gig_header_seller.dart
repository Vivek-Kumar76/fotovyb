import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigHeaderSeller extends StatelessWidget {
  const GigHeaderSeller({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space5, vertical: AppSpacing.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xffF59E0B).withValues(alpha: 0.15),
              borderRadius: AppRadius.radiusFull,
              border: Border.all(color: const Color(0xffF59E0B).withValues(alpha: 0.3)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, size: 14, color: Color(0xffD97706)),
                SizedBox(width: 4),
                Text(
                  "Featured GIG",
                  style: TextStyle(
                    color: Color(0xffD97706),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Title
          Text(
            "Cinematic Fashion & Editorial Photography",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: textColor,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            "Professional cinematic fashion & editorial photography with complete styling guidance and post-production.",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm,
              color: textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),

          // Seller Profile Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Kofi Mensah",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "PRO",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Bangalore · 142 orders completed",
                        style: TextStyle(fontSize: 11, color: textSecondary),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 14, color: Color(0xffF59E0B)),
                          const SizedBox(width: 3),
                          Text(
                            "4.9",
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor),
                          ),
                          Text(
                            " (96 reviews) · 98% Success",
                            style: TextStyle(fontSize: 11, color: textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    minimumSize: Size.zero,
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Profile",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
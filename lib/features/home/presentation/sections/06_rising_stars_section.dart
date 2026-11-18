import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/creative_pro_model.dart';
import '../widgets/cards/rising_star_card.dart';


class RisingStarsSection extends StatelessWidget {
  final List<CreativeProModel> stars;
  final bool isLoading;
  final VoidCallback? onSeeAllTap;
  final Function(CreativeProModel star)? onStarTap;

  const RisingStarsSection({
    super.key,
    required this.stars,
    this.isLoading = false,
    this.onSeeAllTap,
    this.onStarTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    if (isLoading && stars.isEmpty) {
      return _buildSkeleton(context, isDark);
    }

    if (stars.isEmpty) {
      return const SizedBox.shrink();
    }

    // Strictly limit to 6 cards on the home page
    final displayStars = stars.take(6).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rising Stars",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeLg,
                      fontWeight: AppTypography.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "New talent gaining momentum -- book them early",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onSeeAllTap,
                child: Row(
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        fontWeight: AppTypography.semibold,
                        color: activeColor,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(Icons.chevron_right_rounded, size: 16, color: activeColor),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space3),

        // 6-Card Horizontal Carousel
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
            itemCount: displayStars.length,
            itemBuilder: (ctx, idx) {
              final star = displayStars[idx];
              return Container(
                width: 144,
                margin: const EdgeInsets.only(right: AppSpacing.space3),
                child: RisingStarCard(
                  star: star,
                  onTap: () => onStarTap?.call(star),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSkeleton(BuildContext context, bool isDark) {
    final Color baseColor = isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
          child: Container(
            width: 140,
            height: 18,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space3),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
            itemCount: 6,
            itemBuilder: (ctx, idx) => Container(
              width: 144,
              margin: const EdgeInsets.only(right: AppSpacing.space3),
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: AppRadius.radiusLg,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
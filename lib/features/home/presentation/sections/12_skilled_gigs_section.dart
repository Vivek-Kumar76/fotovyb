import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class SkilledGigsSection extends StatelessWidget {
  final VoidCallback? onExploreTap;
  final Function(Map<String, dynamic> category)? onCategoryTap;

  const SkilledGigsSection({
    super.key,
    this.onExploreTap,
    this.onCategoryTap,
  });

  // Skilled Gigs & Shoot Opportunities Categories Data
  final List<Map<String, dynamic>> categories = const [
    {
      "id": "skill_cat_1",
      "title": "Photographer",
      "count": "24 Opportunities",
      "image": "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500",
    },
    {
      "id": "skill_cat_2",
      "title": "Fashion Stylist",
      "count": "18 active briefs",
      "image": "https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500",
    },
    {
      "id": "skill_cat_3",
      "title": "Food Stylist",
      "count": "31 active briefs",
      "image": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500",
    },
    {
      "id": "skill_cat_4",
      "title": "Lifestyle",
      "count": "19 active briefs",
      "image": "https://images.unsplash.com/photo-1483985988355-763728e1935b?w=500",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header Row
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
                    "Skilled GIGs",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeLg,
                      fontWeight: AppTypography.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "Most booked shoot categories this week",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onExploreTap,
                child: Row(
                  children: [
                    Text(
                      "Explore",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        fontWeight: AppTypography.semibold,
                        color: activeColor,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: activeColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space3),

        // ── Horizontal Cards Slider
        SizedBox(
          height: 145,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
            itemCount: categories.length,
            itemBuilder: (ctx, idx) => _buildCategoryCard(context, categories[idx], isDark),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    Map<String, dynamic> item,
    bool isDark,
  ) {
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color cardBg = isDark ? AppColors.surfaceSecondaryDark : AppColors.surfaceLight;

    return GestureDetector(
      onTap: () => onCategoryTap?.call(item),
      child: Container(
        width: 144,
        margin: const EdgeInsets.only(right: AppSpacing.space3),
        decoration: BoxDecoration(
          borderRadius: AppRadius.radiusLg,
          boxShadow: isDark ? null : AppShadows.sm,
        ),
        child: ClipRRect(
          borderRadius: AppRadius.radiusLg,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Cover Image
              Image.network(
                item['image'] as String,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: cardBg,
                  child: Center(
                    child: Icon(Icons.image_outlined, color: textMuted, size: 28),
                  ),
                ),
              ),

              // Bottom Gradient Overlay for Content Legibility
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.35, 1.0],
                    ),
                  ),
                ),
              ),

              // Category Details
              Padding(
                padding: const EdgeInsets.all(AppSpacing.space2 + 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppTypography.sizeSm,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      item['count'] as String,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: AppTypography.sizeXs - 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
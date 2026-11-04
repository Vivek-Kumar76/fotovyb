import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class RisingStarsSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final Function(Map<String, dynamic> star)? onStarTap;

  const RisingStarsSection({
    super.key,
    this.onSeeAllTap,
    this.onStarTap,
  });

  // Rising Talent Spotlight Data
  final List<Map<String, dynamic>> stars = const [
    {
      "id": "star_1",
      "name": "Zara Okonkwo",
      "role": "Makeup Artist",
      "city": "Bangalore",
      "projects": 14,
      "tag": "New",
      "cover": "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=300",
      "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
    },
    {
      "id": "star_2",
      "name": "Omar Khalid",
      "role": "Creative Director",
      "city": "Mumbai",
      "projects": 11,
      "tag": "Trending",
      "cover": "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=300",
      "avatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
    },
    {
      "id": "star_3",
      "name": "Anna Müller",
      "role": "Fashion Stylist",
      "city": "Delhi",
      "projects": 7,
      "tag": "Trending",
      "cover": "https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=300",
      "avatar": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100",
    },
    {
      "id": "star_4",
      "name": "Reza Tehrani",
      "role": "Photographer",
      "city": "Pune",
      "projects": 9,
      "tag": "New",
      "cover": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300",
      "avatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
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
        // ── Section Title & "See all" Action
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
                    "New talent gaining momentum — book them early",
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

        // ── Horizontal Scrollable Carousel
        SizedBox(
          height: 195,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
            itemCount: stars.length,
            itemBuilder: (ctx, idx) => _buildStarCard(context, stars[idx], isDark),
          ),
        ),
      ],
    );
  }

  Widget _buildStarCard(BuildContext context, Map<String, dynamic> s, bool isDark) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    final String tag = s['tag'] as String;
    final bool isTrending = tag == "Trending";

    return GestureDetector(
      onTap: () => onStarTap?.call(s),
      child: Container(
        width: 144,
        margin: const EdgeInsets.only(right: AppSpacing.space3),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(color: borderColor),
          boxShadow: isDark ? null : AppShadows.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cover Image with Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                  child: Image.network(
                    s['cover'] as String,
                    height: 120,
                    width: 144,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 120,
                      color: isDark ? AppColors.surfaceSecondaryDark : AppColors.surfaceLight,
                      child: Center(
                        child: Icon(Icons.image_outlined, color: textMuted, size: 24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.space1 + 2,
                  left: AppSpacing.space1 + 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: isTrending ? AppColors.buttonGradient : null,
                      color: isTrending
                          ? null
                          : (isDark ? AppColors.surfaceSecondaryDark : AppColors.accentNavy),
                      borderRadius: AppRadius.radiusSm,
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: AppColors.textOnPrimary,
                        fontSize: AppTypography.sizeXs - 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Star Profile Details
            Padding(
              padding: const EdgeInsets.all(AppSpacing.space2),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(s['avatar'] as String),
                  ),
                  const SizedBox(width: AppSpacing.space1 + 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s['name'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontWeight: AppTypography.bold,
                            fontSize: AppTypography.sizeXs + 0.5,
                            color: textColor,
                          ),
                        ),
                        Text(
                          s['role'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: AppTypography.sizeXs - 1,
                            color: activeColor,
                            fontWeight: AppTypography.semibold,
                          ),
                        ),
                        Text(
                          "📍 ${s['city']} · ${s['projects']} prj",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: AppTypography.sizeXs - 2,
                            color: textMuted,
                          ),
                        ),
                      ],
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
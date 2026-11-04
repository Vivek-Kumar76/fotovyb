import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class FeaturedProfessionalsSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final Function(Map<String, dynamic> pro)? onProTap;

  const FeaturedProfessionalsSection({
    super.key,
    this.onSeeAllTap,
    this.onProTap,
  });

  // Featured Professionals Spotlight Data (4 Cards in a 2x2 Grid)
  final List<Map<String, dynamic>> featured = const [
    {
      "id": "feat_1",
      "name": "Mei Lin",
      "role": "Fashion Stylist",
      "city": "Mumbai",
      "rating": 4.9,
      "cover": "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400",
      "tags": ["Editorial", "Runway"],
    },
    {
      "id": "feat_2",
      "name": "Kofi Mensah",
      "role": "Photographer",
      "city": "Bangalore",
      "rating": 4.8,
      "cover": "https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=400",
      "tags": ["Cinematic", "Commercial"],
    },
    {
      "id": "feat_3",
      "name": "Priya Nair",
      "role": "Makeup Artist",
      "city": "Delhi",
      "rating": 4.7,
      "cover": "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400",
      "tags": ["Luxury", "Bridal"],
    },
    {
      "id": "feat_4",
      "name": "Arjun Mehta",
      "role": "Cinematographer",
      "city": "Goa",
      "rating": 4.9,
      "cover": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400",
      "tags": ["Narrative", "Music Video"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Title & Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Featured Professionals",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeLg,
                      fontWeight: AppTypography.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space1),
                  Container(
                    padding: const EdgeInsets.all(3.5),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xff451A03) : const Color(0xffFEF3C7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      size: 11,
                      color: Color(0xffD97706),
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
          const SizedBox(height: AppSpacing.space3),

          // ── Responsive 2-Column Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: featured.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.68, // Optimal ratio to eliminate bottom whitespace
            ),
            itemBuilder: (ctx, idx) => _buildCard(context, featured[idx], isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> f, bool isDark) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color tagBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC);

    return GestureDetector(
      onTap: () => onProTap?.call(f),
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(color: borderColor),
          boxShadow: isDark ? null : AppShadows.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Cover Image (Strictly 70% of Card)
            Expanded(
              flex: 7,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                    child: Image.network(
                      f['cover'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: tagBg,
                        child: Center(
                          child: Icon(Icons.image_outlined, color: textMuted, size: 28),
                        ),
                      ),
                    ),
                  ),

                  // Bottom Gradient Shade
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 55,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  // "Featured" Badge Chip
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: const Color(0xffD97706),
                        borderRadius: AppRadius.radiusSm,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.star_rounded, size: 10, color: Colors.white),
                          SizedBox(width: 2),
                          Text(
                            "Featured",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Available Status Dot
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // Name & City Overlay (Pinned to bottom of photo)
                  Positioned(
                    bottom: 6,
                    left: 8,
                    right: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          f['name'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          f['city'] as String,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── 2. Card Body Details (Strictly 30% of Card)
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Role Title
                    Text(
                      f['role'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 11.5,
                        fontWeight: AppTypography.bold,
                        color: activeColor,
                      ),
                    ),

                    // Star Rating
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 12, color: Color(0xffD97706)),
                        const SizedBox(width: 2),
                        Text(
                          "${f['rating']}",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 10,
                            fontWeight: AppTypography.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),

                    // Tag Chips in Horizontal Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        children: (f['tags'] as List<String>).map((t) {
                          return Container(
                            margin: const EdgeInsets.only(right: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: tagBg,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: borderColor),
                            ),
                            child: Text(
                              t,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 9,
                                color: textSecondary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
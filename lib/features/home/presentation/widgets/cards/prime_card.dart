import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/creative_pro_model.dart';

class PrimeCard extends StatelessWidget {
  final CreativeProModel pro;
  final VoidCallback? onTap;

  const PrimeCard({
    super.key,
    required this.pro,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color tagBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC);

    final String imageUrl = pro.cardDisplayImageUrl.isNotEmpty
        ? pro.cardDisplayImageUrl
        : (pro.coverImage.isNotEmpty ? pro.coverImage : pro.avatar);

    final String badgeText = pro.recognition.isNotEmpty
        ? pro.recognition.replaceAll("-", " ").toUpperCase()
        : "PRIME";

    final List<String> tags = pro.subCategories.isNotEmpty
        ? pro.subCategories
        : (pro.industries.isNotEmpty ? pro.industries : ["Creative", "Pro"]);

    return GestureDetector(
      onTap: onTap,
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
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: tagBg,
                              child: Center(
                                child: Icon(LucideIcons.image, color: textMuted, size: 26),
                              ),
                            ),
                          )
                        : Container(
                            color: tagBg,
                            child: Center(
                              child: Icon(LucideIcons.image, color: textMuted, size: 26),
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

                  // Prime Badge Chip
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
                        children: [
                          const Icon(LucideIcons.crown, size: 10, color: Colors.white),
                          const SizedBox(width: 3),
                          Text(
                            badgeText,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: 8.5,
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
                      decoration: BoxDecoration(
                        color: pro.isAvailable ? AppColors.success : const Color(0xffEF4444),
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
                          pro.fullName.isNotEmpty ? pro.fullName : "Creative Artist",
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
                          pro.location.isNotEmpty ? pro.location : "Remote",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                      pro.role.isNotEmpty
                          ? pro.role
                          : (pro.subCategories.isNotEmpty
                              ? pro.subCategories.first
                              : "Professional"),
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
                        const Icon(LucideIcons.star, size: 11, color: Color(0xffD97706)),
                        const SizedBox(width: 3),
                        Text(
                          pro.ratingDisplay,
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
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: tags.map((t) {
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
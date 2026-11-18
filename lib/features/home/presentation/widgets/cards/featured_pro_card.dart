import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/creative_pro_model.dart';

class FeaturedProCard extends StatelessWidget {
  final CreativeProModel pro;
  final VoidCallback? onView;
  final VoidCallback? onConnect;
  final VoidCallback? onFavorite;

  const FeaturedProCard({
    super.key,
    required this.pro,
    this.onView,
    this.onConnect,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color chipBg = isDark ? const Color(0xff134E4A).withValues(alpha: 0.3) : const Color(0xffF0FDFA);
    final Color chipText = isDark ? const Color(0xff5EEAD4) : const Color(0xff0D9488);

    // Image URL resolution
    final String imageUrl = pro.coverImage.isNotEmpty
        ? pro.coverImage
        : (pro.cardDisplayImageUrl.isNotEmpty ? pro.cardDisplayImageUrl : pro.avatar);

    // Dynamic recognition badge (e.g. Top Rated / Featured)
    final String badge = pro.isTopRated
        ? "Top Rated"
        : (pro.recognition.isNotEmpty ? pro.recognition : "Featured");

    // Dynamic Tags
    final List<String> tags = pro.subCategories.isNotEmpty
        ? pro.subCategories.take(3).toList()
        : (pro.industries.isNotEmpty
            ? pro.industries.take(3).toList()
            : ["Stylist", "Editorial", "Creative"]);

    final int reviewCount = pro.totalReviews > 0 ? pro.totalReviews : pro.projectCount;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.space3),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Left: Image (36% of card width)
            Expanded(
              flex: 36,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(17)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (imageUrl.isNotEmpty)
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(isDark, textMuted),
                      )
                    else
                      _buildPlaceholder(isDark, textMuted),

                    // Top Left Recognition Badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xff6366F1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Right: Details Section (64% of card width)
            Expanded(
              flex: 64,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top: Name, Role & Favorite Button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pro.fullName.isNotEmpty ? pro.fullName : "Creative Pro",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: textColor,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                pro.role.isNotEmpty
                                    ? pro.role
                                    : (pro.subCategories.isNotEmpty
                                        ? pro.subCategories.first
                                        : "Fashion Stylist"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.5,
                                  color: Color(0xff0D9488),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavorite,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: borderColor),
                              color: isDark ? AppColors.surfaceSecondaryDark : Colors.white,
                            ),
                            child: Center(
                              child: Icon(
                                pro.isFavourite ? LucideIcons.heartHandshake : LucideIcons.heart,
                                size: 14,
                                color: pro.isFavourite ? const Color(0xffEF4444) : textMuted,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Location & Rating Row
                    Row(
                      children: [
                        Icon(LucideIcons.mapPin, size: 12, color: textMuted),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            pro.location.isNotEmpty ? pro.location : "Remote",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11.5,
                              color: textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text("•", style: TextStyle(color: textMuted, fontSize: 10)),
                        const SizedBox(width: 4),
                        const Icon(LucideIcons.star, size: 12, color: Color(0xffD97706)),
                        const SizedBox(width: 2),
                        Text(
                          pro.ratingDisplay,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "($reviewCount)",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 10.5,
                            color: textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Tag Chips Row
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: chipBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: chipText,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 8),

                    // Bottom Row: Availability Status & Responsive Action Buttons
                    Row(
                      children: [
                        // Availability Status
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pro.isAvailable ? const Color(0xff10B981) : const Color(0xffEF4444),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            pro.isAvailable ? "Available" : "Busy",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                        ),

                        const SizedBox(width: 4),

                        // Action Buttons wrapped in FittedBox to guarantee 0 overflow
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Outlined View Button
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xff0D9488), width: 1.1),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                  minimumSize: const Size(0, 27),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: onView,
                                child: const Text(
                                  "View",
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff0D9488),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),

                              // Gradient Connect Button
                              GestureDetector(
                                onTap: onConnect,
                                child: Container(
                                  height: 27,
                                  padding: const EdgeInsets.symmetric(horizontal: 9),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.buttonGradient,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(LucideIcons.userPlus, size: 11, color: Colors.white),
                                      SizedBox(width: 3),
                                      Text(
                                        "Connect",
                                        style: TextStyle(
                                          fontFamily: AppTypography.fontFamilySans,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildPlaceholder(bool isDark, Color textMuted) {
    return Container(
      color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9),
      child: Center(
        child: Icon(LucideIcons.image, color: textMuted, size: 26),
      ),
    );
  }
}
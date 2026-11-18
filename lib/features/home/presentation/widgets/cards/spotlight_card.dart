import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/creative_pro_model.dart';

class SpotlightCard extends StatelessWidget {
  final CreativeProModel pro;
  final VoidCallback? onConnect;
  final VoidCallback? onProfile;
  final VoidCallback? onFavorite;

  const SpotlightCard({
    super.key,
    required this.pro,
    this.onConnect,
    this.onProfile,
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
    final Color tagBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC);

    final bool isFree = pro.isAvailable;
    final String statusText = isFree ? "Free" : "Busy";
    
    // Tag list fallback from subcategories or industries
    final tags = pro.subCategories.isNotEmpty
        ? pro.subCategories.take(2).toList()
        : (pro.industries.isNotEmpty
            ? pro.industries.take(2).toList()
            : ["Creative", "Pro"]);

    // Dynamic recognition badge (e.g. Spotlight / Top Rated / Featured)
    final String badge = pro.recognition.isNotEmpty
        ? pro.recognition.toUpperCase()
        : (pro.isTopRated ? "TOP RATED" : "SPOTLIGHT");

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cover Photo & Overlay Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
                child: AspectRatio(
                  aspectRatio: 1.15,
                  child: pro.coverImage.isNotEmpty
                      ? Image.network(
                          pro.coverImage,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholder(isDark, textMuted),
                        )
                      : _buildPlaceholder(isDark, textMuted),
                ),
              ),

              // Top Left Recognition Badge
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xffD97706),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              // Top Right Favorite Button
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: onFavorite,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        pro.isFavourite ? LucideIcons.heartHandshake : LucideIcons.heart,
                        size: 13,
                        color: pro.isFavourite ? const Color(0xffEF4444) : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom Right Status Badge (Free / Busy)
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xff1E293B).withValues(alpha: 0.82),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: isFree ? const Color(0xff10B981) : const Color(0xffEF4444),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 3.5),
                      Text(
                        statusText,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Compact Body Details & Connect Button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Avatar, Name & Role
                  GestureDetector(
                    onTap: onProfile,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: tagBg,
                          backgroundImage: pro.avatar.isNotEmpty ? NetworkImage(pro.avatar) : null,
                          onBackgroundImageError: pro.avatar.isNotEmpty ? (_, __) {} : null,
                          child: pro.avatar.isEmpty
                              ? Icon(LucideIcons.user, size: 12, color: textMuted)
                              : null,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pro.fullName.isNotEmpty ? pro.fullName : "Creative Artist",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  color: textColor,
                                ),
                              ),
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
                                  fontSize: 10,
                                  color: textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // City & Rating Row
                  Row(
                    children: [
                      const Icon(LucideIcons.mapPin, size: 11, color: Color(0xffEF4444)),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          pro.location.isNotEmpty ? pro.location : "Remote",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 10,
                            color: textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Icon(LucideIcons.star, size: 11, color: Color(0xffF59E0B)),
                      const SizedBox(width: 2),
                      Text(
                        pro.ratingDisplay,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),

                  // Tags
                  Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: tagBg,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: borderColor),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 9,
                            color: textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Connect Button
                  GestureDetector(
                    onTap: onConnect,
                    child: Container(
                      width: double.infinity,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: AppColors.buttonGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Connect",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(bool isDark, Color textMuted) {
    return Container(
      color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC),
      child: Center(
        child: Icon(LucideIcons.image, color: textMuted.withValues(alpha: 0.6), size: 28),
      ),
    );
  }
}
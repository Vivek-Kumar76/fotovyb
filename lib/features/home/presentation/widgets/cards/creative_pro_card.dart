import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/creative_pro_model.dart';

class CreativeProCard extends StatelessWidget {
  final CreativeProModel pro;
  final VoidCallback? onConnect;
  final VoidCallback? onProfile;
  final VoidCallback? onBookmark;

  const CreativeProCard({
    super.key,
    required this.pro,
    this.onConnect,
    this.onProfile,
    this.onBookmark,
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
    final Color chipBg = isDark ? AppColors.surfaceSecondaryDark : AppColors.surfaceLight;

    // ── Safe fallbacks for tags to guarantee uniform card height
    final industries = pro.industries.isNotEmpty
        ? pro.industries
        : (pro.subCategories.isNotEmpty
            ? pro.subCategories.take(2).toList()
            : [pro.role.isNotEmpty ? pro.role : 'Creative', 'Freelance']);

    final skills = pro.skills.isNotEmpty
        ? pro.skills
        : (pro.subCategories.length > 2
            ? pro.subCategories.sublist(2, pro.subCategories.length.clamp(2, 5))
            : ['Commercial', 'Client Ready']);

    final String badge = pro.isTopRated ? "Top Rated" : (pro.isFeatured ? "Featured" : "Verified");
    final bool isTopRated = badge == "Top Rated";

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.space4),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(color: borderColor),
        boxShadow: isDark ? null : AppShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Cover Image with Overlay Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                child: pro.coverImage.isNotEmpty
                    ? Image.network(
                        pro.coverImage,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildCoverPlaceholder(chipBg, textMuted),
                      )
                    : _buildCoverPlaceholder(chipBg, textMuted),
              ),

              // Gradient Shade at Bottom of Cover Image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 80,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Status Chip (Available)
              if (pro.isAvailable)
                Positioned(
                  top: AppSpacing.space2 + 2,
                  left: AppSpacing.space2 + 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: AppRadius.radiusFull,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircleAvatar(radius: 3, backgroundColor: AppColors.success),
                        SizedBox(width: 4),
                        Text(
                          "Available",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: AppTypography.sizeXs - 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Badge Chip (Top Rated / Featured / Verified)
              Positioned(
                top: AppSpacing.space2 + 2,
                right: AppSpacing.space2 + 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: isTopRated ? const Color(0xffD97706) : activeColor,
                    borderRadius: AppRadius.radiusFull,
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: AppColors.textOnPrimary,
                      fontSize: AppTypography.sizeXs - 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Bottom Overlay Details (Name, City, Day Rate)
              Positioned(
                bottom: AppSpacing.space3,
                left: AppSpacing.space3,
                right: AppSpacing.space3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pro.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: AppTypography.sizeMd,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "📍 ${pro.experienceSubtitle}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: AppTypography.sizeXs,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          pro.formattedPrice,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: AppTypography.sizeMd,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "/ day",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: AppTypography.sizeXs - 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── Card Body Content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space3 + 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar, Role & Rating Row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: chipBg,
                      backgroundImage: pro.avatar.isNotEmpty ? NetworkImage(pro.avatar) : null,
                      onBackgroundImageError: pro.avatar.isNotEmpty
                          ? (_, __) {
                              // Silently catches CORS / 404 network image errors
                            }
                          : null,
                      child: pro.avatar.isEmpty
                          ? Icon(LucideIcons.user, color: textMuted, size: 18)
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pro.role,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontWeight: AppTypography.bold,
                              fontSize: AppTypography.sizeSm,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "${pro.projectCount} projects",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.sizeXs,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xff451A03) : const Color(0xffFEF3C7),
                        borderRadius: AppRadius.radiusSm,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.star, size: 13, color: Color(0xffD97706)),
                          const SizedBox(width: 3),
                          Text(
                            pro.ratingDisplay,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontWeight: FontWeight.bold,
                              fontSize: AppTypography.sizeXs,
                              color: Color(0xffD97706),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.space3),

                // Industry Tags
                Text(
                  "INDUSTRY",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeXs - 1,
                    fontWeight: AppTypography.bold,
                    color: textMuted,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: AppSpacing.space1),
                Wrap(
                  spacing: AppSpacing.space1 + 2,
                  runSpacing: AppSpacing.space1,
                  children: industries.take(3).map((ind) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.selectionCardSelectedBgDark
                            : AppColors.selectionCardSelectedBgLight,
                        borderRadius: AppRadius.radiusSm,
                        border: Border.all(
                          color: isDark
                              ? AppColors.selectionCardSelectedBorderDark
                              : AppColors.selectionCardSelectedBorderLight,
                        ),
                      ),
                      child: Text(
                        ind,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeXs - 0.5,
                          fontWeight: AppTypography.medium,
                          color: activeColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppSpacing.space2 + 2),

                // Skill Tags
                Text(
                  "SKILLS",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeXs - 1,
                    fontWeight: AppTypography.bold,
                    color: textMuted,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: AppSpacing.space1),
                Wrap(
                  spacing: AppSpacing.space1 + 2,
                  runSpacing: AppSpacing.space1,
                  children: skills.take(3).map((sk) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: chipBg,
                        borderRadius: AppRadius.radiusSm,
                        border: Border.all(color: borderColor),
                      ),
                      child: Text(
                        sk,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeXs - 0.5,
                          color: textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppSpacing.space4),

                // ── Action Buttons
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: onConnect,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(
                            gradient: AppColors.buttonGradient,
                            borderRadius: AppRadius.radiusFull,
                          ),
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LucideIcons.userPlus, size: 14, color: Colors.white),
                              SizedBox(width: 5),
                              Text(
                                "Connect",
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  color: Colors.white,
                                  fontSize: AppTypography.sizeXs,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Expanded(
                      flex: 3,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: borderColor),
                          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                          padding: const EdgeInsets.symmetric(vertical: 9),
                        ),
                        onPressed: onProfile,
                        icon: Icon(LucideIcons.eye, size: 14, color: textColor),
                        label: Text(
                          "Profile",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: textColor,
                            fontSize: AppTypography.sizeXs,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          LucideIcons.bookmark,
                          size: 15,
                          color: pro.isFavourite ? activeColor : textSecondary,
                        ),
                        onPressed: onBookmark,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverPlaceholder(Color chipBg, Color textMuted) {
    return Container(
      height: 180,
      width: double.infinity,
      color: chipBg,
      child: Center(
        child: Icon(LucideIcons.image, color: textMuted, size: 36),
      ),
    );
  }
}
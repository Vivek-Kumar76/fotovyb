import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/creative_pro_model.dart';

class RisingStarCard extends StatelessWidget {
  final CreativeProModel star;
  final VoidCallback? onTap;

  const RisingStarCard({
    super.key,
    required this.star,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color placeholderBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xFFF1F5F9);

    final String displayName = star.fullName.trim().isNotEmpty
        ? star.fullName
        : "Rising Talent";

    final String displayRole = star.role.trim().isNotEmpty
        ? star.role
        : "Creative";

    final String coverUrl = star.cardDisplayImageUrl.isNotEmpty
        ? star.cardDisplayImageUrl
        : (star.coverImage.isNotEmpty ? star.coverImage : star.avatar);

    final String tag = star.recognition.isNotEmpty
        ? (star.recognition == "rising-star" ? "Rising Star" : star.recognition)
        : (star.isAvailable ? "Available" : "New");

    final bool isTrending = tag.toLowerCase().contains("star") || tag.toLowerCase().contains("trend");
    final String locationText = star.location.trim().isNotEmpty ? star.location : "Remote";
    final String projectsText = "${star.projectCount} prj";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(color: borderColor),
          boxShadow: isDark ? null : AppShadows.sm,
        ),
        child: ClipRRect(
          borderRadius: AppRadius.radiusLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 65% Proportion: Image
              Expanded(
                flex: 65,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: coverUrl.isNotEmpty
                          ? Image.network(
                              coverUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildPlaceholder(placeholderBg, textMuted),
                            )
                          : _buildPlaceholder(placeholderBg, textMuted),
                    ),
                    Positioned(
                      top: AppSpacing.space2,
                      left: AppSpacing.space2,
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
              ),

              // 35% Proportion: Data Details
              Expanded(
                flex: 35,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space2,
                    vertical: AppSpacing.space1,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: placeholderBg,
                        backgroundImage: star.avatar.isNotEmpty ? NetworkImage(star.avatar) : null,
                        child: star.avatar.isEmpty
                            ? Text(
                                displayName.isNotEmpty ? displayName[0].toUpperCase() : "R",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: textMuted,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: AppSpacing.space1 + 2),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontWeight: AppTypography.bold,
                                fontSize: AppTypography.sizeXs,
                                color: textColor,
                              ),
                            ),
                            Text(
                              displayRole,
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
                              "$locationText . $projectsText",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(Color bgColor, Color textColor) {
    return Container(
      color: bgColor,
      alignment: Alignment.center,
      child: Text(
        "Photo",
        style: TextStyle(
          fontSize: 11,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
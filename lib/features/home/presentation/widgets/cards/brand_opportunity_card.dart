import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/brand_opportunity_model.dart';

class BrandOpportunityCard extends StatelessWidget {
  final BrandOpportunityModel opportunity;
  final VoidCallback? onTap;
  final VoidCallback? onApplyTap;
  final VoidCallback? onSaveTap;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const BrandOpportunityCard({
    super.key,
    required this.opportunity,
    this.onTap,
    this.onApplyTap,
    this.onSaveTap,
    this.width,
    this.margin,
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

    // Header theme colors & badges based on urgency / tier
    final Color headerBg = _getHeaderBg(opportunity);
    final _BadgeData badgeData = _getBadgeData(opportunity);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: margin,
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
            // ── Card Header (Brand Identity, Urgency/Tier Badge & Time Left)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space3,
                vertical: AppSpacing.space2,
              ),
              decoration: BoxDecoration(
                color: headerBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg - 1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: opportunity.brandLogo.isNotEmpty
                        ? Image.network(
                            opportunity.brandLogo,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.business_rounded,
                              size: 14,
                              color: Colors.black87,
                            ),
                          )
                        : const Icon(Icons.business_rounded, size: 14, color: Colors.black87),
                  ),
                  const SizedBox(width: AppSpacing.space2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opportunity.brand,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: AppTypography.sizeXs + 0.5,
                          ),
                        ),
                        Text(
                          "📍 ${opportunity.location}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: AppTypography.sizeXs - 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: badgeData.color,
                      borderRadius: AppRadius.radiusSm,
                    ),
                    child: Text(
                      badgeData.text,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: AppTypography.sizeXs - 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (opportunity.timeRemaining.isNotEmpty) ...[
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: AppRadius.radiusSm,
                      ),
                      child: Text(
                        opportunity.timeRemaining,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: AppTypography.sizeXs - 2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ── Card Body (Title, Brief Description, Roles & Budget)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.space3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opportunity.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontWeight: AppTypography.bold,
                      fontSize: AppTypography.sizeSm,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space1),
                  Text(
                    opportunity.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs,
                      color: textSecondary,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space3),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LOOKING FOR:",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: AppTypography.sizeXs - 2,
                                fontWeight: AppTypography.bold,
                                color: textMuted,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.space1),
                            if (opportunity.roles.isNotEmpty)
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: opportunity.roles.take(3).map((r) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2.5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppColors.surfaceSecondaryDark
                                          : const Color(0xffEFF6FF),
                                      borderRadius: AppRadius.radiusSm,
                                      border: Border.all(
                                        color: isDark
                                            ? AppColors.borderDark
                                            : const Color(0xffBFDBFE),
                                      ),
                                    ),
                                    child: Text(
                                      r,
                                      style: TextStyle(
                                        fontFamily: AppTypography.fontFamilySans,
                                        fontSize: AppTypography.sizeXs - 1.5,
                                        color: isDark ? activeColor : const Color(0xff2563EB),
                                        fontWeight: AppTypography.bold,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            else
                              Text(
                                "Open Brief",
                                style: TextStyle(
                                  fontSize: AppTypography.sizeXs - 2,
                                  color: textMuted,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.space2),
                      Text(
                        opportunity.budget,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontWeight: FontWeight.w900,
                          fontSize: AppTypography.sizeSm + 1,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space3 + 2),

                  // ── Action Buttons (Apply Now & Save)
                  Row(
                    children: [
                      // Gradient Apply Button
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: onApplyTap,
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
                                Icon(Icons.send_rounded, size: 13, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  "Apply Now",
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
                        flex: 2,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: opportunity.isSaved ? activeColor : borderColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppRadius.radiusFull,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            backgroundColor: opportunity.isSaved
                                ? (isDark ? activeColor.withValues(alpha: 0.15) : const Color(0xffF0FDF4))
                                : null,
                          ),
                          onPressed: onSaveTap,
                          icon: Icon(
                            opportunity.isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 14,
                            color: opportunity.isSaved ? activeColor : textSecondary,
                          ),
                          label: Text(
                            opportunity.isSaved ? "Saved" : "Save",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: opportunity.isSaved ? activeColor : textSecondary,
                              fontSize: AppTypography.sizeXs,
                              fontWeight: AppTypography.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getHeaderBg(BrandOpportunityModel opp) {
    if (opp.urgent) return const Color(0xff244D87);
    final tier = opp.visibilityTier.toLowerCase();
    if (tier.contains('boost')) return const Color(0xff1E6B52);
    if (tier.contains('high')) return const Color(0xff244D87);
    return const Color(0xff262626);
  }

  _BadgeData _getBadgeData(BrandOpportunityModel opp) {
    if (opp.urgent) {
      return const _BadgeData(text: "⚡ URGENT", color: Color(0xffEF4444));
    }
    final tier = opp.visibilityTier.toLowerCase();
    if (tier.contains('boost')) {
      return const _BadgeData(text: "⚡ BOOSTED", color: Color(0xffD97706));
    }
    if (tier.contains('high')) {
      return const _BadgeData(text: "⚡ HIGH PRIORITY", color: Color(0xffEF4444));
    }
    return const _BadgeData(text: "⚡ FEATURED", color: Color(0xff2563EB));
  }
}

class _BadgeData {
  final String text;
  final Color color;
  const _BadgeData({required this.text, required this.color});
}
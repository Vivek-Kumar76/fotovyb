import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class BrandOpportunitiesSection extends StatelessWidget {
  final VoidCallback? onBrowseAllTap;
  final Function(Map<String, dynamic> opp)? onApplyTap;
  final Function(Map<String, dynamic> opp)? onSaveTap;
  final Function(Map<String, dynamic> opp)? onCardTap;

  const BrandOpportunitiesSection({
    super.key,
    this.onBrowseAllTap,
    this.onApplyTap,
    this.onSaveTap,
    this.onCardTap,
  });

  // Live Brand Opportunities Briefs
  final List<Map<String, dynamic>> opps = const [
    {
      "id": "opp_1",
      "brand": "Volta Motors",
      "city": "Bangalore",
      "headerBg": Color(0xff244D87),
      "badge": "⚡ URGENT",
      "badgeColor": Color(0xffEF4444),
      "daysLeft": "3 days left",
      "title": "Campaign Photographer & Stylist for EV Launch",
      "desc":
          "Seeking an experienced automotive photographer and fashion stylist for our upcoming EV campaign shoot.",
      "roles": ["Photographer", "Stylist"],
      "budget": "₹85,000",
    },
    {
      "id": "opp_2",
      "brand": "Vogue India",
      "city": "Mumbai",
      "headerBg": Color(0xff262626),
      "badge": "⚡ BOOSTED",
      "badgeColor": Color(0xffD97706),
      "daysLeft": "5 days left",
      "title": "Editorial Cover Shoot — February Issue",
      "desc":
          "We are looking for a senior editorial photographer for our upcoming February cover shoot with a top Bollywood celebrity.",
      "roles": ["Photographer", "Makeup Artist"],
      "budget": "₹60,000",
    },
    {
      "id": "opp_3",
      "brand": "Lumière Hotels",
      "city": "Goa",
      "headerBg": Color(0xff1E6B52),
      "badge": "⚡ BOOSTED",
      "badgeColor": Color(0xffD97706),
      "daysLeft": "7 days left",
      "title": "Brand Film — Goa Property Launch",
      "desc":
          "Luxury hotel brand seeking a cinematic videography team for our newest Goa property launch film.",
      "roles": ["Videographer", "Director", "Stylist"],
      "budget": "₹1,20,000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Title & "Browse all" Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Brand Opportunities",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeLg,
                      fontWeight: AppTypography.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "Live briefs from brands & businesses",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onBrowseAllTap,
                child: Row(
                  children: [
                    Text(
                      "Browse all",
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

          // ── Opportunity Brief Cards List
          ...opps.map((o) => _buildOppCard(context, o, isDark)),
        ],
      ),
    );
  }

  Widget _buildOppCard(BuildContext context, Map<String, dynamic> o, bool isDark) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return GestureDetector(
      onTap: () => onCardTap?.call(o),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.space3 + 2),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(color: borderColor),
          boxShadow: isDark ? null : AppShadows.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Card Header (Brand Identity, Urgency Tag & Time Remaining)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space3,
                vertical: AppSpacing.space2,
              ),
              decoration: BoxDecoration(
                color: o['headerBg'] as Color,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg - 1)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.business_rounded, size: 14, color: Colors.black87),
                  ),
                  const SizedBox(width: AppSpacing.space2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o['brand'] as String,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppTypography.sizeXs + 0.5,
                        ),
                      ),
                      Text(
                        "📍 ${o['city']}",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: AppTypography.sizeXs - 2,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: o['badgeColor'] as Color,
                      borderRadius: AppRadius.radiusSm,
                    ),
                    child: Text(
                      o['badge'] as String,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: AppTypography.sizeXs - 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      borderRadius: AppRadius.radiusSm,
                    ),
                    child: Text(
                      o['daysLeft'] as String,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: AppTypography.sizeXs - 2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Card Body (Title, Brief, Roles & Budget)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.space3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    o['title'] as String,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontWeight: AppTypography.bold,
                      fontSize: AppTypography.sizeSm,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space1),
                  Text(
                    o['desc'] as String,
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
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: (o['roles'] as List<String>).map((r) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
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
                            ),
                          ],
                        ),
                      ),
                      Text(
                        o['budget'] as String,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontWeight: FontWeight.w900,
                          fontSize: AppTypography.sizeMd,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space3 + 2),

                  // ── Action Buttons (Unified Gradient Apply & Save)
                  Row(
                    children: [
                      // Standard Gradient "Apply Now" Button (#2E7D6E -> #1C3A5E)
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () => onApplyTap?.call(o),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              gradient: AppColors.buttonGradient,
                              borderRadius: AppRadius.radiusFull,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.send_rounded,
                                  size: 13,
                                  color: Colors.white,
                                ),
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
                            side: BorderSide(color: borderColor),
                            shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                            padding: const EdgeInsets.symmetric(vertical: 9),
                          ),
                          onPressed: () => onSaveTap?.call(o),
                          icon: Icon(
                            Icons.bookmark_border_rounded,
                            size: 14,
                            color: textSecondary,
                          ),
                          label: Text(
                            "Save",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: textSecondary,
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
}
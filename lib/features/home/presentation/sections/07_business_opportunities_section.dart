import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class BusinessOpportunitiesSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final VoidCallback? onPostServiceOfferTap;
  final Function(Map<String, dynamic> item)? onItemTap;

  const BusinessOpportunitiesSection({
    super.key,
    this.onSeeAllTap,
    this.onPostServiceOfferTap,
    this.onItemTap,
  });

  // Business Opportunities Feed List
  final List<Map<String, dynamic>> items = const [
    {
      "id": "biz_opp_1",
      "title": "Brand Film for Premium Property Launch",
      "brand": "Lumière Hotels",
      "city": "Goa",
      "time": "2 days ago",
      "price": "₹1,20,000",
      "tags": ["Videographer", "Director"],
      "icon": Icons.apartment_rounded,
      "iconBgLight": Color(0xffE6F7F0),
      "iconBgDark": Color(0xff064E3B),
      "iconColor": AppColors.primary,
    },
    {
      "id": "biz_opp_2",
      "title": "Social Media Content Creator (Reels)",
      "brand": "FreshBlend Co.",
      "city": "Remote",
      "time": "Today",
      "price": "₹22,000",
      "tags": ["Videographer", "Editor"],
      "icon": Icons.coffee_rounded,
      "iconBgLight": Color(0xffFEF3C7),
      "iconBgDark": Color(0xff451A03),
      "iconColor": Color(0xffD97706),
    },
    {
      "id": "biz_opp_3",
      "title": "E-commerce Photography Pack (200 shots)",
      "brand": "NIXT Fashion",
      "city": "Bangalore",
      "time": "1 day ago",
      "price": "₹38,000",
      "tags": ["Photographer"],
      "icon": Icons.shopping_bag_outlined,
      "iconBgLight": Color(0xffFEE2E2),
      "iconBgDark": Color(0xff7F1D1D),
      "iconColor": Color(0xffEF4444),
    },
    {
      "id": "biz_opp_4",
      "title": "Artist Portrait & EPK Photography",
      "brand": "SoundWave",
      "city": "Hyderabad",
      "time": "3 days ago",
      "price": "₹28,000",
      "tags": ["Photographer", "Retoucher"],
      "icon": Icons.music_note_rounded,
      "iconBgLight": Color(0xffEFF6FF),
      "iconBgDark": Color(0xff1E3A8A),
      "iconColor": Color(0xff3B82F6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.space4),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(color: borderColor),
          boxShadow: isDark ? null : AppShadows.sm,
        ),
        child: Column(
          children: [
            // ── Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Business Opportunities",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeSm + 1,
                    fontWeight: AppTypography.bold,
                    color: textColor,
                  ),
                ),
                GestureDetector(
                  onTap: onSeeAllTap,
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs + 0.5,
                      fontWeight: AppTypography.bold,
                      color: activeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space2),

            // ── Item Tiles List
            ...items.map((item) => _buildItemTile(context, item, isDark)),
            const SizedBox(height: AppSpacing.space3),

            // ── Bottom Action Button (Standard Linear Gradient CTA)
            GestureDetector(
              onTap: onPostServiceOfferTap,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.buttonGradient,
                  borderRadius: AppRadius.radiusFull,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_circle_outline_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Post a Service Offer",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: AppTypography.sizeXs + 0.5,
                        fontWeight: FontWeight.bold,
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

  Widget _buildItemTile(BuildContext context, Map<String, dynamic> item, bool isDark) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color dividerColor = isDark ? AppColors.borderDark : const Color(0xffF1F5F9);
    final Color tagBg = isDark ? AppColors.surfaceSecondaryDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return GestureDetector(
      onTap: () => onItemTap?.call(item),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.space2 + 2),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: dividerColor)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Pill
            Container(
              padding: const EdgeInsets.all(AppSpacing.space2),
              decoration: BoxDecoration(
                color: isDark
                    ? (item['iconBgDark'] as Color)
                    : (item['iconBgLight'] as Color),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item['icon'] as IconData,
                size: 16,
                color: item['iconColor'] as Color,
              ),
            ),
            const SizedBox(width: AppSpacing.space2 + 2),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontWeight: AppTypography.bold,
                      fontSize: AppTypography.sizeXs + 1,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${item['brand']} · 📍 ${item['city']} · ${item['time']}",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs - 1,
                      color: textMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space1 + 2),
                  Row(
                    children: [
                      Wrap(
                        spacing: 4,
                        children: (item['tags'] as List<String>)
                            .map((t) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: tagBg,
                                    borderRadius: AppRadius.radiusSm,
                                    border: Border.all(color: borderColor),
                                  ),
                                  child: Text(
                                    t,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: AppTypography.sizeXs - 2,
                                      color: textSecondary,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const Spacer(),
                      Text(
                        item['price'] as String,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontWeight: FontWeight.bold,
                          fontSize: AppTypography.sizeSm,
                          color: textColor,
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
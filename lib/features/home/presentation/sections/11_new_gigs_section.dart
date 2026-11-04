import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class NewGigsSection extends StatelessWidget {
  final Function(Map<String, dynamic> gig)? onViewGigTap;
  final Function(Map<String, dynamic> gig)? onChatTap;
  final Function(Map<String, dynamic> gig)? onFavoriteTap;
  final Function(Map<String, dynamic> gig, Map<String, dynamic> tier)? onTierTap;

  const NewGigsSection({
    super.key,
    this.onViewGigTap,
    this.onChatTap,
    this.onFavoriteTap,
    this.onTierTap,
  });

  // Freshly Listed Creative Gigs Data
  final List<Map<String, dynamic>> gigs = const [
    {
      "id": "new_gig_1",
      "title": "Brand Film & Social Reels Production",
      "author": "Arjun Kapoor",
      "authorSub": "Rising Star · Hyderabad",
      "rating": 4.8,
      "categoryTag": "Videography",
      "cover": "https://images.unsplash.com/photo-1536240478700-b869070f9279?w=600",
      "avatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
      "tags": ["FMCG", "E-commerce", "Reels", "Brand Film"],
      "delivery": "3–5 days",
      "orders": "38 orders",
      "tiers": [
        {"label": "Basic", "price": "₹6,000", "isPopular": false},
        {"label": "Standard", "price": "₹18,000", "isPopular": true},
        {"label": "Premium", "price": "₹55,000", "isPopular": false},
      ],
    },
    {
      "id": "new_gig_2",
      "title": "E-commerce & Product Photo Retouching",
      "author": "Zara Okonkwo",
      "authorSub": "Rising Star · Bangalore",
      "rating": 4.8,
      "categoryTag": "Editing & Post",
      "cover": "https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=600",
      "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
      "tags": ["E-commerce", "Fashion", "Retouching", "E-commerce"],
      "delivery": "1–2 days",
      "orders": "26 orders",
      "tiers": [
        {"label": "Basic", "price": "₹2,500", "isPopular": false},
        {"label": "Standard", "price": "₹7,000", "isPopular": true},
        {"label": "Premium", "price": "₹18,000", "isPopular": false},
      ],
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
          // ── Section Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  gradient: AppColors.buttonGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bolt_rounded, size: 16, color: Colors.white),
              ),
              const SizedBox(width: AppSpacing.space2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New GIGs",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeLg,
                      fontWeight: AppTypography.bold,
                      color: textColor,
                    ),
                  ),
                  Text(
                    "Fresh talent — discover them first",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space3 + 2),

          // ── GIG Cards List
          ...gigs.map((g) => _buildNewGigCard(context, g, isDark, activeColor)),
        ],
      ),
    );
  }

  Widget _buildNewGigCard(
    BuildContext context,
    Map<String, dynamic> g,
    bool isDark,
    Color activeColor,
  ) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color placeholderBg = isDark ? AppColors.surfaceSecondaryDark : AppColors.surfaceLight;

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
        children: [
          // ── Cover Image with Overlay Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                child: Image.network(
                  g['cover'] as String,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: placeholderBg,
                    child: Center(
                      child: Icon(Icons.image_outlined, color: textMuted, size: 36),
                    ),
                  ),
                ),
              ),

              // "New" Badge Chip
              Positioned(
                top: AppSpacing.space2 + 2,
                left: AppSpacing.space2 + 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradient,
                    borderRadius: AppRadius.radiusFull,
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.auto_awesome_rounded, size: 11, color: Colors.white),
                      SizedBox(width: 3),
                      Text(
                        "New",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: AppTypography.sizeXs - 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Favorite Button
              Positioned(
                top: AppSpacing.space2 + 2,
                right: AppSpacing.space2 + 2,
                child: GestureDetector(
                  onTap: () => onFavoriteTap?.call(g),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark.withValues(alpha: 0.8) : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: 15,
                      color: textColor,
                    ),
                  ),
                ),
              ),

              // Category Pill at Bottom-Left
              Positioned(
                bottom: AppSpacing.space2,
                left: AppSpacing.space2 + 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: AppRadius.radiusSm,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5.5,
                        height: 5.5,
                        decoration: BoxDecoration(
                          color: activeColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        g['categoryTag'] as String,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: AppTypography.sizeXs - 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Card Content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author Row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(g['avatar'] as String),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            g['author'] as String,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontWeight: AppTypography.bold,
                              fontSize: AppTypography.sizeSm,
                              color: textColor,
                            ),
                          ),
                          Text(
                            g['authorSub'] as String,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.sizeXs - 1,
                              color: textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.star_rounded, size: 14, color: Color(0xffD97706)),
                    Text(
                      " ${g['rating']}",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeXs,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space2 + 2),

                // GIG Title
                Text(
                  g['title'] as String,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontWeight: AppTypography.bold,
                    fontSize: AppTypography.sizeSm + 0.5,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: AppSpacing.space2),

                // Skill / Category Tags
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: (g['tags'] as List<String>).map((t) {
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
                        t,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeXs - 1.5,
                          color: activeColor,
                          fontWeight: AppTypography.semibold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.space2 + 2),

                // Meta Info (Delivery Turnaround & Total Orders)
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 13, color: textSecondary),
                    const SizedBox(width: 3),
                    Text(
                      g['delivery'] as String,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeXs - 1,
                        color: textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space3),
                    Icon(Icons.inventory_2_outlined, size: 13, color: textSecondary),
                    const SizedBox(width: 3),
                    Text(
                      g['orders'] as String,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeXs - 1,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space3),

                // 3-Tier Price Selector Pills
                Row(
                  children: (g['tiers'] as List<Map<String, dynamic>>).map((tier) {
                    final bool isPopular = tier['isPopular'] as bool;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTierTap?.call(g, tier),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: isPopular
                                ? (isDark
                                    ? AppColors.selectionCardSelectedBgDark
                                    : AppColors.selectionCardSelectedBgLight)
                                : (isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC)),
                            borderRadius: AppRadius.radiusMd,
                            border: Border.all(
                              color: isPopular ? activeColor : borderColor,
                              width: isPopular ? 1.5 : 1.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                tier['label'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: AppTypography.sizeXs - 2.5,
                                  color: isPopular ? activeColor : textSecondary,
                                  fontWeight: AppTypography.medium,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                tier['price'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: AppTypography.sizeXs,
                                  fontWeight: FontWeight.bold,
                                  color: isPopular ? activeColor : textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.space3 + 2),

                // ── Action Row (Gradient "View GIG" + Chat)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onViewGigTap?.call(g),
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            gradient: AppColors.buttonGradient,
                            borderRadius: AppRadius.radiusFull,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "View GIG",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: AppColors.textOnPrimary,
                              fontSize: AppTypography.sizeXs,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        shape: BoxShape.circle,
                        color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 16,
                          color: textSecondary,
                        ),
                        onPressed: () => onChatTap?.call(g),
                        constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
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
}
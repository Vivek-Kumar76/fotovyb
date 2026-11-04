import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

// ── 1. Strongly-Typed Data Model
class ProSellerGig {
  final String id;
  final String title;
  final String author;
  final double rating;
  final String badge;
  final Color? badgeColor;
  final String days;
  final String orders;
  final String price;
  final List<String> tags;
  final String cover;
  final String avatar;

  const ProSellerGig({
    required this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.badge,
    this.badgeColor,
    required this.days,
    required this.orders,
    required this.price,
    required this.tags,
    required this.cover,
    required this.avatar,
  });

  factory ProSellerGig.fromMap(Map<String, dynamic> map) {
    return ProSellerGig(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      author: map['author'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      badge: map['badge'] as String? ?? 'Pro',
      badgeColor: map['badgeColor'] as Color?,
      days: map['days'] as String? ?? '',
      orders: map['orders']?.toString() ?? '0',
      price: map['price'] as String? ?? '',
      tags: List<String>.from(map['tags'] as List? ?? []),
      cover: map['cover'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'badge': badge,
      'badgeColor': badgeColor,
      'days': days,
      'orders': orders,
      'price': price,
      'tags': tags,
      'cover': cover,
      'avatar': avatar,
    };
  }
}

// ── 2. Main Section Widget
class ProSellerGigsSection extends StatelessWidget {
  final List<ProSellerGig>? customGigs;
  final bool isLoading;
  final VoidCallback? onSeeAllTap;
  final Function(Map<String, dynamic> gig)? onGigTap;
  final Function(Map<String, dynamic> gig)? onViewGigTap;

  const ProSellerGigsSection({
    super.key,
    this.customGigs,
    this.isLoading = false,
    this.onSeeAllTap,
    this.onGigTap,
    this.onViewGigTap,
  });

  // Default Mock Dataset
  static const List<ProSellerGig> defaultGigs = [
    ProSellerGig(
      id: "pro_gig_1",
      title: "High Fashion Editorial Styling & Mood Boarding",
      author: "Mei Lin",
      rating: 4.9,
      badge: "Top Rated",
      badgeColor: AppColors.accentNavy,
      days: "1–2 days",
      orders: "204",
      price: "₹12,000",
      tags: ["Fashion", "Luxury", "Editorial"],
      cover: "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=300",
      avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
    ),
    ProSellerGig(
      id: "pro_gig_2",
      title: "Creative Art Direction & Campaign Concepts",
      author: "Sofia Reyes",
      rating: 4.7,
      badge: "Pro Seller",
      badgeColor: Color(0xff7C3AED),
      days: "2–4 days",
      orders: "57",
      price: "₹14,000",
      tags: ["Tech", "D2C", "Campaign"],
      cover: "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=300",
      avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100",
    ),
    ProSellerGig(
      id: "pro_gig_3",
      title: "Fashion & Commercial Modelling",
      author: "Marco Bianchi",
      rating: 4.9,
      badge: "Top Rated",
      badgeColor: AppColors.accentNavy,
      days: "On-site",
      orders: "113",
      price: "₹10,000",
      tags: ["Fashion", "FMCG", "Commercial"],
      cover: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300",
      avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    final displayList = customGigs ?? defaultGigs;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Title & Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.5),
                    decoration: const BoxDecoration(
                      gradient: AppColors.buttonGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.workspace_premium_outlined,
                      size: 14,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pro Seller GIGs",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeLg,
                          fontWeight: AppTypography.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        "Consistently 4.8★ and above",
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

          // ── Loading Skeleton or Pro Gigs List
          if (isLoading)
            ...List.generate(3, (index) => _buildSkeletonCard(isDark))
          else
            ...displayList.map(
              (gig) => ProSellerGigCardTile(
                gig: gig,
                isDark: isDark,
                onTap: () => onGigTap?.call(gig.toMap()),
                onViewTap: () => onViewGigTap?.call(gig.toMap()),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSkeletonCard(bool isDark) {
    final baseColor = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.space3),
      height: 136,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 114,
            height: 136,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(AppRadius.lg),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 14, width: double.infinity, color: baseColor),
                  Container(height: 10, width: 100, color: baseColor),
                  Container(height: 10, width: 140, color: baseColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: 16, width: 60, color: baseColor),
                      Container(
                        height: 28,
                        width: 80,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: AppRadius.radiusFull,
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
    );
  }
}

// ── 3. Extracted Card Tile Component
class ProSellerGigCardTile extends StatelessWidget {
  final ProSellerGig gig;
  final bool isDark;
  final VoidCallback? onTap;
  final VoidCallback? onViewTap;

  const ProSellerGigCardTile({
    super.key,
    required this.gig,
    required this.isDark,
    this.onTap,
    this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color tagBg = isDark ? AppColors.surfaceSecondaryDark : AppColors.surfaceLight;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.space3),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusLg,
          border: Border.all(color: borderColor),
          boxShadow: isDark ? null : AppShadows.sm,
        ),
        child: Row(
          children: [
            // ── Left Side: Gig Cover Image with Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(AppRadius.lg),
                  ),
                  child: Image.network(
                    gig.cover,
                    width: 114,
                    height: 136,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 114,
                      height: 136,
                      color: tagBg,
                      child: Center(
                        child: Icon(Icons.image_outlined, color: textMuted, size: 24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.space1 + 2,
                  left: AppSpacing.space1 + 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: gig.badgeColor ?? AppColors.accentNavy,
                      borderRadius: AppRadius.radiusSm,
                    ),
                    child: Text(
                      gig.badge,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: AppTypography.sizeXs - 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Right Side: Content Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.space2 + 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gig.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontWeight: AppTypography.bold,
                        fontSize: AppTypography.sizeXs + 1,
                        color: textColor,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space1),

                    // Author Avatar & Rating Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 8.5,
                          backgroundImage: NetworkImage(gig.avatar),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            gig.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.sizeXs - 1,
                              color: textSecondary,
                            ),
                          ),
                        ),
                        const Icon(Icons.star_rounded, size: 12, color: Color(0xffD97706)),
                        const SizedBox(width: 1),
                        Text(
                          " ${gig.rating}",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: AppTypography.sizeXs - 1,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space1),

                    // Tags
                    Wrap(
                      spacing: 4,
                      children: gig.tags
                          .map((t) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: tagBg,
                                  borderRadius: AppRadius.radiusSm,
                                  border: Border.all(color: borderColor),
                                ),
                                child: Text(
                                  t,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: AppTypography.sizeXs - 2.5,
                                    color: textSecondary,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: AppSpacing.space1),

                    // Delivery Turnaround & Total Orders
                    Text(
                      "⏱ ${gig.days} · 📦 ${gig.orders} orders",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeXs - 1.5,
                        color: textMuted,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space1 + 2),

                    // Price & Gradient "View GIG" Action Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          gig.price,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: AppTypography.sizeSm + 0.5,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: onViewTap,
                          child: Container(
                            height: 28,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              gradient: AppColors.buttonGradient,
                              borderRadius: AppRadius.radiusFull,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "View GIG",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Colors.white,
                                fontSize: AppTypography.sizeXs - 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class FeaturedGigsSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final Function(Map<String, dynamic> gig)? onGigTap;
  final Function(Map<String, dynamic> gig)? onFavoriteTap;
  final Function(Map<String, dynamic> gig)? onViewTap;

  const FeaturedGigsSection({
    super.key,
    this.onSeeAllTap,
    this.onGigTap,
    this.onFavoriteTap,
    this.onViewTap,
  });

  // Featured Gigs Listings matching reference design
  final List<Map<String, dynamic>> gigs = const [
    {
      "id": "gig_1",
      "title": "Cinematic Fashion & Editorial Photography",
      "author": "Kofi Mensah",
      "rating": 4.9,
      "orders": 142,
      "price": "₹8,000",
      "badge": "Featured",
      "badgeType": "featured",
      "cover": "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=600",
      "avatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
    },
    {
      "id": "gig_2",
      "title": "Luxury & Editorial Makeup Artistry",
      "author": "Priya Nair",
      "rating": 4.8,
      "orders": 89,
      "price": "₹3,500",
      "badge": "Featured",
      "badgeType": "featured",
      "cover": "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=600",
      "avatar": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100",
    },
    {
      "id": "gig_3",
      "title": "High Fashion Styling & Celebrity Wardrobe",
      "author": "Reza Tehrani",
      "rating": 4.9,
      "orders": 77,
      "price": "₹8,000",
      "badge": "Featured",
      "badgeType": "featured",
      "cover": "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=600",
      "avatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
    },
    {
      "id": "gig_4",
      "title": "High Fashion Editorial Styling &\nMood Boarding",
      "author": "Mei Lin",
      "rating": 4.9,
      "orders": 204,
      "price": "₹5,000",
      "badge": "Top Rated",
      "badgeType": "top_rated",
      "cover": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600",
      "avatar": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section Title & Action Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xff451A03) : const Color(0xffEAB308).withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: Color(0xffD97706),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space2 + 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Featured GIGs",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeLg,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        "Hand-picked for quality and reliability",
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
        ),
        const SizedBox(height: AppSpacing.space3),

        // ── Horizontal GIGs Carousel
        SizedBox(
          height: 275,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
            itemCount: gigs.length,
            itemBuilder: (ctx, idx) => _buildGigCard(context, gigs[idx], isDark),
          ),
        ),
      ],
    );
  }

  Widget _buildGigCard(BuildContext context, Map<String, dynamic> g, bool isDark) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final isTopRated = g['badgeType'] == 'top_rated';

    return GestureDetector(
      onTap: () => onGigTap?.call(g),
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 14),
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
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          children: [
            // ── Main Image Area with Gradient & Overlaid Info (~75% ratio)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
                  child: Image.network(
                    g['cover'] as String,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 200,
                      color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9),
                      child: Center(
                        child: Icon(Icons.image_outlined, color: textMuted, size: 32),
                      ),
                    ),
                  ),
                ),

                // Smooth Gradient Shade for Text Readability
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.88),
                        ],
                        stops: const [0.0, 0.35, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                // Top Left Badge (Featured vs Top Rated)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: isTopRated ? AppColors.accentNavy : const Color(0xffD97706),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isTopRated ? Icons.verified_rounded : Icons.star_rounded,
                          size: 11,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          g['badge'] as String,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Top Right Favorite Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => onFavoriteTap?.call(g),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        size: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),

                // Bottom Content Overlaid on Photo
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        g['title'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 9,
                            backgroundImage: NetworkImage(g['avatar'] as String),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              g['author'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(Icons.star_rounded, size: 13, color: Color(0xffFBBF24)),
                          const SizedBox(width: 2),
                          Text(
                            "${g['rating']}",
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── Bottom Textual Bar (~25% ratio)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 10,
                          color: textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        g['price'] as String,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),

                  // Orders Badge Info
                  Row(
                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 13, color: textMuted),
                      const SizedBox(width: 4),
                      Text(
                        "${g['orders']} orders",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 11,
                          color: textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Standard Button Gradient "View" Action (#2E7D6E -> #1C3A5E)
                  GestureDetector(
                    onTap: () => onViewTap?.call(g),
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        gradient: AppColors.buttonGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "View",
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
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class TopRatedProfilesSection extends StatelessWidget {
  final VoidCallback? onViewAllTap;
  final Function(Map<String, dynamic> profile)? onConnectTap;
  final Function(Map<String, dynamic> profile)? onProfileTap;
  final Function(Map<String, dynamic> profile)? onFavoriteTap;

  const TopRatedProfilesSection({
    super.key,
    this.onViewAllTap,
    this.onConnectTap,
    this.onProfileTap,
    this.onFavoriteTap,
  });

  final List<Map<String, dynamic>> profiles = const [
    {
      "id": "top_1",
      "name": "Mei Lin",
      "role": "Fashion Stylist",
      "city": "Mumbai",
      "rating": 4.9,
      "badge": "Top Rated",
      "badgeColor": Color(0xffD97706),
      "status": "Free",
      "cover": "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=600",
      "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120",
      "tags": ["Editorial", "Runway"],
    },
    {
      "id": "top_2",
      "name": "Kofi Mensah",
      "role": "Photographer",
      "city": "Bangalore",
      "rating": 4.8,
      "badge": "Featured",
      "badgeColor": AppColors.accentNavy,
      "status": "Free",
      "cover": "https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=600",
      "avatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120",
      "tags": ["Portraits", "Auto"],
    },
    {
      "id": "top_3",
      "name": "Leila Mansouri",
      "role": "Makeup Artist",
      "city": "Delhi",
      "rating": 4.7,
      "badge": null,
      "badgeColor": null,
      "status": "Busy",
      "cover": "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=600",
      "avatar": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=120",
      "tags": ["Luxury", "Bridal"],
    },
    {
      "id": "top_4",
      "name": "Arjun Kapoor",
      "role": "Videographer",
      "city": "Hyderabad",
      "rating": 4.9,
      "badge": "Rising Star",
      "badgeColor": Color(0xff7C3AED),
      "status": "Free",
      "cover": "https://images.unsplash.com/photo-1536240478700-b869070f9279?w=600",
      "avatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120",
      "tags": ["Reels", "Brand Film"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    // Higher childAspectRatio = Reduced overall card height
    final double responsiveAspectRatio = screenWidth < 360 ? 0.56 : 0.60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Top Rated Profiles",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  letterSpacing: -0.3,
                ),
              ),
              GestureDetector(
                onTap: onViewAllTap,
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: activeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space3),

          // ── 2-Column Compact Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: profiles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              childAspectRatio: responsiveAspectRatio,
            ),
            itemBuilder: (ctx, idx) => _buildProfileCard(context, profiles[idx], isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, Map<String, dynamic> p, bool isDark) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color tagBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC);

    final bool isFree = p['status'] == "Free";
    final String? badge = p['badge'] as String?;
    final Color badgeColor = (p['badgeColor'] as Color?) ?? activeColor;
    final String coverUrl = (p['cover'] as String?) ?? "";

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
          // ── Cover Photo
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
                child: AspectRatio(
                  aspectRatio: 1.15,
                  child: coverUrl.isNotEmpty
                      ? Image.network(
                          coverUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholder(isDark, textMuted),
                        )
                      : _buildPlaceholder(isDark, textMuted),
                ),
              ),

              // Top Left Badge
              if (badge != null)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: 9,
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
                  onTap: () => onFavoriteTap?.call(p),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      size: 14,
                      color: Colors.black87,
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
                        p['status'] as String,
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

          // ── Compact Body Details & Button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Avatar, Name & Role
                  GestureDetector(
                    onTap: () => onProfileTap?.call(p),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(p['avatar'] as String),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p['name'] as String,
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
                                p['role'] as String,
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

                  // City & Star Rating
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 11, color: Color(0xffEF4444)),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          p['city'] as String,
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
                      const Icon(Icons.star_rounded, size: 12, color: Color(0xffF59E0B)),
                      const SizedBox(width: 1),
                      Text(
                        "${p['rating']}",
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
                    children: (p['tags'] as List<String>).map((tag) {
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

                  // Standard Button Gradient Connect Button (#2E7D6E -> #1C3A5E)
                  GestureDetector(
                    onTap: () => onConnectTap?.call(p),
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
        child: Icon(Icons.image_outlined, color: textMuted.withValues(alpha: 0.6), size: 28),
      ),
    );
  }
}
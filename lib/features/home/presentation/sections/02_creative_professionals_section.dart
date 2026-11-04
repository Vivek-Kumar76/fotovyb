import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class CreativeProfessionalsSection extends StatelessWidget {
  final VoidCallback? onViewAllTap;
  final Function(Map<String, dynamic> pro)? onConnectTap;
  final Function(Map<String, dynamic> pro)? onProfileTap;
  final Function(Map<String, dynamic> pro)? onBookmarkTap;

  const CreativeProfessionalsSection({
    super.key,
    this.onViewAllTap,
    this.onConnectTap,
    this.onProfileTap,
    this.onBookmarkTap,
  });

  // Featured Creative Profiles Data
  final List<Map<String, dynamic>> pros = const [
    {
      "id": "pro_1",
      "name": "Mei Lin",
      "role": "Fashion Stylist",
      "city": "Mumbai",
      "exp": "5 yrs",
      "price": "₹12,000",
      "rating": 4.9,
      "projects": 47,
      "badge": "Top Rated",
      "status": "Available",
      "cover": "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=600",
      "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
      "industries": ["Fashion", "Luxury", "Editorial"],
      "skills": ["Editorial Styling", "Runway", "Lookbook"],
    },
    {
      "id": "pro_2",
      "name": "Kofi Mensah",
      "role": "Photographer",
      "city": "Bangalore",
      "exp": "6 yrs",
      "price": "₹18,000",
      "rating": 4.8,
      "projects": 83,
      "badge": "Featured",
      "status": "Available",
      "cover": "https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=600",
      "avatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
      "industries": ["Automotive", "Luxury", "Campaign"],
      "skills": ["Cinematic Lighting", "Color Grading", "Commercial"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Title & "View All" Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Creative Professionals",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: AppTypography.sizeLg,
                  fontWeight: AppTypography.bold,
                  color: textColor,
                ),
              ),
              GestureDetector(
                onTap: onViewAllTap,
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeSm,
                    fontWeight: AppTypography.semibold,
                    color: activeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space3),

          // ── List of Creative Profile Cards
          ...pros.map((p) => _buildProCard(context, p, isDark)),
        ],
      ),
    );
  }

  Widget _buildProCard(BuildContext context, Map<String, dynamic> p, bool isDark) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color chipBg = isDark ? AppColors.surfaceSecondaryDark : AppColors.surfaceLight;

    final String badge = p['badge'] as String;
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
        children: [
          // ── Cover Image with Overlay Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                child: Image.network(
                  p['cover'] as String,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: chipBg,
                    child: Center(
                      child: Icon(Icons.image_outlined, color: textMuted, size: 36),
                    ),
                  ),
                ),
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
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        p['status'] as String,
                        style: const TextStyle(
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

              // Badge Chip (Top Rated / Featured)
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p['name'] as String,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: AppTypography.sizeMd,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "📍 ${p['city']} · ${p['exp']}",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: AppTypography.sizeXs,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          p['price'] as String,
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
                // Avatar, Role & Rating
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(p['avatar'] as String),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p['role'] as String,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontWeight: AppTypography.bold,
                              fontSize: AppTypography.sizeSm,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "${p['projects']} projects",
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
                        children: [
                          const Icon(Icons.star_rounded, size: 14, color: Color(0xffD97706)),
                          const SizedBox(width: 2),
                          Text(
                            "${p['rating']}",
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
                  children: (p['industries'] as List<String>).map((ind) {
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
                  children: (p['skills'] as List<String>).map((sk) {
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
                    // Unified Gradient "Connect" Button (#2E7D6E -> #1C3A5E)
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () => onConnectTap?.call(p),
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
                                Icons.person_add_alt_1_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
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
                        onPressed: () => onProfileTap?.call(p),
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          size: 14,
                          color: textColor,
                        ),
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
                        icon: Icon(Icons.bookmark_border_rounded, size: 16, color: textSecondary),
                        onPressed: () => onBookmarkTap?.call(p),
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
}
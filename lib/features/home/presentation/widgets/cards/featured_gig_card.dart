import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/gig_model.dart';

class FeaturedGigCard extends StatelessWidget {
  final GigModel gig;
  final double width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onViewTap;

  const FeaturedGigCard({
    super.key,
    required this.gig,
    this.width = 240,
    this.margin,
    this.onTap,
    this.onFavoriteTap,
    this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xFFE2E8F0);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : const Color(0xFF64748B);
    const Color featuredOrange = Color(0xFFEA580C);
    const Color buttonNavy = Color(0xFF1E3A5F);

    return GestureDetector(
      onTap: onTap ?? onViewTap,
      child: Container(
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusXl,
          border: Border.all(color: borderColor, width: 1.0),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Top Cover Image with Gradient Scrim Overlay[cite: 5]
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppRadius.xl - 1),
                  ),
                  child: SizedBox(
                    height: 190,
                    width: double.infinity,
                    child: gig.coverImageUrl.isNotEmpty
                        ? Image.network(
                            gig.coverImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildPlaceholderMedia(isDark),
                          )
                        : _buildPlaceholderMedia(isDark),
                  ),
                ),

                // Bottom Gradient Scrim for text legibility[cite: 5]
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppRadius.xl - 1),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                        stops: const [0.4, 0.65, 1.0],
                      ),
                    ),
                  ),
                ),

                // Top-Left: "Featured" Tag Pill[cite: 5]
                Positioned(
                  top: AppSpacing.space2 + 2,
                  left: AppSpacing.space2 + 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: featuredOrange,
                      borderRadius: AppRadius.radiusFull,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.star, size: 10.5, color: Colors.white),
                        SizedBox(width: 3.5),
                        Text(
                          "Featured",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 10,
                            fontWeight: AppTypography.bold,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Top-Right: Favorite Button[cite: 5]
                Positioned(
                  top: AppSpacing.space2 + 2,
                  right: AppSpacing.space2 + 2,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          gig.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 17,
                          color: gig.isFavorite ? AppColors.danger : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Content Over Image: Title & Seller Row[cite: 5]
                Positioned(
                  left: AppSpacing.space3,
                  right: AppSpacing.space3,
                  bottom: AppSpacing.space2 + 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gig.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeSm + 0.5,
                          fontWeight: AppTypography.bold,
                          color: Colors.white,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 11,
                            backgroundColor: Colors.white24,
                            backgroundImage: gig.professional.avatar.isNotEmpty
                                ? NetworkImage(gig.professional.avatar)
                                : null,
                            child: gig.professional.avatar.isEmpty
                                ? Text(
                                    gig.professional.name.isNotEmpty
                                        ? gig.professional.name[0]
                                        : 'P',
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: 10,
                                      fontWeight: AppTypography.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              gig.professional.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 11.5,
                                fontWeight: AppTypography.medium,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Icon(LucideIcons.star, size: 12, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 2.5),
                          Text(
                            gig.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11.5,
                              fontWeight: AppTypography.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── Bottom Section: Starting Price, Orders & View Button[cite: 5]
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space3,
                vertical: AppSpacing.space3,
              ),
              child: Row(
                children: [
                  // From Price[cite: 5]
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 10.5,
                          color: textMuted,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        gig.formattedPrice,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeSm + 1.5,
                          fontWeight: AppTypography.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.space2),

                  // Completed Orders[cite: 5]
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.shoppingBag, size: 12.5, color: textMuted),
                        const SizedBox(width: 3.5),
                        Flexible(
                          child: Text(
                            "${gig.reviewCount} orders",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 10.5,
                              color: textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // "View" Pill Button[cite: 5]
                  GestureDetector(
                    onTap: onViewTap ?? onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                        color: buttonNavy,
                        borderRadius: AppRadius.radiusFull,
                        boxShadow: [
                          BoxShadow(
                            color: buttonNavy.withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "View",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 11.5,
                            fontWeight: AppTypography.bold,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
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

  Widget _buildPlaceholderMedia(bool isDark) {
    return Container(
      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
      child: Center(
        child: Icon(
          LucideIcons.image,
          size: 28,
          color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
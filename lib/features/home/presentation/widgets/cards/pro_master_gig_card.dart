import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/gig_model.dart';

class ProMasterGigCard extends StatelessWidget {
  final GigModel gig;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final VoidCallback? onViewGigTap;

  const ProMasterGigCard({
    super.key,
    required this.gig,
    this.width,
    this.margin,
    this.onTap,
    this.onViewGigTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xFFE2E8F0);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : const Color(0xFF64748B);
    const Color proPurple = Color(0xFF7C3AED);
    const Color buttonNavy = Color(0xFF1E3A5F);

    return GestureDetector(
      onTap: onTap ?? onViewGigTap,
      child: Container(
        width: width,
        height: 160,
        margin: margin,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: AppRadius.radiusXl,
          border: Border.all(color: borderColor, width: 1.0),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Left: Thumbnail Media with "Pro Master" Badge[cite: 13]
            ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(AppRadius.xl - 1),
              ),
              child: SizedBox(
                width: 136,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    gig.coverImageUrl.isNotEmpty
                        ? Image.network(
                            gig.coverImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildPlaceholderMedia(isDark),
                          )
                        : _buildPlaceholderMedia(isDark),

                    // Top-Left: Pro Master Tier Tag[cite: 13]
                    Positioned(
                      top: AppSpacing.space2 + 2,
                      left: AppSpacing.space2 + 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: proPurple.withValues(alpha: 0.95),
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
                            Icon(LucideIcons.award, size: 11, color: Colors.white),
                            SizedBox(width: 3),
                            Text(
                              "Pro Master",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 9.5,
                                fontWeight: AppTypography.bold,
                                color: Colors.white,
                                letterSpacing: 0.2,
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

            // ── Right: Details Column[cite: 13]
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space3,
                  vertical: AppSpacing.space2 + 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title (Headline)[cite: 13]
                    Text(
                      gig.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm + 0.5,
                        fontWeight: AppTypography.bold,
                        color: textColor,
                        height: 1.22,
                      ),
                    ),

                    // Seller Profile Row (Avatar + Name + Rating)[cite: 13]
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: borderColor,
                          backgroundImage: gig.professional.avatar.isNotEmpty
                              ? NetworkImage(gig.professional.avatar)
                              : null,
                          child: gig.professional.avatar.isEmpty
                              ? Text(
                                  gig.professional.name.isNotEmpty
                                      ? gig.professional.name[0]
                                      : 'P',
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: 9,
                                    fontWeight: AppTypography.bold,
                                    color: textColor,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: AppSpacing.space1 + 2),
                        Expanded(
                          child: Text(
                            gig.professional.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11.5,
                              fontWeight: AppTypography.medium,
                              color: textColor,
                            ),
                          ),
                        ),
                        const Icon(LucideIcons.star, size: 12, color: Color(0xFFF59E0B)),
                        const SizedBox(width: 2.5),
                        Text(
                          gig.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 11.5,
                            fontWeight: AppTypography.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),

                    // Tag Chips Row[cite: 13]
                    if (gig.tags.isNotEmpty)
                      SizedBox(
                        height: 20,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: gig.tags.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 4),
                          itemBuilder: (ctx, idx) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: AppRadius.radiusFull,
                              border: Border.all(
                                color: isDark
                                    ? const Color(0xFF475569)
                                    : const Color(0xFFCBD5E1),
                                width: 0.8,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                gig.tags[idx],
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 9.5,
                                  color: textMuted,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Delivery Turnaround & Order Count[cite: 13]
                    Row(
                      children: [
                        Icon(LucideIcons.clock, size: 11.5, color: textMuted),
                        const SizedBox(width: 3.5),
                        Text(
                          gig.deliveryTime,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 10.5,
                            color: textMuted,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.space2),
                        Icon(LucideIcons.box, size: 11.5, color: textMuted),
                        const SizedBox(width: 3.5),
                        Text(
                          "${gig.reviewCount} orders",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 10.5,
                            color: textMuted,
                          ),
                        ),
                      ],
                    ),

                    // Bottom Row: Price & "View GIG" Button[cite: 13]
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          gig.formattedPrice,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: AppTypography.sizeSm + 2,
                            fontWeight: AppTypography.bold,
                            color: textColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: onViewGigTap ?? onTap,
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
                                "View GIG",
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
                  ],
                ),
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
          size: 24,
          color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
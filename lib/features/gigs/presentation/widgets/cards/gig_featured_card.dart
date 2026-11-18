import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/gig_item_model.dart';

class GigFeaturedCard extends StatelessWidget {
  final GigItemModel gig;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onViewTap;

  const GigFeaturedCard({
    super.key,
    required this.gig,
    this.onTap,
    this.onFavoriteTap,
    this.onViewTap,
  });

  bool _isRasterAvatar(String url) {
    final trimmed = url.trim().toLowerCase();
    if (trimmed.isEmpty) return false;
    if (!trimmed.startsWith('http://') && !trimmed.startsWith('https://')) {
      return false;
    }
    return !trimmed.endsWith('.svg') && !trimmed.contains('/svg?');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xFFE2E8F0);
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textMuted =
        isDark ? AppColors.textMutedDark : const Color(0xFF64748B);
    const featuredOrange = Color(0xFFEA580C);
    const buttonNavy = Color(0xFF1E3A5F);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;
        final coverH = cardW * 0.54;
        final radius = cardW * 0.055;

        return GestureDetector(
          onTap: onTap ?? onViewTap,
          child: Container(
            width: cardW,
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: borderColor, width: 1.0),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: cardW * 0.028,
                        offset: Offset(0, cardW * 0.008),
                      ),
                    ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Top Cover Image with Gradient Scrim Overlay
                Stack(
                  children: [
                    SizedBox(
                      height: coverH,
                      width: cardW,
                      child: gig.hasValidCover
                          ? Image.network(
                              gig.coverImageUrl.trim(),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _buildPlaceholderMedia(isDark, cardW),
                            )
                          : _buildPlaceholderMedia(isDark, cardW),
                    ),

                    // Bottom Gradient Scrim for text legibility
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.12),
                              Colors.black.withValues(alpha: 0.86),
                            ],
                            stops: const [0.38, 0.64, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Top-Left: "Featured" Tag Pill
                    Positioned(
                      top: cardW * 0.03,
                      left: cardW * 0.03,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: cardW * 0.026,
                          vertical: cardW * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: featuredOrange,
                          borderRadius: BorderRadius.circular(cardW * 0.05),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: cardW * 0.012,
                              offset: Offset(0, cardW * 0.004),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.star,
                              size: cardW * 0.031,
                              color: Colors.white,
                            ),
                            SizedBox(width: cardW * 0.01),
                            Text(
                              "Featured",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: cardW * 0.028,
                                fontWeight: AppTypography.bold,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Top-Right: Favorite Button
                    Positioned(
                      top: cardW * 0.03,
                      right: cardW * 0.03,
                      child: GestureDetector(
                        onTap: onFavoriteTap,
                        child: Container(
                          width: cardW * 0.092,
                          height: cardW * 0.092,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: cardW * 0.016,
                                offset: Offset(0, cardW * 0.005),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              gig.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: cardW * 0.046,
                              color: gig.isFavorite
                                  ? AppColors.danger
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Bottom Content Over Image: Title & Seller Row
                    Positioned(
                      left: cardW * 0.036,
                      right: cardW * 0.036,
                      bottom: cardW * 0.03,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gig.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: cardW * 0.04,
                              fontWeight: AppTypography.bold,
                              color: Colors.white,
                              height: 1.24,
                            ),
                          ),
                          SizedBox(height: cardW * 0.018),
                          Row(
                            children: [
                              _buildSellerAvatar(cardW),
                              SizedBox(width: cardW * 0.018),
                              Expanded(
                                child: Text(
                                  gig.professional.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: cardW * 0.032,
                                    fontWeight: AppTypography.medium,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Icon(
                                LucideIcons.star,
                                size: cardW * 0.034,
                                color: const Color(0xFFF59E0B),
                              ),
                              SizedBox(width: cardW * 0.008),
                              Text(
                                gig.ratingDisplay,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.032,
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

                // ── Bottom Section: Starting Price, Orders & View Button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: cardW * 0.038,
                    vertical: cardW * 0.034,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "From",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: cardW * 0.029,
                              color: textMuted,
                            ),
                          ),
                          SizedBox(height: cardW * 0.004),
                          Text(
                            gig.formattedPrice,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: cardW * 0.042,
                              fontWeight: AppTypography.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: cardW * 0.035),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.shoppingBag,
                              size: cardW * 0.035,
                              color: textMuted,
                            ),
                            SizedBox(width: cardW * 0.011),
                            Flexible(
                              child: Text(
                                "${gig.reviewCount} orders",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.03,
                                  color: textMuted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: onViewTap ?? onTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: cardW * 0.048,
                            vertical: cardW * 0.022,
                          ),
                          decoration: BoxDecoration(
                            color: buttonNavy,
                            borderRadius: BorderRadius.circular(cardW * 0.05),
                            boxShadow: [
                              BoxShadow(
                                color: buttonNavy.withValues(alpha: 0.25),
                                blurRadius: cardW * 0.016,
                                offset: Offset(0, cardW * 0.005),
                              ),
                            ],
                          ),
                          child: Text(
                            "View",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: cardW * 0.032,
                              fontWeight: AppTypography.bold,
                              color: Colors.white,
                              letterSpacing: 0.2,
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
      },
    );
  }

  Widget _buildSellerAvatar(double cardW) {
    final size = cardW * 0.062;
    final avatarUrl = gig.professional.avatar.trim();

    if (_isRasterAvatar(avatarUrl)) {
      return ClipOval(
        child: Image.network(
          avatarUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildInitialAvatar(size),
        ),
      );
    }
    return _buildInitialAvatar(size);
  }

  Widget _buildInitialAvatar(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white24,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        gig.professional.initial,
        style: TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: size * 0.45,
          fontWeight: AppTypography.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPlaceholderMedia(bool isDark, double cardW) {
    return Container(
      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
      child: Center(
        child: Icon(
          LucideIcons.image,
          size: cardW * 0.085,
          color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
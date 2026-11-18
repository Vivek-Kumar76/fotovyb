import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/gig_item_model.dart';

class GigProMasterCard extends StatelessWidget {
  final GigItemModel gig;
  final VoidCallback? onTap;
  final VoidCallback? onViewGigTap;

  const GigProMasterCard({
    super.key,
    required this.gig,
    this.onTap,
    this.onViewGigTap,
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
    const proPurple = Color(0xFF7C3AED);
    const buttonNavy = Color(0xFF1E3A5F);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;
        final radius = cardW * 0.052;

        return GestureDetector(
          onTap: onTap ?? onViewGigTap,
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
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: cardW * 0.028,
                        offset: Offset(0, cardW * 0.008),
                      ),
                    ],
            ),
            clipBehavior: Clip.antiAlias,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Left 36% Thumbnail Media with "Pro Master" Badge
                  Expanded(
                    flex: 36,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (gig.hasValidCover)
                          Image.network(
                            gig.coverImageUrl.trim(),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _buildPlaceholderMedia(isDark, cardW),
                          )
                        else
                          _buildPlaceholderMedia(isDark, cardW),

                        Positioned(
                          top: cardW * 0.025,
                          left: cardW * 0.025,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: cardW * 0.021,
                              vertical: cardW * 0.009,
                            ),
                            decoration: BoxDecoration(
                              color: proPurple.withValues(alpha: 0.95),
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.045),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: cardW * 0.011,
                                  offset: Offset(0, cardW * 0.004),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.award,
                                  size: cardW * 0.03,
                                  color: Colors.white,
                                ),
                                SizedBox(width: cardW * 0.008),
                                Text(
                                  "Pro Master",
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: cardW * 0.025,
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

                  // ── Right 64% Details Column
                  Expanded(
                    flex: 64,
                    child: Padding(
                      padding: EdgeInsets.all(cardW * 0.032),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Headline
                          Text(
                            gig.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: cardW * 0.036,
                              fontWeight: AppTypography.bold,
                              color: textColor,
                              height: 1.22,
                            ),
                          ),

                          SizedBox(height: cardW * 0.018),

                          // Seller Row
                          Row(
                            children: [
                              _buildSellerAvatar(
                                cardW: cardW,
                                borderColor: borderColor,
                                textColor: textColor,
                              ),
                              SizedBox(width: cardW * 0.016),
                              Expanded(
                                child: Text(
                                  gig.professional.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: cardW * 0.031,
                                    fontWeight: AppTypography.medium,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              Icon(
                                LucideIcons.star,
                                size: cardW * 0.032,
                                color: const Color(0xFFF59E0B),
                              ),
                              SizedBox(width: cardW * 0.007),
                              Text(
                                gig.ratingDisplay,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.031,
                                  fontWeight: AppTypography.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),

                          if (gig.tags.isNotEmpty) ...[
                            SizedBox(height: cardW * 0.018),
                            Wrap(
                              spacing: cardW * 0.012,
                              runSpacing: cardW * 0.01,
                              children: gig.tags.take(3).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: cardW * 0.02,
                                    vertical: cardW * 0.006,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(cardW * 0.04),
                                    border: Border.all(
                                      color: isDark
                                          ? const Color(0xFF475569)
                                          : const Color(0xFFCBD5E1),
                                      width: 0.8,
                                    ),
                                  ),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: cardW * 0.025,
                                      color: textMuted,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],

                          SizedBox(height: cardW * 0.018),

                          // Delivery Turnaround & Order Count
                          Row(
                            children: [
                              Icon(
                                LucideIcons.clock,
                                size: cardW * 0.031,
                                color: textMuted,
                              ),
                              SizedBox(width: cardW * 0.01),
                              Text(
                                gig.deliveryTime,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.028,
                                  color: textMuted,
                                ),
                              ),
                              SizedBox(width: cardW * 0.024),
                              Icon(
                                LucideIcons.box,
                                size: cardW * 0.031,
                                color: textMuted,
                              ),
                              SizedBox(width: cardW * 0.01),
                              Text(
                                "${gig.reviewCount} orders",
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.028,
                                  color: textMuted,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: cardW * 0.024),

                          // Bottom Row: Price & "View GIG" Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  gig.formattedPrice,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: cardW * 0.04,
                                    fontWeight: AppTypography.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: cardW * 0.02),
                              GestureDetector(
                                onTap: onViewGigTap ?? onTap,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: cardW * 0.042,
                                    vertical: cardW * 0.019,
                                  ),
                                  decoration: BoxDecoration(
                                    color: buttonNavy,
                                    borderRadius:
                                        BorderRadius.circular(cardW * 0.05),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            buttonNavy.withValues(alpha: 0.25),
                                        blurRadius: cardW * 0.016,
                                        offset: Offset(0, cardW * 0.005),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "View GIG",
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: cardW * 0.03,
                                      fontWeight: AppTypography.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.2,
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
          ),
        );
      },
    );
  }

  Widget _buildSellerAvatar({
    required double cardW,
    required Color borderColor,
    required Color textColor,
  }) {
    final size = cardW * 0.055;
    final avatarUrl = gig.professional.avatar.trim();

    if (_isRasterAvatar(avatarUrl)) {
      return ClipOval(
        child: Image.network(
          avatarUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              _buildInitialAvatar(size, borderColor, textColor),
        ),
      );
    }
    return _buildInitialAvatar(size, borderColor, textColor);
  }

  Widget _buildInitialAvatar(double size, Color borderColor, Color textColor) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: borderColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        gig.professional.initial,
        style: TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: size * 0.45,
          fontWeight: AppTypography.bold,
          color: textColor,
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
          size: cardW * 0.068,
          color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/gig_item_model.dart';

class GigHighPriorityCard extends StatefulWidget {
  final GigItemModel gig;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onChatTap;
  final ValueChanged<GigPackageTierItem>? onTierSelected;

  const GigHighPriorityCard({
    super.key,
    required this.gig,
    this.onTap,
    this.onFavoriteTap,
    this.onChatTap,
    this.onTierSelected,
  });

  @override
  State<GigHighPriorityCard> createState() => _GigHighPriorityCardState();
}

class _GigHighPriorityCardState extends State<GigHighPriorityCard> {
  late int _selectedTierIndex;

  @override
  void initState() {
    super.initState();
    _selectedTierIndex = widget.gig.packageTiers.length > 1 ? 1 : 0;
  }

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
    final activeTeal =
        isDark ? const Color(0xFF14B8A6) : const Color(0xFF0F766E);
    const activeNavy = Color(0xFF1E3A5F);

    final tiers = widget.gig.packageTiers;
    final safeTierIndex =
        tiers.isEmpty ? 0 : _selectedTierIndex.clamp(0, tiers.length - 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;
        final coverH = cardW * 0.52;
        final radius = cardW * 0.055;

        return Container(
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
                      blurRadius: cardW * 0.036,
                      offset: Offset(0, cardW * 0.011),
                    ),
                  ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Media Cover with Overlays
              Stack(
                children: [
                  SizedBox(
                    height: coverH,
                    width: cardW,
                    child: widget.gig.hasValidCover
                        ? Image.network(
                            widget.gig.coverImageUrl.trim(),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _buildPlaceholderMedia(isDark, cardW),
                          )
                        : _buildPlaceholderMedia(isDark, cardW),
                  ),

                  // Top-Left: High Priority Tier Badge
                  Positioned(
                    top: cardW * 0.032,
                    left: cardW * 0.032,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: cardW * 0.028,
                        vertical: cardW * 0.014,
                      ),
                      decoration: BoxDecoration(
                        color: activeTeal.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(cardW * 0.05),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: cardW * 0.012,
                            offset: Offset(0, cardW * 0.005),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.sparkles,
                            size: cardW * 0.034,
                            color: Colors.white,
                          ),
                          SizedBox(width: cardW * 0.011),
                          Text(
                            "High Priority",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: cardW * 0.029,
                              fontWeight: AppTypography.bold,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Top-Right: Favorite Bookmark Button
                  Positioned(
                    top: cardW * 0.032,
                    right: cardW * 0.032,
                    child: GestureDetector(
                      onTap: widget.onFavoriteTap,
                      child: Container(
                        width: cardW * 0.095,
                        height: cardW * 0.095,
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.surfaceDark.withValues(alpha: 0.88)
                              : Colors.white.withValues(alpha: 0.92),
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
                            widget.gig.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: cardW * 0.048,
                            color: widget.gig.isFavorite
                                ? AppColors.danger
                                : textColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom-Left: Subcategory / Category Pill
                  Positioned(
                    bottom: cardW * 0.028,
                    left: cardW * 0.032,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: cardW * 0.026,
                        vertical: cardW * 0.011,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.68),
                        borderRadius: BorderRadius.circular(cardW * 0.05),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: cardW * 0.016,
                            height: cardW * 0.016,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: cardW * 0.014),
                          Text(
                            widget.gig.subcategory.isNotEmpty
                                ? widget.gig.subcategory
                                : widget.gig.category,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: cardW * 0.03,
                              fontWeight: AppTypography.medium,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // ── Card Details Body
              Padding(
                padding: EdgeInsets.all(cardW * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seller Profile Header
                    Row(
                      children: [
                        _buildSellerAvatar(
                          cardW: cardW,
                          borderColor: borderColor,
                          textColor: textColor,
                        ),
                        SizedBox(width: cardW * 0.028),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.gig.professional.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.037,
                                  fontWeight: AppTypography.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                "${widget.gig.professional.badge} · ${widget.gig.professional.city}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.03,
                                  color: textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.star,
                              size: cardW * 0.038,
                              color: const Color(0xFFF59E0B),
                            ),
                            SizedBox(width: cardW * 0.008),
                            Text(
                              widget.gig.ratingDisplay,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: cardW * 0.035,
                                fontWeight: AppTypography.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: cardW * 0.032),

                    // Gig Headline
                    Text(
                      widget.gig.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: cardW * 0.041,
                        fontWeight: AppTypography.bold,
                        color: textColor,
                        height: 1.25,
                      ),
                    ),

                    if (widget.gig.tags.isNotEmpty) ...[
                      SizedBox(height: cardW * 0.028),
                      Wrap(
                        spacing: cardW * 0.015,
                        runSpacing: cardW * 0.015,
                        children: widget.gig.tags.take(4).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: cardW * 0.024,
                              vertical: cardW * 0.009,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.045),
                              border: Border.all(
                                color: activeTeal.withValues(alpha: 0.45),
                                width: 0.9,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: cardW * 0.028,
                                fontWeight: AppTypography.medium,
                                color: activeTeal,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    SizedBox(height: cardW * 0.032),

                    // Delivery & Orders Metadata
                    Row(
                      children: [
                        Icon(
                          LucideIcons.clock,
                          size: cardW * 0.036,
                          color: textMuted,
                        ),
                        SizedBox(width: cardW * 0.012),
                        Text(
                          widget.gig.deliveryTime,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: cardW * 0.031,
                            color: textMuted,
                          ),
                        ),
                        SizedBox(width: cardW * 0.035),
                        Icon(
                          LucideIcons.box,
                          size: cardW * 0.036,
                          color: textMuted,
                        ),
                        SizedBox(width: cardW * 0.012),
                        Text(
                          "${widget.gig.reviewCount} orders",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: cardW * 0.031,
                            color: textMuted,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: cardW * 0.036),

                    // ── 3-Tier Package Pricing Selectors
                    Row(
                      children: List.generate(tiers.length, (idx) {
                        final tier = tiers[idx];
                        final isSelected = safeTierIndex == idx;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _selectedTierIndex = idx);
                              widget.onTierSelected?.call(tier);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right:
                                    idx < tiers.length - 1 ? cardW * 0.022 : 0,
                              ),
                              padding:
                                  EdgeInsets.symmetric(vertical: cardW * 0.022),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (isDark
                                        ? activeTeal.withValues(alpha: 0.15)
                                        : const Color(0xFFF0FDFA))
                                    : (isDark
                                        ? const Color(0xFF1E293B)
                                        : const Color(0xFFF8FAFC)),
                                borderRadius:
                                    BorderRadius.circular(cardW * 0.032),
                                border: Border.all(
                                  color: isSelected ? activeTeal : borderColor,
                                  width: isSelected ? 1.4 : 1.0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tier.label,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: cardW * 0.028,
                                      color:
                                          isSelected ? activeTeal : textMuted,
                                      fontWeight: isSelected
                                          ? AppTypography.bold
                                          : AppTypography.medium,
                                    ),
                                  ),
                                  SizedBox(height: cardW * 0.006),
                                  Text(
                                    tier.priceDisplay,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: cardW * 0.034,
                                      fontWeight: AppTypography.bold,
                                      color:
                                          isSelected ? activeTeal : textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: cardW * 0.036),

                    // ── Footer CTA Actions: "View GIG" & Chat Icon
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: widget.onTap,
                            child: Container(
                              height: cardW * 0.118,
                              decoration: BoxDecoration(
                                color: activeNavy,
                                borderRadius:
                                    BorderRadius.circular(cardW * 0.06),
                                boxShadow: [
                                  BoxShadow(
                                    color: activeNavy.withValues(alpha: 0.25),
                                    blurRadius: cardW * 0.022,
                                    offset: Offset(0, cardW * 0.008),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "View GIG",
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: cardW * 0.036,
                                    fontWeight: AppTypography.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: cardW * 0.026),
                        GestureDetector(
                          onTap: widget.onChatTap,
                          child: Container(
                            width: cardW * 0.118,
                            height: cardW * 0.118,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: borderColor, width: 1.2),
                            ),
                            child: Center(
                              child: Icon(
                                LucideIcons.messageSquare,
                                size: cardW * 0.048,
                                color: textColor,
                              ),
                            ),
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
      },
    );
  }

  Widget _buildSellerAvatar({
    required double cardW,
    required Color borderColor,
    required Color textColor,
  }) {
    final size = cardW * 0.095;
    final avatarUrl = widget.gig.professional.avatar.trim();

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
        widget.gig.professional.initial,
        style: TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: size * 0.42,
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
          size: cardW * 0.09,
          color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
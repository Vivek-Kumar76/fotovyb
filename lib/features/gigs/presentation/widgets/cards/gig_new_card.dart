import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/gig_item_model.dart';

class GigNewCard extends StatefulWidget {
  final GigItemModel gig;
  final VoidCallback? onViewGig;
  final VoidCallback? onChat;
  final VoidCallback? onBookmark;
  final ValueChanged<GigPackageTierItem>? onTierSelected;

  const GigNewCard({
    super.key,
    required this.gig,
    this.onViewGig,
    this.onChat,
    this.onBookmark,
    this.onTierSelected,
  });

  @override
  State<GigNewCard> createState() => _GigNewCardState();
}

class _GigNewCardState extends State<GigNewCard> {
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
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

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
        final radius = cardW * 0.056;

        return Container(
          width: cardW,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: cardW * 0.028,
                      offset: Offset(0, cardW * 0.011),
                    ),
                  ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Cover Image with "New" Badge
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
                  Positioned(
                    top: cardW * 0.032,
                    left: cardW * 0.032,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: cardW * 0.028,
                        vertical: cardW * 0.012,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff0D9488),
                        borderRadius: BorderRadius.circular(cardW * 0.052),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: cardW * 0.032,
                            color: Colors.white,
                          ),
                          SizedBox(width: cardW * 0.011),
                          Text(
                            "New",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: cardW * 0.03,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: cardW * 0.032,
                    left: cardW * 0.032,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: cardW * 0.028,
                        vertical: cardW * 0.012,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(cardW * 0.052),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: cardW * 0.008,
                            backgroundColor: const Color(0xff10B981),
                          ),
                          SizedBox(width: cardW * 0.014),
                          Text(
                            widget.gig.category,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: cardW * 0.029,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: cardW * 0.032,
                    right: cardW * 0.032,
                    child: GestureDetector(
                      onTap: widget.onBookmark,
                      child: Container(
                        width: cardW * 0.092,
                        height: cardW * 0.092,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.gig.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: widget.gig.isFavorite
                              ? const Color(0xffEF4444)
                              : const Color(0xff1E293B),
                          size: cardW * 0.048,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // ── Card Body
              Padding(
                padding: EdgeInsets.all(cardW * 0.042),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  fontSize: cardW * 0.036,
                                  fontWeight: FontWeight.w800,
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
                                  color: textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: cardW * 0.044,
                              color: const Color(0xffF59E0B),
                            ),
                            SizedBox(width: cardW * 0.006),
                            Text(
                              widget.gig.ratingDisplay,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: cardW * 0.034,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: cardW * 0.028),

                    Text(
                      widget.gig.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: cardW * 0.04,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                        color: textColor,
                      ),
                    ),

                    if (widget.gig.tags.isNotEmpty) ...[
                      SizedBox(height: cardW * 0.028),
                      Wrap(
                        spacing: cardW * 0.016,
                        runSpacing: cardW * 0.016,
                        children: widget.gig.tags.take(4).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: cardW * 0.026,
                              vertical: cardW * 0.011,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xff1E293B)
                                  : const Color(0xffF1F5F9),
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.042),
                              border: Border.all(
                                color: const Color(0xff0D9488)
                                    .withValues(alpha: 0.18),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: cardW * 0.028,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff0F766E),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    SizedBox(height: cardW * 0.032),

                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: cardW * 0.038,
                          color: textSecondary,
                        ),
                        SizedBox(width: cardW * 0.011),
                        Text(
                          widget.gig.deliveryTime,
                          style: TextStyle(
                            fontSize: cardW * 0.031,
                            color: textSecondary,
                          ),
                        ),
                        SizedBox(width: cardW * 0.036),
                        Icon(
                          Icons.inventory_2_outlined,
                          size: cardW * 0.038,
                          color: textSecondary,
                        ),
                        SizedBox(width: cardW * 0.011),
                        Text(
                          "${widget.gig.reviewCount} orders",
                          style: TextStyle(
                            fontSize: cardW * 0.031,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: cardW * 0.036),

                    // Tiers
                    Row(
                      children: List.generate(tiers.length, (idx) {
                        final t = tiers[idx];
                        final isSelected = safeTierIndex == idx;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _selectedTierIndex = idx);
                              widget.onTierSelected?.call(t);
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
                                        ? const Color(0xff0D9488)
                                            .withValues(alpha: 0.18)
                                        : const Color(0xffF0FDFA))
                                    : (isDark
                                        ? const Color(0xff1E293B)
                                        : const Color(0xffF8FAFC)),
                                borderRadius:
                                    BorderRadius.circular(cardW * 0.048),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xff0D9488)
                                      : borderColor,
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    t.label,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: cardW * 0.028,
                                      fontWeight: FontWeight.w600,
                                      color: textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: cardW * 0.006),
                                  Text(
                                    t.priceDisplay,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: cardW * 0.034,
                                      fontWeight: FontWeight.w800,
                                      color: isSelected
                                          ? const Color(0xff0D9488)
                                          : textColor,
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

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: widget.onViewGig,
                            child: Container(
                              height: cardW * 0.118,
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonGradientCreative,
                                borderRadius:
                                    BorderRadius.circular(cardW * 0.064),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "View GIG",
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  color: Colors.white,
                                  fontSize: cardW * 0.036,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: cardW * 0.026),
                        GestureDetector(
                          onTap: widget.onChat,
                          child: Container(
                            width: cardW * 0.118,
                            height: cardW * 0.118,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? const Color(0xff1E293B)
                                  : const Color(0xffF1F5F9),
                              border: Border.all(color: borderColor),
                            ),
                            child: Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: textColor,
                              size: cardW * 0.048,
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
    final size = cardW * 0.092;
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
          fontWeight: FontWeight.w800,
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
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/gig_model.dart';

class HighPriorityGigCard extends StatefulWidget {
  final GigModel gig;
  final double width;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onChatTap;
  final Function(GigPackageTier tier)? onTierSelected;

  const HighPriorityGigCard({
    super.key,
    required this.gig,
    this.width = 330,
    this.margin,
    this.onTap,
    this.onFavoriteTap,
    this.onChatTap,
    this.onTierSelected,
  });

  @override
  State<HighPriorityGigCard> createState() => _HighPriorityGigCardState();
}

class _HighPriorityGigCardState extends State<HighPriorityGigCard> {
  int _selectedTierIndex = 1; // Default to "Standard" tier

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xFFE2E8F0);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : const Color(0xFF64748B);
    final Color activeTeal = isDark ? const Color(0xFF14B8A6) : const Color(0xFF0F766E);
    final Color activeNavy = const Color(0xFF1E3A5F);

    final tiers = widget.gig.packageTiers;

    return Container(
      width: widget.width,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: AppRadius.radiusXl,
        border: Border.all(color: borderColor, width: 1.0),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Media Cover with Overlays
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl - 1)),
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: widget.gig.coverImageUrl.isNotEmpty
                      ? Image.network(
                          widget.gig.coverImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildPlaceholderMedia(isDark),
                        )
                      : _buildPlaceholderMedia(isDark),
                ),
              ),

              // Top-Left: High Priority Tier Badge
              Positioned(
                top: AppSpacing.space3,
                left: AppSpacing.space3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: activeTeal.withValues(alpha: 0.92),
                    borderRadius: AppRadius.radiusFull,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LucideIcons.sparkles, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "High Priority",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 10.5,
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
                top: AppSpacing.space3,
                right: AppSpacing.space3,
                child: GestureDetector(
                  onTap: widget.onFavoriteTap,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceDark.withValues(alpha: 0.85)
                          : Colors.white.withValues(alpha: 0.9),
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
                        widget.gig.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        size: 18,
                        color: widget.gig.isFavorite ? AppColors.danger : textColor,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom-Left: Subcategory / Category Pill with Indicator Dot
              Positioned(
                bottom: AppSpacing.space2 + 2,
                left: AppSpacing.space3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: AppRadius.radiusFull,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.gig.subcategory.isNotEmpty
                            ? widget.gig.subcategory
                            : widget.gig.category,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 11,
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
            padding: const EdgeInsets.all(AppSpacing.space3 + 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Seller Profile Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: borderColor,
                      backgroundImage: widget.gig.professional.avatar.isNotEmpty
                          ? NetworkImage(widget.gig.professional.avatar)
                          : null,
                      child: widget.gig.professional.avatar.isEmpty
                          ? Text(
                              widget.gig.professional.name.isNotEmpty
                                  ? widget.gig.professional.name[0]
                                  : 'P',
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 13,
                                fontWeight: AppTypography.bold,
                                color: textColor,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.space2 + 2),
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
                              fontSize: AppTypography.sizeSm + 0.5,
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
                              fontSize: 11,
                              color: textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.star, size: 14, color: Color(0xFFF59E0B)),
                        const SizedBox(width: 3),
                        Text(
                          widget.gig.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: AppTypography.sizeSm,
                            fontWeight: AppTypography.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space3),

                // Gig Headline
                Text(
                  widget.gig.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeSm + 1,
                    fontWeight: AppTypography.bold,
                    color: textColor,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: AppSpacing.space2 + 2),

                // Tags Horizontal Row
                if (widget.gig.tags.isNotEmpty)
                  SizedBox(
                    height: 24,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.gig.tags.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 5),
                      itemBuilder: (ctx, idx) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: AppRadius.radiusFull,
                          border: Border.all(
                            color: isDark
                                ? activeTeal.withValues(alpha: 0.4)
                                : activeTeal.withValues(alpha: 0.5),
                            width: 0.9,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.gig.tags[idx],
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 10,
                              fontWeight: AppTypography.medium,
                              color: activeTeal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.space3),

                // Delivery & Orders Metadata
                Row(
                  children: [
                    Icon(LucideIcons.clock, size: 13, color: textMuted),
                    const SizedBox(width: 4),
                    Text(
                      widget.gig.deliveryTime,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 11,
                        color: textMuted,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space3),
                    Icon(LucideIcons.box, size: 13, color: textMuted),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.gig.reviewCount} orders",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 11,
                        color: textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space3 + 2),

                // ── 3-Tier Package Pricing Selectors
                Row(
                  children: List.generate(tiers.length, (idx) {
                    final tier = tiers[idx];
                    final isSelected = _selectedTierIndex == idx;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedTierIndex = idx);
                          widget.onTierSelected?.call(tier);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: idx < tiers.length - 1 ? AppSpacing.space2 : 0,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark
                                    ? activeTeal.withValues(alpha: 0.15)
                                    : const Color(0xFFF0FDFA))
                                : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC)),
                            borderRadius: AppRadius.radiusMd,
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
                                  fontSize: 10,
                                  color: isSelected ? activeTeal : textMuted,
                                  fontWeight: isSelected
                                      ? AppTypography.bold
                                      : AppTypography.medium,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                tier.price,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 12,
                                  fontWeight: AppTypography.bold,
                                  color: isSelected ? activeTeal : textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: AppSpacing.space3 + 2),

                // ── Footer CTA Actions: "View GIG" & Chat Icon
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: activeNavy,
                            borderRadius: AppRadius.radiusFull,
                            boxShadow: [
                              BoxShadow(
                                color: activeNavy.withValues(alpha: 0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "View GIG",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: AppTypography.sizeSm,
                                fontWeight: AppTypography.bold,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space2 + 2),
                    GestureDetector(
                      onTap: widget.onChatTap,
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: borderColor, width: 1.2),
                        ),
                        child: Center(
                          child: Icon(
                            LucideIcons.messageSquare,
                            size: 18,
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
  }

  Widget _buildPlaceholderMedia(bool isDark) {
    return Container(
      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
      child: Center(
        child: Icon(
          LucideIcons.image,
          size: 32,
          color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
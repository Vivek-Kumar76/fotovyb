import 'package:flutter/material.dart';
import '../../../core/tokens/tokens.dart';
import '../../home/data/models/creative_pro_model.dart';

class ProsTierCarouselSection extends StatelessWidget {
  final String title;
  final String badgeLabel;
  final IconData headerIcon;
  final Color accentColor;
  final List<CreativeProModel> items;
  final bool isLoading;
  final String emptyMessage;
  final VoidCallback? onViewAllTap;
  final ValueChanged<CreativeProModel>? onConnectTap;
  final ValueChanged<CreativeProModel>? onViewTap;

  const ProsTierCarouselSection({
    super.key,
    required this.title,
    required this.badgeLabel,
    required this.headerIcon,
    required this.accentColor,
    required this.items,
    required this.isLoading,
    required this.emptyMessage,
    this.onViewAllTap,
    this.onConnectTap,
    this.onViewTap,
  });

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

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final maxW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth;

        // Responsive percentage-based dimensions
        final horizontalPadding = maxW * 0.04;
        final headerBadgeSize = maxW * 0.08;
        final headerGap = maxW * 0.022;
        final sectionGap = maxW * 0.035;
        final itemGap = maxW * 0.035;

        // Card width as a percentage of viewport width, height by aspect ratio
        final widthFraction = maxW >= 900
            ? 0.24
            : (maxW >= 600 ? 0.38 : 0.64);
        final cardWidth = maxW * widthFraction;
        final cardHeight = cardWidth * 1.38;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: headerBadgeSize,
                        height: headerBadgeSize,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          headerIcon,
                          color: Colors.white,
                          size: headerBadgeSize * 0.55,
                        ),
                      ),
                      SizedBox(width: headerGap),
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: maxW * 0.041,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  if (items.isNotEmpty && onViewAllTap != null)
                    GestureDetector(
                      onTap: onViewAllTap,
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: maxW * 0.032,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff0D9488),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: sectionGap),

            // ── Shimmer Loading / Empty State / Live Horizontal Carousel
            if (isLoading && items.isEmpty)
              SizedBox(
                height: cardHeight,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  separatorBuilder: (_, __) => SizedBox(width: itemGap),
                  itemBuilder: (_, __) => SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: _buildSkeletonCard(cardBg, borderColor),
                  ),
                ),
              )
            else if (items.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: maxW * 0.04,
                    vertical: maxW * 0.048,
                  ),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(maxW * 0.05),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(maxW * 0.025),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          headerIcon,
                          size: maxW * 0.05,
                          color: accentColor,
                        ),
                      ),
                      SizedBox(width: maxW * 0.03),
                      Expanded(
                        child: Text(
                          emptyMessage,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: maxW * 0.032,
                            fontWeight: FontWeight.w600,
                            color: textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SizedBox(
                height: cardHeight,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => SizedBox(width: itemGap),
                  itemBuilder: (ctx, idx) => SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: ProsTierProCard(
                      pro: items[idx],
                      badgeLabel: badgeLabel,
                      accentColor: accentColor,
                      onConnect: () => onConnectTap?.call(items[idx]),
                      onView: () => onViewTap?.call(items[idx]),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSkeletonCard(Color cardBg, Color borderColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardW = constraints.maxWidth;
        final cardH = constraints.maxHeight;
        final bottomH = cardH * 0.35;

        return Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(cardW * 0.088),
            border: Border.all(color: borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Expanded(
                flex: 65,
                child: Container(color: const Color(0xffE2E8F0)),
              ),
              Expanded(
                flex: 35,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: cardW * 0.048,
                    vertical: bottomH * 0.08,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 48,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: bottomH * 0.14,
                              backgroundColor: const Color(0xffE2E8F0),
                            ),
                            SizedBox(width: cardW * 0.032),
                            Expanded(
                              child: Container(
                                height: bottomH * 0.14,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE2E8F0),
                                  borderRadius:
                                      BorderRadius.circular(cardW * 0.025),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: bottomH * 0.06),
                      Expanded(
                        flex: 46,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffE2E8F0),
                            borderRadius: BorderRadius.circular(cardW * 0.08),
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
      },
    );
  }
}

class ProsTierProCard extends StatelessWidget {
  final CreativeProModel pro;
  final String badgeLabel;
  final Color accentColor;
  final VoidCallback? onConnect;
  final VoidCallback? onView;

  const ProsTierProCard({
    super.key,
    required this.pro,
    required this.badgeLabel,
    required this.accentColor,
    this.onConnect,
    this.onView,
  });

  bool _isValidUrl(String url) {
    final trimmed = url.trim();
    return trimmed.isNotEmpty &&
        (trimmed.startsWith('http://') || trimmed.startsWith('https://'));
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

    final coverUrl = _isValidUrl(pro.cardDisplayImageUrl)
        ? pro.cardDisplayImageUrl.trim()
        : (_isValidUrl(pro.coverImage) ? pro.coverImage.trim() : '');

    final hasAvatar = _isValidUrl(pro.avatar);
    final initial =
        pro.fullName.isNotEmpty ? pro.fullName[0].toUpperCase() : 'C';

    final subtitleMeta = pro.projectCount > 0
        ? '${pro.projectCount} projects'
        : (pro.experienceYears > 0
            ? '${pro.experienceYears} yrs exp'
            : (pro.subCategories.length > 1
                ? pro.subCategories[1]
                : (pro.isAvailable ? 'Available' : 'Creative Pro')));

    final priceUnit = pro.startingPrice.isEmpty
        ? 'rate'
        : (pro.startingPrice.contains('/') ? 'rate' : '/ day');

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.64;
        final cardH = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : cardW * 1.38;

        final topH = cardH * 0.65;
        final bottomH = cardH * 0.35;

        return Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(cardW * 0.088),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: cardW * 0.04,
                offset: Offset(0, cardH * 0.012),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── 65% Cover Image + Badges + Name/Location/Rate Overlay
              Expanded(
                flex: 65,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (coverUrl.isNotEmpty)
                      Image.network(
                        coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildFallbackCover(cardW),
                      )
                    else
                      _buildFallbackCover(cardW),

                    // Bottom gradient vignette
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.2),
                            Colors.black.withValues(alpha: 0.85),
                          ],
                          stops: const [0.5, 0.7, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                    // Top-Left Section Tier Badge
                    Positioned(
                      top: topH * 0.045,
                      left: cardW * 0.04,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: cardW * 0.032,
                          vertical: topH * 0.016,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(cardW * 0.056),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: cardW * 0.044,
                              color: Colors.white,
                            ),
                            SizedBox(width: cardW * 0.012),
                            Text(
                              badgeLabel.toUpperCase(),
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Colors.white,
                                fontSize: cardW * 0.036,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Top-Right Top Rated Badge
                    if (pro.isTopRated)
                      Positioned(
                        top: topH * 0.045,
                        right: cardW * 0.04,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: cardW * 0.032,
                            vertical: topH * 0.016,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffB45309),
                            borderRadius: BorderRadius.circular(cardW * 0.056),
                          ),
                          child: Text(
                            "Top Rated",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: cardW * 0.038,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                    // Bottom Overlay: Name, Location & Price
                    Positioned(
                      bottom: topH * 0.045,
                      left: cardW * 0.048,
                      right: cardW * 0.048,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  pro.fullName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    color: Colors.white,
                                    fontSize: cardW * 0.06,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      size: cardW * 0.044,
                                      color: Colors.white70,
                                    ),
                                    SizedBox(width: cardW * 0.008),
                                    Flexible(
                                      child: Text(
                                        pro.location,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: cardW * 0.044,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: cardW * 0.024),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                pro.formattedPrice,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  color: Colors.white,
                                  fontSize: cardW * 0.056,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                priceUnit,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: cardW * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── 35% Avatar, Role, Rating & Action Buttons
              Expanded(
                flex: 35,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: cardW * 0.048,
                    vertical: bottomH * 0.08,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 48,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: bottomH * 0.14,
                              backgroundColor:
                                  accentColor.withValues(alpha: 0.16),
                              backgroundImage: hasAvatar
                                  ? NetworkImage(pro.avatar.trim())
                                  : null,
                              child: !hasAvatar
                                  ? Text(
                                      initial,
                                      style: TextStyle(
                                        fontFamily:
                                            AppTypography.fontFamilySans,
                                        fontWeight: FontWeight.w800,
                                        fontSize: cardW * 0.052,
                                        color: accentColor,
                                      ),
                                    )
                                  : null,
                            ),
                            SizedBox(width: cardW * 0.032),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    pro.role,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: cardW * 0.048,
                                      fontWeight: FontWeight.w800,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    subtitleMeta,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: cardW * 0.041,
                                      color: textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: cardW * 0.028,
                                vertical: bottomH * 0.025,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFEF3C7),
                                borderRadius:
                                    BorderRadius.circular(cardW * 0.048),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    size: cardW * 0.05,
                                    color: const Color(0xffD97706),
                                  ),
                                  SizedBox(width: cardW * 0.008),
                                  Text(
                                    pro.ratingDisplay,
                                    style: TextStyle(
                                      fontSize: cardW * 0.044,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xff92400E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: bottomH * 0.06),
                      Expanded(
                        flex: 46,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: onConnect,
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.buttonGradientCreative,
                                    borderRadius:
                                        BorderRadius.circular(cardW * 0.08),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_add_alt_1_rounded,
                                        size: cardW * 0.05,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: cardW * 0.016),
                                      Text(
                                        "Connect",
                                        style: TextStyle(
                                          fontFamily:
                                              AppTypography.fontFamilySans,
                                          color: Colors.white,
                                          fontSize: cardW * 0.044,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: cardW * 0.032),
                            Expanded(
                              child: GestureDetector(
                                onTap: onView,
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: cardBg,
                                    borderRadius:
                                        BorderRadius.circular(cardW * 0.08),
                                    border: Border.all(color: borderColor),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: cardW * 0.05,
                                        color: textColor,
                                      ),
                                      SizedBox(width: cardW * 0.016),
                                      Text(
                                        "View",
                                        style: TextStyle(
                                          fontFamily:
                                              AppTypography.fontFamilySans,
                                          color: textColor,
                                          fontSize: cardW * 0.044,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
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
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFallbackCover(double cardW) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff0F2942), Color(0xff134E4A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.camera_alt_outlined,
          size: cardW * 0.17,
          color: Colors.white.withValues(alpha: 0.25),
        ),
      ),
    );
  }
}
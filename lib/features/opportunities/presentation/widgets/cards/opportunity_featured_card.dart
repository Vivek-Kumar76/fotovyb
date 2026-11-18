import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/opportunity_item_model.dart';

class OpportunityFeaturedCard extends StatelessWidget {
  final OpportunityItemModel opportunity;
  final VoidCallback? onView;

  const OpportunityFeaturedCard({
    super.key,
    required this.opportunity,
    this.onView,
  });

  ({IconData icon, Color bg, Color fg}) _resolveCategoryBadge() {
    final fingerprint =
        '${opportunity.category} ${opportunity.title}'.toLowerCase();

    if (fingerprint.contains('jewel') ||
        fingerprint.contains('bridal') ||
        fingerprint.contains('luxury') ||
        fingerprint.contains('fashion')) {
      return (
        icon: Icons.diamond_outlined,
        bg: const Color(0xffFEF3C7),
        fg: const Color(0xffD97706),
      );
    }
    if (fingerprint.contains('sport') ||
        fingerprint.contains('fitness') ||
        fingerprint.contains('athleisure')) {
      return (
        icon: Icons.show_chart_rounded,
        bg: const Color(0xffCCFBF1),
        fg: const Color(0xff0D9488),
      );
    }
    if (fingerprint.contains('food') ||
        fingerprint.contains('beverage') ||
        fingerprint.contains('reel') ||
        fingerprint.contains('social') ||
        fingerprint.contains('cafe')) {
      return (
        icon: Icons.coffee_outlined,
        bg: const Color(0xffFEF3C7),
        fg: const Color(0xffB45309),
      );
    }
    if (fingerprint.contains('travel') ||
        fingerprint.contains('tourism') ||
        fingerprint.contains('destination')) {
      return (
        icon: Icons.location_on_outlined,
        bg: const Color(0xffDBEAFE),
        fg: const Color(0xff2563EB),
      );
    }
    return (
      icon: Icons.camera_alt_outlined,
      bg: const Color(0xffE0F2FE),
      fg: const Color(0xff0284C7),
    );
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
    final pillBg = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xffF1F5F9);
    final pillText =
        isDark ? AppColors.textSecondaryDark : const Color(0xff475569);

    final badge = _resolveCategoryBadge();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.44;

        return GestureDetector(
          onTap: onView,
          child: Container(
            width: cardW,
            padding: EdgeInsets.all(cardW * 0.072),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(cardW * 0.11),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.025),
                  blurRadius: cardW * 0.05,
                  offset: Offset(0, cardW * 0.015),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Circular Category Icon
                    Container(
                      padding: EdgeInsets.all(cardW * 0.042),
                      decoration: BoxDecoration(
                        color: badge.bg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        badge.icon,
                        size: cardW * 0.095,
                        color: badge.fg,
                      ),
                    ),
                    SizedBox(height: cardW * 0.05),

                    // ── 2-Line Title
                    Text(
                      opportunity.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: cardW * 0.074,
                        fontWeight: FontWeight.w800,
                        height: 1.24,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: cardW * 0.02),

                    // ── Subtitle / Description
                    Text(
                      opportunity.description.isNotEmpty
                          ? opportunity.description
                          : opportunity.brand,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: cardW * 0.062,
                        color: textSecondary,
                      ),
                    ),
                    SizedBox(height: cardW * 0.036),

                    // ── Location Row
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: cardW * 0.072,
                          color: textSecondary,
                        ),
                        SizedBox(width: cardW * 0.015),
                        Expanded(
                          child: Text(
                            opportunity.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: cardW * 0.062,
                              color: textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (opportunity.roles.isNotEmpty) ...[
                      SizedBox(height: cardW * 0.038),
                      Wrap(
                        spacing: cardW * 0.025,
                        runSpacing: cardW * 0.024,
                        children: opportunity.roles.take(2).map((role) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: cardW * 0.04,
                              vertical: cardW * 0.015,
                            ),
                            decoration: BoxDecoration(
                              color: pillBg,
                              borderRadius: BorderRadius.circular(cardW * 0.06),
                            ),
                            child: Text(
                              role,
                              style: TextStyle(
                                fontSize: cardW * 0.054,
                                fontWeight: FontWeight.w500,
                                color: pillText,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),

                SizedBox(height: cardW * 0.06),

                // ── Price + View Pill Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        opportunity.budgetDisplay,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: cardW * 0.08,
                          fontWeight: FontWeight.w900,
                          color: textColor,
                        ),
                      ),
                    ),
                    SizedBox(width: cardW * 0.03),
                    GestureDetector(
                      onTap: onView,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: cardW * 0.085,
                          vertical: cardW * 0.032,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGradientCreative,
                          borderRadius: BorderRadius.circular(cardW * 0.095),
                        ),
                        child: Text(
                          "View",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: cardW * 0.065,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
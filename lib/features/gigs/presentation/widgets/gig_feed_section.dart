import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/gig_item_model.dart';
import 'gig_empty_state_card.dart';

class GigFeedSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color badgeColor;
  final IconData badgeIcon;
  final IconData emptyIcon;
  final String emptyMessage;
  final List<GigItemModel> items;
  final int totalCount;
  final bool isLoading;
  final bool hasActiveFilters;
  final int skeletonCount;
  final int? maxItems;
  final double itemSpacingRatio;
  final WidgetBuilder skeletonBuilder;
  final Widget Function(BuildContext context, GigItemModel gig) itemBuilder;
  final VoidCallback? onSeeAllTap;
  final VoidCallback? onResetFilters;

  const GigFeedSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badgeColor,
    required this.badgeIcon,
    required this.emptyIcon,
    required this.emptyMessage,
    required this.items,
    required this.totalCount,
    required this.isLoading,
    required this.hasActiveFilters,
    required this.skeletonBuilder,
    required this.itemBuilder,
    this.skeletonCount = 2,
    this.maxItems = 6,
    this.itemSpacingRatio = 0.045,
    this.onSeeAllTap,
    this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final displayCount = totalCount > 0 ? totalCount : items.length;
    final visibleItems = (maxItems != null && items.length > maxItems!)
        ? items.take(maxItems!).toList()
        : items;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final hPad = screenW * 0.04;
        final contentW = screenW - (hPad * 2);
        final iconCircleSize = screenW * 0.082;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Row(
                children: [
                  Container(
                    width: iconCircleSize,
                    height: iconCircleSize,
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      badgeIcon,
                      color: Colors.white,
                      size: iconCircleSize * 0.58,
                    ),
                  ),
                  SizedBox(width: screenW * 0.026),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: screenW * 0.041,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                ),
                              ),
                            ),
                            SizedBox(width: screenW * 0.018),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenW * 0.02,
                                vertical: screenW * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: badgeColor.withValues(alpha: 0.14),
                                borderRadius:
                                    BorderRadius.circular(screenW * 0.04),
                              ),
                              child: Text(
                                '$displayCount',
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: screenW * 0.028,
                                  fontWeight: FontWeight.w800,
                                  color: badgeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenW * 0.004),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: screenW * 0.03,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onSeeAllTap != null && visibleItems.isNotEmpty)
                    GestureDetector(
                      onTap: onSeeAllTap,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: screenW * 0.032,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff2E7D6E),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: screenW * 0.042,
                            color: const Color(0xff2E7D6E),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: screenW * 0.036),

            // ── Body: Loading Skeletons / Empty State / Capped Items (max 6)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: _buildBody(context, screenW, contentW, visibleItems),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    double screenW,
    double contentW,
    List<GigItemModel> visibleItems,
  ) {
    if (isLoading && visibleItems.isEmpty) {
      final gap = screenW * itemSpacingRatio;
      return Column(
        children: List.generate(skeletonCount, (idx) {
          return Padding(
            padding: EdgeInsets.only(bottom: idx == skeletonCount - 1 ? 0 : gap),
            child: SizedBox(
              width: contentW,
              child: skeletonBuilder(context),
            ),
          );
        }),
      );
    }

    if (visibleItems.isEmpty) {
      return GigEmptyStateCard(
        message: emptyMessage,
        accentColor: badgeColor,
        icon: emptyIcon,
        onResetFilters: hasActiveFilters ? onResetFilters : null,
      );
    }

    final gap = screenW * itemSpacingRatio;
    return Column(
      children: List.generate(visibleItems.length, (idx) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: idx == visibleItems.length - 1 ? 0 : gap),
          child: SizedBox(
            width: contentW,
            child: itemBuilder(context, visibleItems[idx]),
          ),
        );
      }),
    );
  }
}
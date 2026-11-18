import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/opportunity_item_model.dart';

class OpportunityFeedSection extends StatelessWidget {
  final String title;
  final Color dotColor;
  final IconData emptyIcon;
  final String emptyMessage;
  final List<OpportunityItemModel> items;
  final int totalCount;
  final bool isLoading;
  final bool hasActiveFilters;
  final bool isGrid;
  final int skeletonCount;
  final int? maxItems;
  final double itemSpacingRatio;
  final WidgetBuilder skeletonBuilder;
  final Widget Function(BuildContext context, OpportunityItemModel item)
      itemBuilder;
  final VoidCallback? onSeeAllTap;
  final VoidCallback? onResetFilters;

  const OpportunityFeedSection({
    super.key,
    required this.title,
    required this.dotColor,
    required this.emptyIcon,
    required this.emptyMessage,
    required this.items,
    required this.totalCount,
    required this.isLoading,
    required this.hasActiveFilters,
    required this.skeletonBuilder,
    required this.itemBuilder,
    this.isGrid = false,
    this.skeletonCount = 2,
    this.maxItems = 6,
    this.itemSpacingRatio = 0.04,
    this.onSeeAllTap,
    this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Row(
                children: [
                  Container(
                    width: screenW * 0.024,
                    height: screenW * 0.024,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: screenW * 0.022),
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: screenW * 0.042,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(width: screenW * 0.02),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenW * 0.022,
                            vertical: screenW * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: dotColor.withValues(alpha: 0.14),
                            borderRadius:
                                BorderRadius.circular(screenW * 0.04),
                          ),
                          child: Text(
                            '$displayCount',
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: screenW * 0.029,
                              fontWeight: FontWeight.w800,
                              color: dotColor,
                            ),
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

            SizedBox(height: screenW * 0.034),

            // ── Section Body
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: _buildBody(
                context: context,
                isDark: isDark,
                screenW: screenW,
                contentW: contentW,
                visibleItems: visibleItems,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required bool isDark,
    required double screenW,
    required double contentW,
    required List<OpportunityItemModel> visibleItems,
  }) {
    if (isLoading && visibleItems.isEmpty) {
      if (isGrid) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: skeletonCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: screenW * 0.032,
            mainAxisSpacing: screenW * 0.032,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (ctx, _) => skeletonBuilder(ctx),
        );
      }

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
      final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
      final borderColor =
          isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
      final textSecondary =
          isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

      return Container(
        width: contentW,
        padding: EdgeInsets.symmetric(
          horizontal: contentW * 0.045,
          vertical: contentW * 0.052,
        ),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(contentW * 0.05),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(contentW * 0.026),
              decoration: BoxDecoration(
                color: dotColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                emptyIcon,
                size: contentW * 0.052,
                color: dotColor,
              ),
            ),
            SizedBox(width: contentW * 0.032),
            Expanded(
              child: Text(
                emptyMessage,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: contentW * 0.033,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),
            ),
            if (hasActiveFilters && onResetFilters != null) ...[
              SizedBox(width: contentW * 0.025),
              GestureDetector(
                onTap: onResetFilters,
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: contentW * 0.032,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff0D9488),
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    }

    if (isGrid) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: visibleItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: screenW * 0.032,
          mainAxisSpacing: screenW * 0.032,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (ctx, idx) => itemBuilder(ctx, visibleItems[idx]),
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
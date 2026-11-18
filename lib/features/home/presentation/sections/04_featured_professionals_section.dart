import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/creative_pro_model.dart';
import '../widgets/cards/featured_pro_card.dart';
import '../widgets/cards/featured_pro_card_skeleton.dart';

class FeaturedProfessionalsSection extends StatelessWidget {
  final List<CreativeProModel> professionals;
  final bool isLoading;
  final VoidCallback? onViewAllTap;
  final ValueChanged<CreativeProModel>? onViewTap;
  final ValueChanged<CreativeProModel>? onConnectTap;
  final ValueChanged<CreativeProModel>? onFavoriteTap;

  const FeaturedProfessionalsSection({
    super.key,
    this.professionals = const [],
    this.isLoading = false,
    this.onViewAllTap,
    this.onViewTap,
    this.onConnectTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    // ── 1. Shimmer Loading State (3 Skeletons)
    if (isLoading && professionals.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(textColor, activeColor),
            const SizedBox(height: AppSpacing.space3),
            const FeaturedProCardSkeleton(),
            const FeaturedProCardSkeleton(),
            const FeaturedProCardSkeleton(),
          ],
        ),
      );
    }

    // ── 2. Display 3 cards on Home Page
    final displayList = professionals.take(3).toList();
    if (displayList.isEmpty) {
      return const SizedBox.shrink();
    }

    // ── 3. Render Vertical List of 3 Horizontal Cards
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(textColor, activeColor),
          const SizedBox(height: AppSpacing.space3),
          ...displayList.map(
            (pro) => FeaturedProCard(
              pro: pro,
              onView: () => onViewTap?.call(pro),
              onConnect: () => onConnectTap?.call(pro),
              onFavorite: () => onFavoriteTap?.call(pro),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(Color textColor, Color activeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Featured Professionals",
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeLg,
            fontWeight: AppTypography.bold,
            color: textColor,
          ),
        ),
        GestureDetector(
          onTap: onViewAllTap,
          child: Text(
            "View All",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm,
              fontWeight: AppTypography.semibold,
              color: activeColor,
            ),
          ),
        ),
      ],
    );
  }
}
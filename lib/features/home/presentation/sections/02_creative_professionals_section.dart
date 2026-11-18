import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/creative_pro_model.dart';
import '../widgets/cards/creative_pro_card.dart';
import '../widgets/cards/creative_pro_card_skeleton.dart';

class CreativeProfessionalsSection extends StatelessWidget {
  final List<CreativeProModel> professionals;
  final bool isLoading;
  final VoidCallback? onViewAllTap;
  final ValueChanged<CreativeProModel>? onConnectTap;
  final ValueChanged<CreativeProModel>? onProfileTap;
  final ValueChanged<CreativeProModel>? onBookmarkTap;

  const CreativeProfessionalsSection({
    super.key,
    this.professionals = const [],
    this.isLoading = false,
    this.onViewAllTap,
    this.onConnectTap,
    this.onProfileTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    // ── 1. Shimmer Loading State (3 Vertical Skeleton Cards)
    if (isLoading && professionals.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(textColor, activeColor),
            const SizedBox(height: AppSpacing.space3),
            const CreativeProCardSkeleton(),
            const CreativeProCardSkeleton(),
            const CreativeProCardSkeleton(),
          ],
        ),
      );
    }

    // ── 2. Empty State
    final displayPros = professionals.take(3).toList();
    if (displayPros.isEmpty) {
      return const SizedBox.shrink();
    }

    // ── 3. Vertical Card List (3 Cards)
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(textColor, activeColor),
          const SizedBox(height: AppSpacing.space3),
          ...displayPros.map(
            (pro) => CreativeProCard(
              pro: pro,
              onConnect: () => onConnectTap?.call(pro),
              onProfile: () => onProfileTap?.call(pro),
              onBookmark: () => onBookmarkTap?.call(pro),
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
          "Creative Professionals",
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
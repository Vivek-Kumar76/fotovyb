import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/creative_pro_model.dart';
import '../widgets/cards/spotlight_card.dart';
import '../widgets/cards/spotlight_card_skeleton.dart';

class SpotlightSection extends StatelessWidget {
  final List<CreativeProModel> profiles;
  final bool isLoading;
  final VoidCallback? onViewAllTap;
  final ValueChanged<CreativeProModel>? onConnectTap;
  final ValueChanged<CreativeProModel>? onProfileTap;
  final ValueChanged<CreativeProModel>? onFavoriteTap;

  const SpotlightSection({
    super.key,
    this.profiles = const [],
    this.isLoading = false,
    this.onViewAllTap,
    this.onConnectTap,
    this.onProfileTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    final double responsiveAspectRatio = screenWidth < 360 ? 0.56 : 0.60;

    // ── 1. Shimmer Loading State (4 Grid Cards Skeleton)
    if (isLoading && profiles.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(textColor, activeColor),
            const SizedBox(height: AppSpacing.space3),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                childAspectRatio: responsiveAspectRatio,
              ),
              itemBuilder: (_, __) => const SpotlightCardSkeleton(),
            ),
          ],
        ),
      );
    }

    // ── 2. Take 4 cards for home page view
    final displayProfiles = profiles.take(4).toList();
    if (displayProfiles.isEmpty) {
      return const SizedBox.shrink();
    }

    // ── 3. 2-Column Compact Grid
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(textColor, activeColor),
          const SizedBox(height: AppSpacing.space3),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayProfiles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              childAspectRatio: responsiveAspectRatio,
            ),
            itemBuilder: (ctx, idx) {
              final pro = displayProfiles[idx];
              return SpotlightCard(
                pro: pro,
                onConnect: () => onConnectTap?.call(pro),
                onProfile: () => onProfileTap?.call(pro),
                onFavorite: () => onFavoriteTap?.call(pro),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(Color textColor, Color activeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Spotlight",
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: -0.3,
          ),
        ),
        GestureDetector(
          onTap: onViewAllTap,
          child: Text(
            "View All",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: activeColor,
            ),
          ),
        ),
      ],
    );
  }
}
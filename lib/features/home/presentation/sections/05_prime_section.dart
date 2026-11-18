import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/creative_pro_model.dart';
import '../widgets/cards/prime_card.dart';
import '../widgets/cards/prime_card_skeleton.dart';

class PrimeSection extends StatelessWidget {
  final List<CreativeProModel> profiles;
  final bool isLoading;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<CreativeProModel>? onProTap;

  const PrimeSection({
    super.key,
    this.profiles = const [],
    this.isLoading = false,
    this.onSeeAllTap,
    this.onProTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    // ── 1. Shimmer Loading State (4 Grid Cards)
    if (isLoading && profiles.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isDark, textColor, activeColor),
            const SizedBox(height: AppSpacing.space3),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (_, __) => const PrimeCardSkeleton(),
            ),
          ],
        ),
      );
    }

    // ── 2. Display 4 cards on Home Page
    final displayList = profiles.take(4).toList();
    if (displayList.isEmpty) {
      return const SizedBox.shrink();
    }

    // ── 3. 2-Column Grid
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isDark, textColor, activeColor),
          const SizedBox(height: AppSpacing.space3),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (ctx, idx) {
              final pro = displayList[idx];
              return PrimeCard(
                pro: pro,
                onTap: () => onProTap?.call(pro),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark, Color textColor, Color activeColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Prime",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeLg,
                fontWeight: AppTypography.bold,
                color: textColor,
              ),
            ),
            const SizedBox(width: AppSpacing.space1),
            Container(
              padding: const EdgeInsets.all(3.5),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff451A03) : const Color(0xffFEF3C7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.crown,
                size: 11,
                color: Color(0xffD97706),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Row(
            children: [
              Text(
                "See all",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: AppTypography.sizeSm,
                  fontWeight: AppTypography.semibold,
                  color: activeColor,
                ),
              ),
              const SizedBox(width: 2),
              Icon(LucideIcons.chevronRight, size: 16, color: activeColor),
            ],
          ),
        ),
      ],
    );
  }
}
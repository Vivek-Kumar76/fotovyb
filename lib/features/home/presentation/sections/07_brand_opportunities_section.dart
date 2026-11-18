import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/brand_opportunity_model.dart';
import '../widgets/cards/brand_opportunity_card.dart';
import '../widgets/cards/brand_opportunity_card_skeleton.dart';

class BrandOpportunitiesSection extends StatelessWidget {
  final List<BrandOpportunityModel> highPriorityOpps;
  final bool isLoadingHighPriority;
  final VoidCallback? onViewAllHighPriority;

  final List<BrandOpportunityModel> boostedOpps;
  final bool isLoadingBoosted;
  final VoidCallback? onViewAllBoosted;

  final List<BrandOpportunityModel> featuredOpps;
  final bool isLoadingFeatured;
  final VoidCallback? onViewAllFeatured;

  final Function(BrandOpportunityModel opp)? onCardTap;
  final Function(BrandOpportunityModel opp)? onApplyTap;
  final Function(BrandOpportunityModel opp)? onSaveTap;

  const BrandOpportunitiesSection({
    super.key,
    this.highPriorityOpps = const [],
    this.isLoadingHighPriority = false,
    this.onViewAllHighPriority,
    this.boostedOpps = const [],
    this.isLoadingBoosted = false,
    this.onViewAllBoosted,
    this.featuredOpps = const [],
    this.isLoadingFeatured = false,
    this.onViewAllFeatured,
    this.onCardTap,
    this.onApplyTap,
    this.onSaveTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;

    final bool hasAnyData = highPriorityOpps.isNotEmpty ||
        boostedOpps.isNotEmpty ||
        featuredOpps.isNotEmpty;

    final bool isAnyLoading = isLoadingHighPriority || isLoadingBoosted || isLoadingFeatured;

    if (!hasAnyData && !isAnyLoading) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Main Section Header[cite: 2]
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Brand Opportunities",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: AppTypography.sizeLg,
                  fontWeight: AppTypography.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                "Live briefs from brands & businesses",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: AppTypography.sizeXs,
                  color: textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space3),

        // ── Tier 1: High-Priority Contracts
        _buildOpportunityTier(
          title: "High-Priority Contracts",
          subtitle: "Enterprise briefs requiring immediate talent",
          items: highPriorityOpps.take(3).toList(),
          isLoading: isLoadingHighPriority,
          onViewAll: onViewAllHighPriority,
          textColor: textColor,
          textSecondary: textSecondary,
          activeColor: activeColor,
        ),

        // ── Tier 2: Boosted Opportunities
        _buildOpportunityTier(
          title: "Boosted Opportunities",
          subtitle: "Promoted commercial campaigns and productions",
          items: boostedOpps.take(3).toList(),
          isLoading: isLoadingBoosted,
          onViewAll: onViewAllBoosted,
          textColor: textColor,
          textSecondary: textSecondary,
          activeColor: activeColor,
        ),

        // ── Tier 3: Featured Job Postings
        _buildOpportunityTier(
          title: "Featured Job Postings",
          subtitle: "Curated briefs from verified brands",
          items: featuredOpps.take(3).toList(),
          isLoading: isLoadingFeatured,
          onViewAll: onViewAllFeatured,
          textColor: textColor,
          textSecondary: textSecondary,
          activeColor: activeColor,
        ),
      ],
    );
  }

  Widget _buildOpportunityTier({
    required String title,
    required String subtitle,
    required List<BrandOpportunityModel> items,
    required bool isLoading,
    required VoidCallback? onViewAll,
    required Color textColor,
    required Color textSecondary,
    required Color activeColor,
  }) {
    if (!isLoading && items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sub-row Header with "See all"[cite: 2]
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeSm + 1,
                          fontWeight: AppTypography.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeXs - 1,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onViewAll,
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
                      Icon(Icons.chevron_right_rounded, size: 16, color: activeColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space2 + 2),

          // Horizontal scrolling 3-card carousel with dedicated skeleton
          SizedBox(
            height: 255,
            child: isLoading && items.isEmpty
                ? _buildSkeletonList()
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
                    itemCount: items.length,
                    itemBuilder: (ctx, idx) {
                      final item = items[idx];
                      return BrandOpportunityCard(
                        opportunity: item,
                        width: 320,
                        margin: const EdgeInsets.only(right: AppSpacing.space3),
                        onTap: () => onCardTap?.call(item),
                        onApplyTap: () => onApplyTap?.call(item),
                        onSaveTap: () => onSaveTap?.call(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      itemCount: 3,
      itemBuilder: (ctx, idx) => const BrandOpportunityCardSkeleton(
        width: 320,
        margin: EdgeInsets.only(right: AppSpacing.space3),
      ),
    );
  }
}
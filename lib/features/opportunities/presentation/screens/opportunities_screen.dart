import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/opportunity_item_model.dart';
import '../bloc/opportunities_bloc.dart';
import '../bloc/opportunities_event.dart';
import '../bloc/opportunities_state.dart';
import '../widgets/cards/opportunity_boosted_card.dart';
import '../widgets/cards/opportunity_boosted_card_skeleton.dart';
import '../widgets/cards/opportunity_featured_card.dart';
import '../widgets/cards/opportunity_featured_card_skeleton.dart';
import '../widgets/cards/opportunity_high_priority_card.dart';
import '../widgets/cards/oppotunity_high_priority_card_skeleton.dart';
import '../widgets/opportunities_bundle_promo_card.dart';
import '../widgets/opportunities_filter_drawer.dart';
import '../widgets/opportunities_header_and_hero.dart';
import '../widgets/opportunity_feed_section.dart';
import 'opportunity_section_view_all_cubit.dart';
import 'opportunity_section_view_all_screen.dart';

class OpportunitiesScreen extends StatelessWidget {
  const OpportunitiesScreen({super.key});

  void _showNotice(BuildContext context, String message) {
    final screenW = MediaQuery.sizeOf(context).width;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: screenW * 0.032,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xff2E7D6E),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenW * 0.03),
        ),
      ),
    );
  }

  void _openViewAll(
    BuildContext context, {
    required OpportunitySectionType section,
    required String title,
    required Color dotColor,
    required IconData emptyIcon,
    required List<OpportunityItemModel> initialItems,
    required int initialTotal,
    required OpportunitiesState oppState,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OpportunitySectionViewAllScreen(
          section: section,
          title: title,
          dotColor: dotColor,
          emptyIcon: emptyIcon,
          initialItems: initialItems,
          initialTotal: initialTotal,
          budgetRange: oppState.selectedBudgetRange,
          roles: oppState.selectedRoles,
          industries: oppState.selectedIndustries,
          locations: oppState.selectedLocations,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenW = MediaQuery.sizeOf(context).width;
    final sectionGap = screenW * 0.06;

    return BlocListener<OpportunitiesBloc, OpportunitiesState>(
      listenWhen: (prev, curr) =>
          prev.errorMessage != curr.errorMessage && curr.errorMessage != null,
      listener: (context, state) {
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          _showNotice(context, state.errorMessage!);
        }
      },
      child: Scaffold(
        backgroundColor:
            isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
        endDrawer: BlocBuilder<OpportunitiesBloc, OpportunitiesState>(
          buildWhen: (prev, curr) =>
              prev.selectedBudgetRange != curr.selectedBudgetRange ||
              prev.selectedRoles != curr.selectedRoles ||
              prev.selectedIndustries != curr.selectedIndustries ||
              prev.selectedLocations != curr.selectedLocations ||
              prev.selectedRating != curr.selectedRating ||
              prev.facets != curr.facets,
          builder: (context, state) {
            return OpportunitiesFilterDrawer(
              initialBudgetRange: state.selectedBudgetRange,
              initialRoles: state.selectedRoles,
              initialIndustries: state.selectedIndustries,
              initialLocations: state.selectedLocations,
              initialRating: state.selectedRating,
              facets: state.facets,
              onClearAll: () {
                context
                    .read<OpportunitiesBloc>()
                    .add(const OpportunitiesFiltersCleared());
                _showNotice(context, "Filters reset");
              },
              onApply: ({
                required budgetRange,
                required roles,
                required industries,
                required locations,
                required rating,
              }) {
                context.read<OpportunitiesBloc>().add(
                      OpportunitiesFiltersApplied(
                        budgetRange: budgetRange,
                        roles: roles,
                        industries: industries,
                        locations: locations,
                        rating: rating,
                      ),
                    );
              },
            );
          },
        ),
        body: RefreshIndicator(
          color: const Color(0xff0D9488),
          onRefresh: () async => context
              .read<OpportunitiesBloc>()
              .add(const OpportunitiesRefreshRequested()),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── 1. Top Nav Bar & Dark Hero Banner
                BlocSelector<OpportunitiesBloc, OpportunitiesState, int>(
                  selector: (s) => s.activeFilterCount,
                  builder: (drawerCtx, filterCount) {
                    return OpportunitiesHeaderAndHero(
                      activeFilterCount: filterCount,
                      onNotificationsTap: () =>
                          _showNotice(context, "Notifications"),
                      onFilterTap: () =>
                          Scaffold.of(drawerCtx).openEndDrawer(),
                    );
                  },
                ),

                SizedBox(height: screenW * 0.05),

                // ── 2. High Priority Section (Max 6 Preview + See All)
                BlocBuilder<OpportunitiesBloc, OpportunitiesState>(
                  buildWhen: (prev, curr) =>
                      prev.isLoadingHighPriority !=
                          curr.isLoadingHighPriority ||
                      prev.highPriorityItems != curr.highPriorityItems ||
                      prev.highPriorityTotal != curr.highPriorityTotal ||
                      prev.applyingOpportunityId !=
                          curr.applyingOpportunityId ||
                      prev.hasActiveFilters != curr.hasActiveFilters,
                  builder: (context, state) {
                    const title = "High Priority";
                    const dotColor = Color(0xffEF4444);
                    const emptyIcon = Icons.flash_on_rounded;

                    return OpportunityFeedSection(
                      title: title,
                      dotColor: dotColor,
                      emptyIcon: emptyIcon,
                      emptyMessage: state.hasActiveFilters
                          ? "No High Priority opportunities match your filters."
                          : "No High Priority opportunities available right now.",
                      items: state.highPriorityItems,
                      totalCount: state.highPriorityTotal,
                      isLoading: state.isLoadingHighPriority,
                      hasActiveFilters: state.hasActiveFilters,
                      maxItems: 6,
                      skeletonBuilder: (_) =>
                          const OpportunityHighPriorityCardSkeleton(),
                      onSeeAllTap: () => _openViewAll(
                        context,
                        section: OpportunitySectionType.highPriority,
                        title: title,
                        dotColor: dotColor,
                        emptyIcon: emptyIcon,
                        initialItems: state.highPriorityItems,
                        initialTotal: state.highPriorityTotal,
                        oppState: state,
                      ),
                      onResetFilters: () => context
                          .read<OpportunitiesBloc>()
                          .add(const OpportunitiesFiltersCleared()),
                      itemBuilder: (ctx, item) => OpportunityHighPriorityCard(
                        opportunity: item,
                        isApplying: state.applyingOpportunityId == item.id,
                        onApply: () {
                          ctx
                              .read<OpportunitiesBloc>()
                              .add(OpportunityApplyRequested(item.id));
                          _showNotice(ctx, "Applied to ${item.title}");
                        },
                        onTap: () => _showNotice(ctx, item.title),
                      ),
                    );
                  },
                ),

                SizedBox(height: sectionGap),

                // ── 3. Boosted Section (Max 6 Preview + See All)
                BlocBuilder<OpportunitiesBloc, OpportunitiesState>(
                  buildWhen: (prev, curr) =>
                      prev.isLoadingBoosted != curr.isLoadingBoosted ||
                      prev.boostedItems != curr.boostedItems ||
                      prev.boostedTotal != curr.boostedTotal ||
                      prev.applyingOpportunityId !=
                          curr.applyingOpportunityId ||
                      prev.hasActiveFilters != curr.hasActiveFilters,
                  builder: (context, state) {
                    const title = "Boosted";
                    const dotColor = Color(0xffD97706);
                    const emptyIcon = Icons.bolt_rounded;

                    return OpportunityFeedSection(
                      title: title,
                      dotColor: dotColor,
                      emptyIcon: emptyIcon,
                      emptyMessage: state.hasActiveFilters
                          ? "No Boosted opportunities match your filters."
                          : "No Boosted opportunities available right now.",
                      items: state.boostedItems,
                      totalCount: state.boostedTotal,
                      isLoading: state.isLoadingBoosted,
                      hasActiveFilters: state.hasActiveFilters,
                      maxItems: 6,
                      itemSpacingRatio: 0.025,
                      skeletonBuilder: (_) =>
                          const OpportunityBoostedCardSkeleton(),
                      onSeeAllTap: () => _openViewAll(
                        context,
                        section: OpportunitySectionType.boosted,
                        title: title,
                        dotColor: dotColor,
                        emptyIcon: emptyIcon,
                        initialItems: state.boostedItems,
                        initialTotal: state.boostedTotal,
                        oppState: state,
                      ),
                      onResetFilters: () => context
                          .read<OpportunitiesBloc>()
                          .add(const OpportunitiesFiltersCleared()),
                      itemBuilder: (ctx, item) => OpportunityBoostedCard(
                        opportunity: item,
                        isApplying: state.applyingOpportunityId == item.id,
                        onApply: () {
                          ctx
                              .read<OpportunitiesBloc>()
                              .add(OpportunityApplyRequested(item.id));
                          _showNotice(ctx, "Applied to ${item.brand}");
                        },
                        onTap: () => _showNotice(ctx, item.title),
                      ),
                    );
                  },
                ),

                SizedBox(height: sectionGap),

                // ── 4. Bundle Discount Promo Banner
                OpportunitiesBundlePromoCard(
                  onViewPackagesTap: () =>
                      _showNotice(context, "Opening Packages..."),
                ),

                SizedBox(height: sectionGap),

                // ── 5. Featured 2-Column Grid Section (Max 6 Preview + See All)
                BlocBuilder<OpportunitiesBloc, OpportunitiesState>(
                  buildWhen: (prev, curr) =>
                      prev.isLoadingFeatured != curr.isLoadingFeatured ||
                      prev.featuredItems != curr.featuredItems ||
                      prev.featuredTotal != curr.featuredTotal ||
                      prev.hasActiveFilters != curr.hasActiveFilters,
                  builder: (context, state) {
                    const title = "Featured";
                    const dotColor = Color(0xff0D9488);
                    const emptyIcon = Icons.star_rounded;

                    return OpportunityFeedSection(
                      title: title,
                      dotColor: dotColor,
                      emptyIcon: emptyIcon,
                      emptyMessage: state.hasActiveFilters
                          ? "No Featured opportunities match your filters."
                          : "No Featured opportunities available right now.",
                      items: state.featuredItems,
                      totalCount: state.featuredTotal,
                      isLoading: state.isLoadingFeatured,
                      hasActiveFilters: state.hasActiveFilters,
                      isGrid: true,
                      maxItems: 6,
                      skeletonCount: 4,
                      skeletonBuilder: (_) =>
                          const OpportunityFeaturedCardSkeleton(),
                      onSeeAllTap: () => _openViewAll(
                        context,
                        section: OpportunitySectionType.featured,
                        title: title,
                        dotColor: dotColor,
                        emptyIcon: emptyIcon,
                        initialItems: state.featuredItems,
                        initialTotal: state.featuredTotal,
                        oppState: state,
                      ),
                      onResetFilters: () => context
                          .read<OpportunitiesBloc>()
                          .add(const OpportunitiesFiltersCleared()),
                      itemBuilder: (ctx, item) => OpportunityFeaturedCard(
                        opportunity: item,
                        onView: () => _showNotice(ctx, item.title),
                      ),
                    );
                  },
                ),

                SizedBox(height: screenW * 0.12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
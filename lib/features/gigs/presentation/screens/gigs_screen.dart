import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../profile/presentation/screens/creative_profile_screen.dart';
import '../../data/models/gig_item_model.dart';
import '../bloc/gigs_bloc.dart';
import '../bloc/gigs_event.dart';
import '../bloc/gigs_state.dart';
import '../widgets/cards/gig_featured_card.dart';
import '../widgets/cards/gig_featured_card_skeleton.dart';
import '../widgets/cards/gig_high_priority_card.dart';
import '../widgets/cards/gig_high_priority_card_skeleton.dart';
import '../widgets/cards/gig_new_card.dart';
import '../widgets/cards/gig_new_card_skeleton.dart';
import '../widgets/cards/gig_pro_master_card.dart';
import '../widgets/cards/gig_pro_master_card_skeleton.dart';
import '../widgets/gig_feed_section.dart';
import '../widgets/gigs_header_section.dart';
import 'gig_section_view_all_cubit.dart';
import 'gig_section_view_all_screen.dart';

class GigsScreen extends StatelessWidget {
  const GigsScreen({super.key});

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
    required GigSectionType section,
    required String title,
    required String subtitle,
    required Color badgeColor,
    required IconData badgeIcon,
    required List<GigItemModel> initialItems,
    required int initialTotal,
    required GigsState gigsState,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GigSectionViewAllScreen(
          section: section,
          title: title,
          subtitle: subtitle,
          badgeColor: badgeColor,
          badgeIcon: badgeIcon,
          initialItems: initialItems,
          initialTotal: initialTotal,
          searchQuery: gigsState.searchQuery,
          city: gigsState.selectedCity,
          category: gigsState.selectedCategory,
          sortBy: gigsState.selectedSort,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenW = MediaQuery.sizeOf(context).width;
    final sectionGap = screenW * 0.068;

    return BlocListener<GigsBloc, GigsState>(
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
        body: RefreshIndicator(
          color: const Color(0xff0D9488),
          onRefresh: () async =>
              context.read<GigsBloc>().add(const GigsRefreshRequested()),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── 1. Header, Hero Banner, Search & Category/Sort Controls
                BlocBuilder<GigsBloc, GigsState>(
                  buildWhen: (prev, curr) =>
                      prev.selectedCity != curr.selectedCity ||
                      prev.selectedCategory != curr.selectedCategory ||
                      prev.selectedSort != curr.selectedSort ||
                      prev.searchQuery != curr.searchQuery ||
                      prev.totalMatchingGigs != curr.totalMatchingGigs,
                  builder: (context, state) {
                    return GigsHeaderSection(
                      selectedCity: state.selectedCity,
                      selectedCategory: state.selectedCategory,
                      selectedSort: state.selectedSort,
                      searchQuery: state.searchQuery,
                      totalGigsCount: state.totalMatchingGigs,
                      onProfileTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreativeProfileScreen(),
                          ),
                        );
                      },
                      onPostGigTap: () =>
                          _showNotice(context, "Opening Post a GIG composer..."),
                      onNotificationsTap: () =>
                          _showNotice(context, "Opening notifications..."),
                      onSearch: (q) =>
                          context.read<GigsBloc>().add(GigsSearchSubmitted(q)),
                      onCityChanged: (city) =>
                          context.read<GigsBloc>().add(GigsCityChanged(city)),
                      onCategorySelected: (cat) => context
                          .read<GigsBloc>()
                          .add(GigsCategoryChanged(cat)),
                      onSortChanged: (sort) =>
                          context.read<GigsBloc>().add(GigsSortChanged(sort)),
                    );
                  },
                ),

                SizedBox(height: screenW * 0.06),

                // ── 2. High Priority GIGs (Max 6 Preview + See All)
                BlocBuilder<GigsBloc, GigsState>(
                  buildWhen: (prev, curr) =>
                      prev.isLoadingHighPriority !=
                          curr.isLoadingHighPriority ||
                      prev.highPriorityItems != curr.highPriorityItems ||
                      prev.highPriorityTotal != curr.highPriorityTotal ||
                      prev.hasActiveFilters != curr.hasActiveFilters,
                  builder: (context, state) {
                    const title = "High Priority GIGs";
                    const subtitle =
                        "Fast turnaround & priority delivery packages";
                    const badgeColor = Color(0xff0F766E);
                    const badgeIcon = LucideIcons.sparkles;

                    return GigFeedSection(
                      title: title,
                      subtitle: subtitle,
                      badgeColor: badgeColor,
                      badgeIcon: badgeIcon,
                      emptyIcon: badgeIcon,
                      emptyMessage: state.hasActiveFilters
                          ? "No High Priority GIGs match your filters."
                          : "No High Priority GIGs available right now.",
                      items: state.highPriorityItems,
                      totalCount: state.highPriorityTotal,
                      isLoading: state.isLoadingHighPriority,
                      hasActiveFilters: state.hasActiveFilters,
                      maxItems: 6,
                      skeletonCount: 1,
                      skeletonBuilder: (_) =>
                          const GigHighPriorityCardSkeleton(),
                      onSeeAllTap: () => _openViewAll(
                        context,
                        section: GigSectionType.highPriority,
                        title: title,
                        subtitle: subtitle,
                        badgeColor: badgeColor,
                        badgeIcon: badgeIcon,
                        initialItems: state.highPriorityItems,
                        initialTotal: state.highPriorityTotal,
                        gigsState: state,
                      ),
                      onResetFilters: () =>
                          context.read<GigsBloc>().add(const GigsFiltersReset()),
                      itemBuilder: (ctx, gig) => GigHighPriorityCard(
                        gig: gig,
                        onTap: () =>
                            _showNotice(ctx, 'Opening "${gig.title}"'),
                        onFavoriteTap: () {
                          ctx.read<GigsBloc>().add(GigBookmarkToggled(gig.id));
                          _showNotice(
                            ctx,
                            gig.isFavorite
                                ? 'Removed "${gig.title}"'
                                : 'Saved "${gig.title}"',
                          );
                        },
                        onChatTap: () => _showNotice(
                          ctx,
                          'Chatting with ${gig.professional.name}',
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: sectionGap),

                // ── 3. Pro Master GIGs (Max 6 Preview + See All)
                BlocBuilder<GigsBloc, GigsState>(
                  buildWhen: (prev, curr) =>
                      prev.isLoadingProMaster != curr.isLoadingProMaster ||
                      prev.proMasterItems != curr.proMasterItems ||
                      prev.proMasterTotal != curr.proMasterTotal ||
                      prev.hasActiveFilters != curr.hasActiveFilters,
                  builder: (context, state) {
                    const title = "Pro Master GIGs";
                    const subtitle =
                        "Verified top-tier talent & agency-grade production";
                    const badgeColor = Color(0xff7C3AED);
                    const badgeIcon = Icons.workspace_premium_rounded;

                    return GigFeedSection(
                      title: title,
                      subtitle: subtitle,
                      badgeColor: badgeColor,
                      badgeIcon: badgeIcon,
                      emptyIcon: badgeIcon,
                      emptyMessage: state.hasActiveFilters
                          ? "No Pro Master GIGs match your filters."
                          : "No Pro Master GIGs available right now.",
                      items: state.proMasterItems,
                      totalCount: state.proMasterTotal,
                      isLoading: state.isLoadingProMaster,
                      hasActiveFilters: state.hasActiveFilters,
                      maxItems: 6,
                      skeletonCount: 2,
                      itemSpacingRatio: 0.036,
                      skeletonBuilder: (_) => const GigProMasterCardSkeleton(),
                      onSeeAllTap: () => _openViewAll(
                        context,
                        section: GigSectionType.proMaster,
                        title: title,
                        subtitle: subtitle,
                        badgeColor: badgeColor,
                        badgeIcon: badgeIcon,
                        initialItems: state.proMasterItems,
                        initialTotal: state.proMasterTotal,
                        gigsState: state,
                      ),
                      onResetFilters: () =>
                          context.read<GigsBloc>().add(const GigsFiltersReset()),
                      itemBuilder: (ctx, gig) => GigProMasterCard(
                        gig: gig,
                        onTap: () =>
                            _showNotice(ctx, 'Opening "${gig.title}"'),
                        onViewGigTap: () =>
                            _showNotice(ctx, 'Opening "${gig.title}"'),
                      ),
                    );
                  },
                ),

                SizedBox(height: sectionGap),

                // ── 4. Featured GIGs (Max 6 Preview + See All)
                BlocBuilder<GigsBloc, GigsState>(
                  buildWhen: (prev, curr) =>
                      prev.isLoadingFeatured != curr.isLoadingFeatured ||
                      prev.featuredItems != curr.featuredItems ||
                      prev.featuredTotal != curr.featuredTotal ||
                      prev.hasActiveFilters != curr.hasActiveFilters,
                  builder: (context, state) {
                    const title = "Featured GIGs";
                    const subtitle =
                        "Promoted creative offerings hand-picked this week";
                    const badgeColor = Color(0xffEA580C);
                    const badgeIcon = Icons.star_rounded;

                    return GigFeedSection(
                      title: title,
                      subtitle: subtitle,
                      badgeColor: badgeColor,
                      badgeIcon: badgeIcon,
                      emptyIcon: badgeIcon,
                      emptyMessage: state.hasActiveFilters
                          ? "No Featured GIGs match your filters."
                          : "No Featured GIGs available right now.",
                      items: state.featuredItems,
                      totalCount: state.featuredTotal,
                      isLoading: state.isLoadingFeatured,
                      hasActiveFilters: state.hasActiveFilters,
                      maxItems: 6,
                      skeletonCount: 1,
                      skeletonBuilder: (_) => const GigFeaturedCardSkeleton(),
                      onSeeAllTap: () => _openViewAll(
                        context,
                        section: GigSectionType.featured,
                        title: title,
                        subtitle: subtitle,
                        badgeColor: badgeColor,
                        badgeIcon: badgeIcon,
                        initialItems: state.featuredItems,
                        initialTotal: state.featuredTotal,
                        gigsState: state,
                      ),
                      onResetFilters: () =>
                          context.read<GigsBloc>().add(const GigsFiltersReset()),
                      itemBuilder: (ctx, gig) => GigFeaturedCard(
                        gig: gig,
                        onTap: () =>
                            _showNotice(ctx, 'Opening "${gig.title}"'),
                        onViewTap: () =>
                            _showNotice(ctx, 'Opening "${gig.title}"'),
                        onFavoriteTap: () {
                          ctx.read<GigsBloc>().add(GigBookmarkToggled(gig.id));
                          _showNotice(
                            ctx,
                            gig.isFavorite
                                ? 'Removed "${gig.title}"'
                                : 'Saved "${gig.title}"',
                          );
                        },
                      ),
                    );
                  },
                ),

                SizedBox(height: sectionGap),

                // ── 5. New GIGs / Explore (Max 6 Preview + See All)
                BlocBuilder<GigsBloc, GigsState>(
                  buildWhen: (prev, curr) =>
                      prev.isLoadingExplore != curr.isLoadingExplore ||
                      prev.exploreItems != curr.exploreItems ||
                      prev.exploreTotal != curr.exploreTotal ||
                      prev.hasActiveFilters != curr.hasActiveFilters,
                  builder: (context, state) {
                    const title = "New GIGs";
                    const subtitle = "Fresh talent — discover them first";
                    const badgeColor = Color(0xff0D9488);
                    const badgeIcon = Icons.bolt_rounded;

                    return GigFeedSection(
                      title: title,
                      subtitle: subtitle,
                      badgeColor: badgeColor,
                      badgeIcon: badgeIcon,
                      emptyIcon: badgeIcon,
                      emptyMessage: state.hasActiveFilters
                          ? "No New GIGs match your filters."
                          : "No New GIGs available right now.",
                      items: state.exploreItems,
                      totalCount: state.exploreTotal,
                      isLoading: state.isLoadingExplore,
                      hasActiveFilters: state.hasActiveFilters,
                      maxItems: 6,
                      skeletonCount: 2,
                      skeletonBuilder: (_) => const GigNewCardSkeleton(),
                      onSeeAllTap: () => _openViewAll(
                        context,
                        section: GigSectionType.explore,
                        title: title,
                        subtitle: subtitle,
                        badgeColor: badgeColor,
                        badgeIcon: badgeIcon,
                        initialItems: state.exploreItems,
                        initialTotal: state.exploreTotal,
                        gigsState: state,
                      ),
                      onResetFilters: () =>
                          context.read<GigsBloc>().add(const GigsFiltersReset()),
                      itemBuilder: (ctx, gig) => GigNewCard(
                        gig: gig,
                        onViewGig: () =>
                            _showNotice(ctx, 'Opening "${gig.title}"'),
                        onChat: () => _showNotice(
                          ctx,
                          'Chatting with ${gig.professional.name}',
                        ),
                        onBookmark: () {
                          ctx.read<GigsBloc>().add(GigBookmarkToggled(gig.id));
                          _showNotice(
                            ctx,
                            gig.isFavorite
                                ? 'Removed "${gig.title}"'
                                : 'Saved "${gig.title}"',
                          );
                        },
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
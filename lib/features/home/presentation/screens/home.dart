import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:p1/features/messaging/presentation/screens/inbox_screen.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/pagination/paginated_result.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/widgets/app_profile_drawer.dart';
import '../../../../core/widgets/paginated_infinite_scroll_view.dart';
import '../../../profile/presentation/screens/creative_profile_screen.dart';
import './../../../gigs/presentation/screens/gigs_screen.dart';
import './../../../opportunities/presentation/screens/opportunities_screen.dart';
import './../../../professionals/presentation/screens/professionals_screen.dart';

// Models, Repository and BLoC Imports
import '../../data/models/creative_pro_model.dart';
import '../../data/models/brand_opportunity_model.dart';
import '../../data/models/gig_model.dart';
import '../../domain/repositories/home_repository.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

// Card Imports
import '../widgets/cards/creative_pro_card.dart';
import '../widgets/cards/spotlight_card.dart';
import '../widgets/cards/featured_pro_card.dart';
import '../widgets/cards/prime_card.dart';
import '../widgets/cards/rising_star_card.dart';
import '../widgets/cards/brand_opportunity_card.dart';
import '../widgets/cards/high_priority_gig_card.dart';
import '../widgets/cards/high_priority_gig_card_skeleton.dart';
import '../widgets/cards/pro_master_gig_card.dart';
import '../widgets/cards/pro_master_gig_card_skeleton.dart';
import '../widgets/cards/featured_gig_card.dart';
import '../widgets/cards/featured_gig_card_skeleton.dart';
import 'view_all_screen.dart';

// Section Imports
import '../sections/01_top_bar_section.dart';
import '../sections/02_creative_professionals_section.dart';
import '../sections/03_spotlight_section.dart';
import '../sections/04_featured_professionals_section.dart';
import '../sections/05_prime_section.dart';
import '../sections/06_rising_stars_section.dart';
import '../sections/07_brand_opportunities_section.dart';
import '../sections/07_business_opportunities_section.dart';
import '../sections/08_trending_work_styles_section.dart';
import '../sections/12_skilled_gigs_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  String currentCity = "All";
  String currentCategory = "All";
  String searchQuery = "";

  Future<void> _handleRefresh() async {
    context.read<HomeBloc>().add(const HomeRefreshRequested());
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeSm,
            fontWeight: AppTypography.medium,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      ),
    );
  }

  void _navigateToCreativeProfile(CreativeProModel pro) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreativeProfileScreen(),
      ),
    );
  }

  // ── Brand Opportunities View All Navigation
  void _navigateToOpportunitiesViewAll({
    required String title,
    required List<BrandOpportunityModel> seedItems,
    required Future<Result<List<BrandOpportunityModel>, Failure>> Function({
      required int page,
      required int limit,
      String? city,
      String? category,
    }) fetchMethod,
  }) {
    final currentCity = context.read<HomeBloc>().state.selectedCity;
    final currentCategory = context.read<HomeBloc>().state.selectedCategory;
    final homeBloc = context.read<HomeBloc>();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ViewAllScreen<BrandOpportunityModel>(
          title: title,
          seedItems: seedItems,
          layoutType: PaginatedLayoutType.list,
          fetcher: ({
            required int page,
            required int limit,
            Map<String, dynamic>? filters,
          }) async {
            final result = await fetchMethod(
              page: page,
              limit: limit,
              city: currentCity,
              category: currentCategory,
            );

            return result.fold(
              (data, _) => PaginatedResult<BrandOpportunityModel>(
                items: data,
                total: 100,
                page: page,
                hasReachedMax: data.length < limit,
              ),
              (failure) => throw Exception(failure.message),
            );
          },
          itemBuilder: (ctx, opp) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space3),
            child: BrandOpportunityCard(
              opportunity: opp,
              onTap: () => _showToast("Opening brief: ${opp.title}"),
              onApplyTap: () => _onApplyOpportunity(opp),
              onSaveTap: () {
                homeBloc.add(HomeOpportunitySaveToggled(opp));
                _showToast(opp.isSaved ? "Removed from saved" : "Saved ${opp.title}");
              },
            ),
          ),
        ),
      ),
    );
  }

  // ── GIGs Generic View All Navigation (Works for all 3 Tiers)
  void _navigateToGigsViewAll({
    required String title,
    required List<GigModel> seedItems,
    required PaginatedLayoutType layoutType,
    SliverGridDelegate? gridDelegate,
    required Future<Result<List<GigModel>, Failure>> Function({
      required int page,
      required int limit,
      String? city,
      String? category,
    }) fetchMethod,
    required Widget Function(BuildContext, GigModel) itemBuilder,
  }) {
    final currentCity = context.read<HomeBloc>().state.selectedCity;
    final currentCategory = context.read<HomeBloc>().state.selectedCategory;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ViewAllScreen<GigModel>(
          title: title,
          seedItems: seedItems,
          layoutType: layoutType,
          gridDelegate: gridDelegate,
          fetcher: ({
            required int page,
            required int limit,
            Map<String, dynamic>? filters,
          }) async {
            final result = await fetchMethod(
              page: page,
              limit: limit,
              city: currentCity,
              category: currentCategory,
            );

            return result.fold(
              (data, _) => PaginatedResult<GigModel>(
                items: data,
                total: 100,
                page: page,
                hasReachedMax: data.length < limit,
              ),
              (failure) => throw Exception(failure.message),
            );
          },
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }

  void _onPostGig() {
    _showToast("Opening Post a GIG flow...");
  }

  void _onNotifications() {
    _showToast("Opening notifications...");
  }

  void _onProfile() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) return;
    setState(() => searchQuery = query);
    _showToast("Searching for \"$query\" in $currentCity...");
  }

  void _onCityChanged(String city) {
    setState(() => currentCity = city);
    context.read<HomeBloc>().add(HomeCityChanged(city));
    _showToast(city == "All" ? "Showing all locations" : "Location switched to $city");
  }

  void _onCategoryChanged(String category) {
    setState(() => currentCategory = category);
    context.read<HomeBloc>().add(HomeCategoryChanged(category));
    _showToast(category == "All" ? "Showing all categories" : "Category: $category");
  }

  void _onApplyOpportunity(BrandOpportunityModel opp) {
    _showToast("Applying to ${opp.brand} opportunity...");
  }

  void _onViewGigDetails(GigModel gig) {
    _showToast("Loading \"${gig.title}\" details...");
  }

  void _onChatWithSeller(GigModel gig) {
    _showToast("Starting chat with ${gig.professional.name}...");
  }

  void _onFavoriteGig(GigModel gig) {
    context.read<HomeBloc>().add(HomeGigFavoriteToggled(gig));
    _showToast(gig.isFavorite ? "Removed from bookmarks" : "Saved ${gig.title}");
  }

  void _onSort() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.surfaceDark
          : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sort Results By",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeLg,
                    fontWeight: AppTypography.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.space2),
                ListTile(
                  leading: const Icon(LucideIcons.star, color: Color(0xffD97706)),
                  title: const Text("Top Rated & Verified"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showToast("Sorted by Top Rated");
                  },
                ),
                ListTile(
                  leading: const Icon(LucideIcons.trendingUp, color: AppColors.primary),
                  title: const Text("Most Popular & Booked"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showToast("Sorted by Popularity");
                  },
                ),
                ListTile(
                  leading: const Icon(LucideIcons.zap, color: AppColors.success),
                  title: const Text("Fastest Delivery Turnaround"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showToast("Sorted by Delivery Speed");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader({
    required String title,
    String? subtitle,
    required VoidCallback onSeeAll,
    required bool isDark,
  }) {
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textMuted = isDark ? AppColors.textMutedDark : const Color(0xFF64748B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeLg,
                    fontWeight: AppTypography.bold,
                    color: textColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeSm - 0.5,
                      color: textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                "See all",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: AppTypography.sizeSm,
                  fontWeight: AppTypography.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color inactiveColor = isDark ? AppColors.textMutedDark : const Color(0xff64748B);

    final homeRepo = context.read<HomeRepository>();

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppProfileDrawer(),
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Tab 0: Home Page Feed
          SafeArea(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Section 1: Top Bar & Filter Chips (Driven by HomeBloc)[cite: 15]
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (prev, curr) =>
                          prev.selectedCity != curr.selectedCity ||
                          prev.selectedCategory != curr.selectedCategory ||
                          prev.creativeProfessionals.length != curr.creativeProfessionals.length,
                      builder: (context, state) {
                        return TopBarSection(
                          selectedCity: state.selectedCity,
                          selectedCategory: state.selectedCategory,
                          professionalsCount: state.creativeProfessionals.length,
                          onPostGigTap: _onPostGig,
                          onNotificationsTap: _onNotifications,
                          onProfileTap: _onProfile,
                          onCityChanged: _onCityChanged,
                          onCategoryChanged: _onCategoryChanged,
                          onSearchSubmitted: _onSearch,
                          onSortTap: _onSort,
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.space4),

                    // Section 2: Creative Professionals
                    BlocSelector<HomeBloc, HomeState, (bool, List<CreativeProModel>)>(
                      selector: (state) => (state.isLoadingCreativePros, state.creativeProfessionals),
                      builder: (context, data) {
                        final (isLoading, professionals) = data;
                        return CreativeProfessionalsSection(
                          professionals: professionals,
                          isLoading: isLoading,
                          onViewAllTap: () {
                            final currentCity = context.read<HomeBloc>().state.selectedCity;
                            final currentCategory = context.read<HomeBloc>().state.selectedCategory;
                            final homeBloc = context.read<HomeBloc>();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ViewAllScreen<CreativeProModel>(
                                  title: "Creative Professionals",
                                  seedItems: professionals,
                                  fetcher: ({
                                    required int page,
                                    required int limit,
                                    Map<String, dynamic>? filters,
                                  }) async {
                                    final result = await homeRepo.getCreativeProfessionals(
                                      page: page,
                                      limit: limit,
                                      city: currentCity,
                                      category: currentCategory,
                                    );

                                    return result.fold(
                                      (data, _) => PaginatedResult<CreativeProModel>(
                                        items: data,
                                        total: 100,
                                        page: page,
                                        hasReachedMax: data.length < limit,
                                      ),
                                      (failure) => throw Exception(failure.message),
                                    );
                                  },
                                  itemBuilder: (ctx, pro) => CreativeProCard(
                                    pro: pro,
                                    onConnect: () => _showToast("Connection request sent to ${pro.fullName}"),
                                    onProfile: () => _navigateToCreativeProfile(pro),
                                    onBookmark: () {
                                      homeBloc.add(HomeBookmarkToggled(pro));
                                      _showToast("Updated bookmark for ${pro.fullName}");
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          onConnectTap: (pro) => _showToast("Connection request sent to ${pro.fullName}"),
                          onProfileTap: _navigateToCreativeProfile,
                          onBookmarkTap: (pro) {
                            context.read<HomeBloc>().add(HomeBookmarkToggled(pro));
                            _showToast("Updated bookmark for ${pro.fullName}");
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),

                    // Section 3: Spotlight (SWR 2-Column Grid)
                    BlocSelector<HomeBloc, HomeState, (bool, List<CreativeProModel>)>(
                      selector: (state) => (state.isLoadingSpotlight, state.spotlightProfiles),
                      builder: (context, data) {
                        final (isLoading, spotlightProfiles) = data;
                        return SpotlightSection(
                          profiles: spotlightProfiles,
                          isLoading: isLoading,
                          onViewAllTap: () {
                            final currentCity = context.read<HomeBloc>().state.selectedCity;
                            final currentCategory = context.read<HomeBloc>().state.selectedCategory;
                            final homeBloc = context.read<HomeBloc>();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ViewAllScreen<CreativeProModel>(
                                  title: "Spotlight",
                                  seedItems: spotlightProfiles,
                                  layoutType: PaginatedLayoutType.grid,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.60,
                                  ),
                                  fetcher: ({
                                    required int page,
                                    required int limit,
                                    Map<String, dynamic>? filters,
                                  }) async {
                                    final result = await homeRepo.getSpotlightProfiles(
                                      page: page,
                                      limit: limit,
                                      city: currentCity,
                                      category: currentCategory,
                                    );

                                    return result.fold(
                                      (data, _) => PaginatedResult<CreativeProModel>(
                                        items: data,
                                        total: 100,
                                        page: page,
                                        hasReachedMax: data.length < limit,
                                      ),
                                      (failure) => throw Exception(failure.message),
                                    );
                                  },
                                  itemBuilder: (ctx, pro) => SpotlightCard(
                                    pro: pro,
                                    onConnect: () => _showToast("Connection request sent to ${pro.fullName}"),
                                    onProfile: () => _navigateToCreativeProfile(pro),
                                    onFavorite: () {
                                      homeBloc.add(HomeBookmarkToggled(pro));
                                      _showToast("Updated favorite for ${pro.fullName}");
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          onConnectTap: (pro) => _showToast("Connection request sent to ${pro.fullName}"),
                          onProfileTap: _navigateToCreativeProfile,
                          onFavoriteTap: (pro) {
                            context.read<HomeBloc>().add(HomeBookmarkToggled(pro));
                            _showToast("Updated favorite for ${pro.fullName}");
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),

                    // Section 4: Featured Professionals (SWR Horizontal Card List)
                    BlocSelector<HomeBloc, HomeState, (bool, List<CreativeProModel>)>(
                      selector: (state) => (state.isLoadingFeaturedPros, state.featuredProfessionals),
                      builder: (context, data) {
                        final (isLoading, featuredPros) = data;
                        return FeaturedProfessionalsSection(
                          professionals: featuredPros,
                          isLoading: isLoading,
                          onViewAllTap: () {
                            final currentCity = context.read<HomeBloc>().state.selectedCity;
                            final currentCategory = context.read<HomeBloc>().state.selectedCategory;
                            final homeBloc = context.read<HomeBloc>();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ViewAllScreen<CreativeProModel>(
                                  title: "Featured Professionals",
                                  seedItems: featuredPros,
                                  layoutType: PaginatedLayoutType.list,
                                  fetcher: ({
                                    required int page,
                                    required int limit,
                                    Map<String, dynamic>? filters,
                                  }) async {
                                    final result = await homeRepo.getFeaturedProfessionals(
                                      page: page,
                                      limit: limit,
                                      city: currentCity,
                                      category: currentCategory,
                                    );

                                    return result.fold(
                                      (data, _) => PaginatedResult<CreativeProModel>(
                                        items: data,
                                        total: 100,
                                        page: page,
                                        hasReachedMax: data.length < limit,
                                      ),
                                      (failure) => throw Exception(failure.message),
                                    );
                                  },
                                  itemBuilder: (ctx, pro) => FeaturedProCard(
                                    pro: pro,
                                    onView: () => _navigateToCreativeProfile(pro),
                                    onConnect: () => _showToast("Connection request sent to ${pro.fullName}"),
                                    onFavorite: () {
                                      homeBloc.add(HomeBookmarkToggled(pro));
                                      _showToast("Updated favorite for ${pro.fullName}");
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          onViewTap: _navigateToCreativeProfile,
                          onConnectTap: (pro) => _showToast("Connection request sent to ${pro.fullName}"),
                          onFavoriteTap: (pro) {
                            context.read<HomeBloc>().add(HomeBookmarkToggled(pro));
                            _showToast("Updated favorite for ${pro.fullName}");
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),

                    // Section 5: Prime (SWR 2-Column Grid)
                    BlocSelector<HomeBloc, HomeState, (bool, List<CreativeProModel>)>(
                      selector: (state) => (state.isLoadingPrime, state.primeProfiles),
                      builder: (context, data) {
                        final (isLoading, primeProfiles) = data;
                        return PrimeSection(
                          profiles: primeProfiles,
                          isLoading: isLoading,
                          onSeeAllTap: () {
                            final currentCity = context.read<HomeBloc>().state.selectedCity;
                            final currentCategory = context.read<HomeBloc>().state.selectedCategory;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ViewAllScreen<CreativeProModel>(
                                  title: "Prime Profiles",
                                  seedItems: primeProfiles,
                                  layoutType: PaginatedLayoutType.grid,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.68,
                                  ),
                                  fetcher: ({
                                    required int page,
                                    required int limit,
                                    Map<String, dynamic>? filters,
                                  }) async {
                                    final result = await homeRepo.getPrimeProfiles(
                                      page: page,
                                      limit: limit,
                                      city: currentCity,
                                      category: currentCategory,
                                    );

                                    return result.fold(
                                      (data, _) => PaginatedResult<CreativeProModel>(
                                        items: data,
                                        total: 100,
                                        page: page,
                                        hasReachedMax: data.length < limit,
                                      ),
                                      (failure) => throw Exception(failure.message),
                                    );
                                  },
                                  itemBuilder: (ctx, pro) => PrimeCard(
                                    pro: pro,
                                    onTap: () => _navigateToCreativeProfile(pro),
                                  ),
                                ),
                              ),
                            );
                          },
                          onProTap: _navigateToCreativeProfile,
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),

                    // Section 6: Rising Stars (SWR Horizontal Carousel)
                    BlocSelector<HomeBloc, HomeState, (bool, List<CreativeProModel>)>(
                      selector: (state) => (state.isLoadingRisingStars, state.risingStars),
                      builder: (context, data) {
                        final (isLoading, risingStars) = data;
                        return RisingStarsSection(
                          stars: risingStars,
                          isLoading: isLoading,
                          onSeeAllTap: () {
                            final currentCity = context.read<HomeBloc>().state.selectedCity;
                            final currentCategory = context.read<HomeBloc>().state.selectedCategory;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ViewAllScreen<CreativeProModel>(
                                  title: "Rising Stars",
                                  seedItems: risingStars,
                                  layoutType: PaginatedLayoutType.grid,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.72,
                                  ),
                                  fetcher: ({
                                    required int page,
                                    required int limit,
                                    Map<String, dynamic>? filters,
                                  }) async {
                                    final result = await homeRepo.getRisingStars(
                                      page: page,
                                      limit: limit,
                                      city: currentCity,
                                      category: currentCategory,
                                    );

                                    return result.fold(
                                      (data, _) => PaginatedResult<CreativeProModel>(
                                        items: data,
                                        total: 100,
                                        page: page,
                                        hasReachedMax: data.length < limit,
                                      ),
                                      (failure) => throw Exception(failure.message),
                                    );
                                  },
                                  itemBuilder: (ctx, star) => RisingStarCard(
                                    star: star,
                                    onTap: () => _navigateToCreativeProfile(star),
                                  ),
                                ),
                              ),
                            );
                          },
                          onStarTap: _navigateToCreativeProfile,
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),

                    // Section 7: Brand Opportunities (3-Tier: High-Priority -> Boosted -> Featured)
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (prev, curr) =>
                          prev.highPriorityOpportunities != curr.highPriorityOpportunities ||
                          prev.isLoadingHighPriority != curr.isLoadingHighPriority ||
                          prev.boostedOpportunities != curr.boostedOpportunities ||
                          prev.isLoadingBoosted != curr.isLoadingBoosted ||
                          prev.featuredOpportunities != curr.featuredOpportunities ||
                          prev.isLoadingFeatured != curr.isLoadingFeatured,
                      builder: (context, state) {
                        final homeBloc = context.read<HomeBloc>();

                        return BrandOpportunitiesSection(
                          highPriorityOpps: state.highPriorityOpportunities,
                          isLoadingHighPriority: state.isLoadingHighPriority,
                          onViewAllHighPriority: () => _navigateToOpportunitiesViewAll(
                            title: "High-Priority Contracts",
                            seedItems: state.highPriorityOpportunities,
                            fetchMethod: homeRepo.getHighPriorityOpportunities,
                          ),
                          boostedOpps: state.boostedOpportunities,
                          isLoadingBoosted: state.isLoadingBoosted,
                          onViewAllBoosted: () => _navigateToOpportunitiesViewAll(
                            title: "Boosted Opportunities",
                            seedItems: state.boostedOpportunities,
                            fetchMethod: homeRepo.getBoostedOpportunities,
                          ),
                          featuredOpps: state.featuredOpportunities,
                          isLoadingFeatured: state.isLoadingFeatured,
                          onViewAllFeatured: () => _navigateToOpportunitiesViewAll(
                            title: "Featured Job Postings",
                            seedItems: state.featuredOpportunities,
                            fetchMethod: homeRepo.getFeaturedOpportunities,
                          ),
                          onCardTap: (opp) => _showToast("Opening brief: ${opp.title}"),
                          onApplyTap: _onApplyOpportunity,
                          onSaveTap: (opp) {
                            homeBloc.add(HomeOpportunitySaveToggled(opp));
                            _showToast(opp.isSaved ? "Removed from saved" : "Saved ${opp.title}");
                          },
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),
                    BusinessOpportunitiesSection(
                      onSeeAllTap: () => _showToast("Viewing all business opportunities"),
                      onPostServiceOfferTap: () => _showToast("Opening service offer composer..."),
                      onItemTap: (item) => _showToast("Selected ${item['title']}"),
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    TrendingWorkStylesSection(
                      onExploreTap: () => _showToast("Exploring all shoot categories"),
                      onStyleTap: (style) => _showToast("Filtered by ${style['title']}"),
                    ),

                    const SizedBox(height: AppSpacing.space6),

                    // ── Section 9: High-Priority Gigs (3-Tier Package Selectors & Priority Pill)
                    BlocSelector<HomeBloc, HomeState, (bool, List<GigModel>)>(
                      selector: (state) => (state.isLoadingHighPriorityGigs, state.highPriorityGigs),
                      builder: (context, data) {
                        final (isLoading, gigs) = data;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader(
                              title: "High-Priority Gigs",
                              subtitle: "Fast turnaround & priority delivery packages",
                              isDark: isDark,
                              onSeeAll: () => _navigateToGigsViewAll(
                                title: "High-Priority Gigs",
                                seedItems: gigs,
                                layoutType: PaginatedLayoutType.list,
                                fetchMethod: homeRepo.getHighPriorityGigs,
                                itemBuilder: (ctx, gig) => Padding(
                                  padding: const EdgeInsets.only(bottom: AppSpacing.space3),
                                  child: HighPriorityGigCard(
                                    gig: gig,
                                    width: double.infinity,
                                    onTap: () => _onViewGigDetails(gig),
                                    onFavoriteTap: () => _onFavoriteGig(gig),
                                    onChatTap: () => _onChatWithSeller(gig),
                                    onTierSelected: (tier) => _showToast(
                                      "Selected ${tier.label} (${tier.price})",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.space3),
                            SizedBox(
                              height: 485,
                              child: isLoading
                                  ? ListView.separated(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.space3),
                                      itemBuilder: (_, __) => const HighPriorityGigCardSkeleton(width: 320),
                                    )
                                  : ListView.separated(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: gigs.take(3).length,
                                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.space3),
                                      itemBuilder: (ctx, idx) {
                                        final gig = gigs[idx];
                                        return HighPriorityGigCard(
                                          gig: gig,
                                          width: 320,
                                          onTap: () => _onViewGigDetails(gig),
                                          onFavoriteTap: () => _onFavoriteGig(gig),
                                          onChatTap: () => _onChatWithSeller(gig),
                                          onTierSelected: (tier) => _showToast(
                                            "Selected ${tier.label} (${tier.price})",
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),

                    // ── Section 10: Pro Master Gigs (Horizontal Card Row Layout)
                    BlocSelector<HomeBloc, HomeState, (bool, List<GigModel>)>(
                      selector: (state) => (state.isLoadingProMasterGigs, state.proMasterGigs),
                      builder: (context, data) {
                        final (isLoading, gigs) = data;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader(
                              title: "Pro Master Gigs",
                              subtitle: "Verified top-tier talent & agency-grade production",
                              isDark: isDark,
                              onSeeAll: () => _navigateToGigsViewAll(
                                title: "Pro Master Gigs",
                                seedItems: gigs,
                                layoutType: PaginatedLayoutType.list,
                                fetchMethod: homeRepo.getProMasterGigs,
                                itemBuilder: (ctx, gig) => Padding(
                                  padding: const EdgeInsets.only(bottom: AppSpacing.space3),
                                  child: ProMasterGigCard(
                                    gig: gig,
                                    width: double.infinity,
                                    onTap: () => _onViewGigDetails(gig),
                                    onViewGigTap: () => _onViewGigDetails(gig),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.space3),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
                              child: isLoading
                                  ? Column(
                                      children: List.generate(
                                        3,
                                        (i) => const Padding(
                                          padding: EdgeInsets.only(bottom: AppSpacing.space3),
                                          child: ProMasterGigCardSkeleton(width: double.infinity),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: gigs.take(3).map((gig) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: AppSpacing.space3),
                                          child: ProMasterGigCard(
                                            gig: gig,
                                            width: double.infinity,
                                            onTap: () => _onViewGigDetails(gig),
                                            onViewGigTap: () => _onViewGigDetails(gig),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),

                    // ── Section 11: Featured Gigs (Cover Showcase & Scrim)
                    BlocSelector<HomeBloc, HomeState, (bool, List<GigModel>)>(
                      selector: (state) => (state.isLoadingFeaturedGigs, state.featuredGigs),
                      builder: (context, data) {
                        final (isLoading, gigs) = data;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader(
                              title: "Featured Gigs",
                              subtitle: "Promoted creative offerings hand-picked this week",
                              isDark: isDark,
                              onSeeAll: () => _navigateToGigsViewAll(
                                title: "Featured Gigs",
                                seedItems: gigs,
                                layoutType: PaginatedLayoutType.grid,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.62,
                                ),
                                fetchMethod: homeRepo.getFeaturedGigs,
                                itemBuilder: (ctx, gig) => FeaturedGigCard(
                                  gig: gig,
                                  width: double.infinity,
                                  onTap: () => _onViewGigDetails(gig),
                                  onFavoriteTap: () => _onFavoriteGig(gig),
                                  onViewTap: () => _onViewGigDetails(gig),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.space3),
                            SizedBox(
                              height: 260,
                              child: isLoading
                                  ? ListView.separated(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
                                      scrollDirection: Axis.horizontal,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.space3),
                                      itemBuilder: (_, __) => const FeaturedGigCardSkeleton(width: 240),
                                    )
                                  : ListView.separated(
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: gigs.take(3).length,
                                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.space3),
                                      itemBuilder: (ctx, idx) {
                                        final gig = gigs[idx];
                                        return FeaturedGigCard(
                                          gig: gig,
                                          width: 240,
                                          onTap: () => _onViewGigDetails(gig),
                                          onFavoriteTap: () => _onFavoriteGig(gig),
                                          onViewTap: () => _onViewGigDetails(gig),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.space6),
                    SkilledGigsSection(
                      onExploreTap: () => _showToast("Exploring all skilled categories"),
                      onCategoryTap: (cat) => _showToast("Browsing ${cat['title']} opportunities"),
                    ),
                    const SizedBox(height: AppSpacing.space10),
                  ],
                ),
              ),
            ),
          ),

          // Tab 1: Professionals
          const ProfessionalsScreen(),

          // Tab 2: Opportunities
          const OpportunitiesScreen(),

          // Tab 3: GIGs Screen
          const GigsScreen(),

          // Tab 4: Messaging
          const InboxScreen(),
        ],
      ),

      // Fixed Bottom Navigation Bar using LucideIcons
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          border: Border(top: BorderSide(color: borderColor, width: 1.0)),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, "Home", LucideIcons.house, activeColor, inactiveColor),
                _buildNavItem(1, "Professionals", LucideIcons.users, activeColor, inactiveColor),
                _buildNavItem(2, "Opportunities", LucideIcons.briefcase, activeColor, inactiveColor),
                _buildNavItem(3, "GIGs", LucideIcons.box, activeColor, inactiveColor),
                _buildNavItem(4, "Messaging", LucideIcons.messageSquare, activeColor, inactiveColor, badgeCount: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String label,
    IconData icon,
    Color activeColor,
    Color inactiveColor, {
    int? badgeCount,
  }) {
    final bool isSelected = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isSelected ? activeColor : inactiveColor,
                  size: 20,
                ),
                if (badgeCount != null && badgeCount > 0)
                  Positioned(
                    top: -4,
                    right: -7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: const BoxDecoration(
                        color: Color(0xffEF4444),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: Text(
                        '$badgeCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
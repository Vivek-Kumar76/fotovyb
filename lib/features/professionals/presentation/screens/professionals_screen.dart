import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/pagination/paginated_result.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../../core/widgets/paginated_infinite_scroll_view.dart';
import '../../../home/data/models/creative_pro_model.dart';
import '../../../home/presentation/screens/view_all_screen.dart';
import '../../../profile/presentation/screens/creative_profile_screen.dart';
import '../../domain/repositories/professionals_repository.dart';
import '../../widgets/01_pros_hero_search_section.dart';
import '../../widgets/pros_tier_carousel_section.dart';
import '../bloc/professionals_bloc.dart';
import '../bloc/professionals_event.dart';
import '../bloc/professionals_state.dart';

class _RolePillItem {
  final String label;
  final IconData icon;

  const _RolePillItem({required this.label, required this.icon});
}

class ProfessionalsScreen extends StatelessWidget {
  const ProfessionalsScreen({super.key});

  static const List<_RolePillItem> _rolePills = [
    _RolePillItem(label: "All", icon: LucideIcons.users),
    _RolePillItem(label: "Photographer", icon: LucideIcons.camera),
    _RolePillItem(label: "Stylist", icon: LucideIcons.shirt),
    _RolePillItem(label: "Model", icon: LucideIcons.user),
    _RolePillItem(label: "Videographer", icon: LucideIcons.video),
    _RolePillItem(label: "MUA", icon: LucideIcons.brush),
  ];

  void _showNotice(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xff2E7D6E),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _navigateToProfile(BuildContext context, CreativeProModel pro) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreativeProfileScreen()),
    );
  }

  Future<void> _handleRefresh(BuildContext context) async {
    context.read<ProfessionalsBloc>().add(const ProfessionalsRefreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final prosRepo = context.read<ProfessionalsRepository>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => _handleRefresh(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Hero Search, City & Role Dropdowns
              BlocBuilder<ProfessionalsBloc, ProfessionalsState>(
                buildWhen: (prev, curr) =>
                    prev.selectedCity != curr.selectedCity ||
                    prev.selectedCategory != curr.selectedCategory,
                builder: (context, state) {
                  return ProsHeroSearchSection(
                    selectedCity: state.selectedCity,
                    selectedRole: state.selectedCategory,
                    onSearch: (q) {
                      context
                          .read<ProfessionalsBloc>()
                          .add(ProfessionalsSearchChanged(q));
                    },
                    onCityChanged: (city) {
                      context
                          .read<ProfessionalsBloc>()
                          .add(ProfessionalsCityChanged(city));
                      _showNotice(
                        context,
                        city == 'All'
                            ? 'Showing all locations'
                            : 'Location: $city',
                      );
                    },
                    onRoleChanged: (role) {
                      context
                          .read<ProfessionalsBloc>()
                          .add(ProfessionalsCategoryChanged(role));
                      _showNotice(
                        context,
                        role == 'All' ? 'Showing all roles' : 'Role: $role',
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 16),

              // ── Horizontal Role Filter Pills
              BlocSelector<ProfessionalsBloc, ProfessionalsState, String>(
                selector: (state) => state.selectedCategory,
                builder: (context, selectedCategory) {
                  return SizedBox(
                    height: 38,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: _rolePills.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (ctx, idx) {
                        final item = _rolePills[idx];
                        final isSelected = selectedCategory == item.label;

                        return GestureDetector(
                          onTap: () => context
                              .read<ProfessionalsBloc>()
                              .add(ProfessionalsCategoryChanged(item.label)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? AppColors.buttonGradientCreative
                                  : null,
                              color: isSelected ? null : cardBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : borderColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  item.icon,
                                  size: 14,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xff64748B),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xff475569),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 22),

              // ── 1. Spotlight Section
              BlocSelector<ProfessionalsBloc, ProfessionalsState,
                  (bool, List<CreativeProModel>)>(
                selector: (state) =>
                    (state.isLoadingSpotlight, state.spotlightProfiles),
                builder: (context, data) {
                  final (isLoading, items) = data;
                  return ProsTierCarouselSection(
                    title: 'Spotlight',
                    badgeLabel: 'Spotlight',
                    headerIcon: LucideIcons.sparkles,
                    accentColor: const Color(0xffD97706),
                    items: items,
                    isLoading: isLoading,
                    emptyMessage:
                        'No Spotlight professionals available right now.',
                    onViewAllTap: () => _openViewAll(
                      context: context,
                      title: 'Spotlight',
                      badgeLabel: 'Spotlight',
                      accentColor: const Color(0xffD97706),
                      seedItems: items,
                      fetcher: ({required page, required limit, filters}) async {
                        final st = context.read<ProfessionalsBloc>().state;
                        final res = await prosRepo.getSpotlightProfiles(
                          page: page,
                          limit: limit,
                          search: st.searchQuery,
                          city: st.selectedCity,
                          category: st.selectedCategory,
                        );
                        return res.fold(
                          (paginated, _) => paginated,
                          (failure) => throw Exception(failure.message),
                        );
                      },
                    ),
                    onConnectTap: (pro) => _showNotice(
                      context,
                      'Connection request sent to ${pro.fullName}',
                    ),
                    onViewTap: (pro) => _navigateToProfile(context, pro),
                  );
                },
              ),

              const SizedBox(height: 26),

              // ── 2. Prime Section
              BlocSelector<ProfessionalsBloc, ProfessionalsState,
                  (bool, List<CreativeProModel>)>(
                selector: (state) =>
                    (state.isLoadingPrime, state.primeProfiles),
                builder: (context, data) {
                  final (isLoading, items) = data;
                  return ProsTierCarouselSection(
                    title: 'Prime',
                    badgeLabel: 'Prime',
                    headerIcon: LucideIcons.badgeCheck,
                    accentColor: const Color(0xff0D9488),
                    items: items,
                    isLoading: isLoading,
                    emptyMessage: 'No Prime professionals available right now.',
                    onViewAllTap: () => _openViewAll(
                      context: context,
                      title: 'Prime',
                      badgeLabel: 'Prime',
                      accentColor: const Color(0xff0D9488),
                      seedItems: items,
                      fetcher: ({required page, required limit, filters}) async {
                        final st = context.read<ProfessionalsBloc>().state;
                        final res = await prosRepo.getPrimeProfiles(
                          page: page,
                          limit: limit,
                          search: st.searchQuery,
                          city: st.selectedCity,
                          category: st.selectedCategory,
                        );
                        return res.fold(
                          (paginated, _) => paginated,
                          (failure) => throw Exception(failure.message),
                        );
                      },
                    ),
                    onConnectTap: (pro) => _showNotice(
                      context,
                      'Connection request sent to ${pro.fullName}',
                    ),
                    onViewTap: (pro) => _navigateToProfile(context, pro),
                  );
                },
              ),

              const SizedBox(height: 26),

              // ── 3. Featured Section
              BlocSelector<ProfessionalsBloc, ProfessionalsState,
                  (bool, List<CreativeProModel>)>(
                selector: (state) => (
                  state.isLoadingFeaturedPros,
                  state.featuredProfessionals
                ),
                builder: (context, data) {
                  final (isLoading, items) = data;
                  return ProsTierCarouselSection(
                    title: 'Featured',
                    badgeLabel: 'Featured',
                    headerIcon: LucideIcons.star,
                    accentColor: const Color(0xff1D4ED8),
                    items: items,
                    isLoading: isLoading,
                    emptyMessage:
                        'No Featured professionals available right now.',
                    onViewAllTap: () => _openViewAll(
                      context: context,
                      title: 'Featured',
                      badgeLabel: 'Featured',
                      accentColor: const Color(0xff1D4ED8),
                      seedItems: items,
                      fetcher: ({required page, required limit, filters}) async {
                        final st = context.read<ProfessionalsBloc>().state;
                        final res = await prosRepo.getFeaturedProfessionals(
                          page: page,
                          limit: limit,
                          search: st.searchQuery,
                          city: st.selectedCity,
                          category: st.selectedCategory,
                        );
                        return res.fold(
                          (paginated, _) => paginated,
                          (failure) => throw Exception(failure.message),
                        );
                      },
                    ),
                    onConnectTap: (pro) => _showNotice(
                      context,
                      'Connection request sent to ${pro.fullName}',
                    ),
                    onViewTap: (pro) => _navigateToProfile(context, pro),
                  );
                },
              ),

              const SizedBox(height: 26),

              // ── 4. Rising Star Section
              BlocSelector<ProfessionalsBloc, ProfessionalsState,
                  (bool, List<CreativeProModel>)>(
                selector: (state) =>
                    (state.isLoadingRisingStars, state.risingStars),
                builder: (context, data) {
                  final (isLoading, items) = data;
                  return ProsTierCarouselSection(
                    title: 'Rising Star',
                    badgeLabel: 'Rising Star',
                    headerIcon: LucideIcons.trendingUp,
                    accentColor: const Color(0xff7C3AED),
                    items: items,
                    isLoading: isLoading,
                    emptyMessage:
                        'No Rising Star professionals available right now.',
                    onViewAllTap: () => _openViewAll(
                      context: context,
                      title: 'Rising Star',
                      badgeLabel: 'Rising Star',
                      accentColor: const Color(0xff7C3AED),
                      seedItems: items,
                      fetcher: ({required page, required limit, filters}) async {
                        final st = context.read<ProfessionalsBloc>().state;
                        final res = await prosRepo.getRisingStars(
                          page: page,
                          limit: limit,
                          search: st.searchQuery,
                          city: st.selectedCity,
                          category: st.selectedCategory,
                        );
                        return res.fold(
                          (paginated, _) => paginated,
                          (failure) => throw Exception(failure.message),
                        );
                      },
                    ),
                    onConnectTap: (pro) => _showNotice(
                      context,
                      'Connection request sent to ${pro.fullName}',
                    ),
                    onViewTap: (pro) => _navigateToProfile(context, pro),
                  );
                },
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void _openViewAll({
    required BuildContext context,
    required String title,
    required String badgeLabel,
    required Color accentColor,
    required List<CreativeProModel> seedItems,
    required Future<PaginatedResult<CreativeProModel>> Function({
      required int page,
      required int limit,
      Map<String, dynamic>? filters,
    }) fetcher,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ViewAllScreen<CreativeProModel>(
          title: title,
          seedItems: seedItems,
          layoutType: PaginatedLayoutType.grid,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          fetcher: fetcher,
          itemBuilder: (ctx, pro) => ProsTierProCard(
            pro: pro,
            badgeLabel: badgeLabel,
            accentColor: accentColor,
            onConnect: () => _showNotice(
              context,
              'Connection request sent to ${pro.fullName}',
            ),
            onView: () => _navigateToProfile(context, pro),
          ),
        ),
      ),
    );
  }
}
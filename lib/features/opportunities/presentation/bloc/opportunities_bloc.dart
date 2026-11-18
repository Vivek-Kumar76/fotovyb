import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/opportunities_feed_page.dart';
import '../../data/models/opportunity_item_model.dart';
import '../../domain/repositories/opportunities_repository.dart';
import 'opportunities_event.dart';
import 'opportunities_state.dart';

class OpportunitiesBloc extends Bloc<OpportunitiesEvent, OpportunitiesState> {
  final OpportunitiesRepository repository;

  static const int _defaultLimit = 20;

  OpportunitiesBloc({required this.repository})
      : super(const OpportunitiesState()) {
    on<OpportunitiesLoadRequested>(_onLoadRequested);
    on<OpportunitiesRefreshRequested>(_onRefreshRequested);
    on<OpportunitiesFiltersApplied>(_onFiltersApplied);
    on<OpportunitiesFiltersCleared>(_onFiltersCleared);
    on<OpportunityApplyRequested>(_onApplyRequested);
  }

  Future<void> _onLoadRequested(
    OpportunitiesLoadRequested event,
    Emitter<OpportunitiesState> emit,
  ) async {
    // 1. Hydrate from SWR cache first if unfiltered
    if (!state.hasActiveFilters) {
      final cachedResults = await Future.wait([
        repository.getCachedSection('high-priority'),
        repository.getCachedSection('boosted'),
        repository.getCachedSection('featured'),
      ]);

      final cachedHp = cachedResults[0];
      final cachedBoosted = cachedResults[1];
      final cachedFeatured = cachedResults[2];

      if (cachedHp != null || cachedBoosted != null || cachedFeatured != null) {
        emit(state.copyWith(
          highPriorityItems: cachedHp?.paginated.items ?? state.highPriorityItems,
          highPriorityTotal: cachedHp?.paginated.total ?? state.highPriorityTotal,
          isLoadingHighPriority: cachedHp == null,
          boostedItems: cachedBoosted?.paginated.items ?? state.boostedItems,
          boostedTotal: cachedBoosted?.paginated.total ?? state.boostedTotal,
          isLoadingBoosted: cachedBoosted == null,
          featuredItems:
              cachedFeatured?.paginated.items ?? state.featuredItems,
          featuredTotal:
              cachedFeatured?.paginated.total ?? state.featuredTotal,
          isLoadingFeatured: cachedFeatured == null,
          facets: cachedHp?.facets ??
              cachedBoosted?.facets ??
              cachedFeatured?.facets ??
              state.facets,
        ));
      }
    }

    // 2. Fetch live sections concurrently
    await _fetchAllSections(emit, showShimmer: state.highPriorityItems.isEmpty &&
        state.boostedItems.isEmpty &&
        state.featuredItems.isEmpty);
  }

  Future<void> _onRefreshRequested(
    OpportunitiesRefreshRequested event,
    Emitter<OpportunitiesState> emit,
  ) async {
    await _fetchAllSections(emit, showShimmer: false);
  }

  Future<void> _onFiltersApplied(
    OpportunitiesFiltersApplied event,
    Emitter<OpportunitiesState> emit,
  ) async {
    emit(state.copyWith(
      selectedBudgetRange: event.budgetRange,
      selectedRoles: Set<String>.from(event.roles),
      selectedIndustries: Set<String>.from(event.industries),
      selectedLocations: Set<String>.from(event.locations),
      selectedRating: event.rating,
      clearError: true,
    ));

    await _fetchAllSections(emit, showShimmer: true);
  }

  Future<void> _onFiltersCleared(
    OpportunitiesFiltersCleared event,
    Emitter<OpportunitiesState> emit,
  ) async {
    emit(state.copyWith(
      selectedBudgetRange: '',
      selectedRoles: const {},
      selectedIndustries: const {},
      selectedLocations: const {},
      selectedRating: '',
      clearError: true,
    ));

    await _fetchAllSections(emit, showShimmer: true);
  }

  Future<void> _fetchAllSections(
    Emitter<OpportunitiesState> emit, {
    required bool showShimmer,
  }) async {
    if (showShimmer) {
      emit(state.copyWith(
        isLoadingHighPriority: true,
        isLoadingBoosted: true,
        isLoadingFeatured: true,
        clearError: true,
      ));
    }

    final categoryParam = state.selectedIndustries.isEmpty
        ? null
        : state.selectedIndustries.join(',');
    final locationParam = state.selectedLocations.isEmpty
        ? null
        : state.selectedLocations.join(',');
    final rolesParam =
        state.selectedRoles.isEmpty ? null : state.selectedRoles.toList();
    final budgetParam = state.selectedBudgetRange.trim().isEmpty
        ? null
        : state.selectedBudgetRange.trim();

    await Future.wait([
      _fetchHighPriority(
        emit,
        category: categoryParam,
        location: locationParam,
        roles: rolesParam,
        budgetRange: budgetParam,
      ),
      _fetchBoosted(
        emit,
        category: categoryParam,
        location: locationParam,
        roles: rolesParam,
        budgetRange: budgetParam,
      ),
      _fetchFeatured(
        emit,
        category: categoryParam,
        location: locationParam,
        roles: rolesParam,
        budgetRange: budgetParam,
      ),
    ]);
  }

  Future<void> _fetchHighPriority(
    Emitter<OpportunitiesState> emit, {
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) async {
    try {
      final pageData = await repository.getHighPriorityOpportunities(
        page: 1,
        limit: _defaultLimit,
        category: category,
        location: location,
        roles: roles,
        budgetRange: budgetRange,
      );
      emit(state.copyWith(
        highPriorityItems: pageData.paginated.items,
        highPriorityTotal: pageData.paginated.total,
        isLoadingHighPriority: false,
        facets: _pickNonEmptyFacets(pageData.facets, state.facets),
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingHighPriority: false,
        errorMessage: _cleanError(e),
      ));
    }
  }

  Future<void> _fetchBoosted(
    Emitter<OpportunitiesState> emit, {
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) async {
    try {
      final pageData = await repository.getBoostedOpportunities(
        page: 1,
        limit: _defaultLimit,
        category: category,
        location: location,
        roles: roles,
        budgetRange: budgetRange,
      );
      emit(state.copyWith(
        boostedItems: pageData.paginated.items,
        boostedTotal: pageData.paginated.total,
        isLoadingBoosted: false,
        facets: _pickNonEmptyFacets(pageData.facets, state.facets),
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingBoosted: false,
        errorMessage: _cleanError(e),
      ));
    }
  }

  Future<void> _fetchFeatured(
    Emitter<OpportunitiesState> emit, {
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) async {
    try {
      final pageData = await repository.getFeaturedOpportunities(
        page: 1,
        limit: _defaultLimit,
        category: category,
        location: location,
        roles: roles,
        budgetRange: budgetRange,
      );
      emit(state.copyWith(
        featuredItems: pageData.paginated.items,
        featuredTotal: pageData.paginated.total,
        isLoadingFeatured: false,
        facets: _pickNonEmptyFacets(pageData.facets, state.facets),
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingFeatured: false,
        errorMessage: _cleanError(e),
      ));
    }
  }

  Future<void> _onApplyRequested(
    OpportunityApplyRequested event,
    Emitter<OpportunitiesState> emit,
  ) async {
    final targetId = event.opportunityId.trim();
    if (targetId.isEmpty) return;

    emit(state.copyWith(
      applyingOpportunityId: targetId,
      highPriorityItems: _markApplied(state.highPriorityItems, targetId, true),
      boostedItems: _markApplied(state.boostedItems, targetId, true),
      featuredItems: _markApplied(state.featuredItems, targetId, true),
      clearError: true,
    ));

    try {
      await repository.applyToOpportunity(targetId);
      emit(state.copyWith(clearApplyingId: true));
    } catch (e) {
      emit(state.copyWith(
        clearApplyingId: true,
        highPriorityItems:
            _markApplied(state.highPriorityItems, targetId, false),
        boostedItems: _markApplied(state.boostedItems, targetId, false),
        featuredItems: _markApplied(state.featuredItems, targetId, false),
        errorMessage: _cleanError(e),
      ));
    }
  }

  List<OpportunityItemModel> _markApplied(
    List<OpportunityItemModel> list,
    String id,
    bool applied,
  ) {
    return list
        .map((item) => item.id == id ? item.copyWith(isApplied: applied) : item)
        .toList();
  }

  OpportunityFacets _pickNonEmptyFacets(
    OpportunityFacets incoming,
    OpportunityFacets current,
  ) {
    final hasIncoming = incoming.sections.isNotEmpty ||
        incoming.categories.isNotEmpty ||
        incoming.locations.isNotEmpty ||
        incoming.roles.isNotEmpty ||
        incoming.budgetRange.isNotEmpty;
    return hasIncoming ? incoming : current;
  }

  String _cleanError(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }
}
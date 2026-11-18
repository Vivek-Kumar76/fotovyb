import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/gig_item_model.dart';
import '../../data/models/gigs_feed_page.dart';
import '../../domain/repositories/gigs_repository.dart';
import 'gigs_event.dart';
import 'gigs_state.dart';

class GigsBloc extends Bloc<GigsEvent, GigsState> {
  final GigsRepository repository;

  static const int _defaultLimit = 20;

  GigsBloc({required this.repository}) : super(const GigsState()) {
    on<GigsLoadRequested>(_onLoadRequested);
    on<GigsRefreshRequested>(_onRefreshRequested);
    on<GigsSearchSubmitted>(_onSearchSubmitted);
    on<GigsCityChanged>(_onCityChanged);
    on<GigsCategoryChanged>(_onCategoryChanged);
    on<GigsSortChanged>(_onSortChanged);
    on<GigsFiltersReset>(_onFiltersReset);
    on<GigBookmarkToggled>(_onBookmarkToggled);
  }

  Future<void> _onLoadRequested(
    GigsLoadRequested event,
    Emitter<GigsState> emit,
  ) async {
    if (!state.hasActiveFilters) {
      final cachedResults = await Future.wait([
        repository.getCachedSection('high-priority'),
        repository.getCachedSection('pro-master'),
        repository.getCachedSection('featured'),
        repository.getCachedSection('explore'),
      ]);

      final cachedHp = cachedResults[0];
      final cachedPm = cachedResults[1];
      final cachedFeat = cachedResults[2];
      final cachedExp = cachedResults[3];

      if (cachedHp != null ||
          cachedPm != null ||
          cachedFeat != null ||
          cachedExp != null) {
        emit(state.copyWith(
          highPriorityItems: _applyLocalBookmarks(
            cachedHp?.paginated.items ?? state.highPriorityItems,
            state.bookmarkedIds,
          ),
          highPriorityTotal:
              cachedHp?.paginated.total ?? state.highPriorityTotal,
          isLoadingHighPriority: cachedHp == null,
          proMasterItems: _applyLocalBookmarks(
            cachedPm?.paginated.items ?? state.proMasterItems,
            state.bookmarkedIds,
          ),
          proMasterTotal: cachedPm?.paginated.total ?? state.proMasterTotal,
          isLoadingProMaster: cachedPm == null,
          featuredItems: _applyLocalBookmarks(
            cachedFeat?.paginated.items ?? state.featuredItems,
            state.bookmarkedIds,
          ),
          featuredTotal: cachedFeat?.paginated.total ?? state.featuredTotal,
          isLoadingFeatured: cachedFeat == null,
          exploreItems: _applyLocalBookmarks(
            cachedExp?.paginated.items ?? state.exploreItems,
            state.bookmarkedIds,
          ),
          exploreTotal: cachedExp?.paginated.total ?? state.exploreTotal,
          isLoadingExplore: cachedExp == null,
          facets: cachedExp?.facets ??
              cachedHp?.facets ??
              cachedPm?.facets ??
              cachedFeat?.facets ??
              state.facets,
        ));
      }
    }

    final noCachedData = state.highPriorityItems.isEmpty &&
        state.proMasterItems.isEmpty &&
        state.featuredItems.isEmpty &&
        state.exploreItems.isEmpty;

    await _fetchAllSections(emit, showShimmer: noCachedData);
  }

  Future<void> _onRefreshRequested(
    GigsRefreshRequested event,
    Emitter<GigsState> emit,
  ) async {
    await _fetchAllSections(emit, showShimmer: false);
  }

  Future<void> _onSearchSubmitted(
    GigsSearchSubmitted event,
    Emitter<GigsState> emit,
  ) async {
    emit(state.copyWith(
      searchQuery: event.query.trim(),
      clearError: true,
    ));
    await _fetchAllSections(emit, showShimmer: true);
  }

  Future<void> _onCityChanged(
    GigsCityChanged event,
    Emitter<GigsState> emit,
  ) async {
    emit(state.copyWith(
      selectedCity: event.city.trim(),
      clearError: true,
    ));
    await _fetchAllSections(emit, showShimmer: true);
  }

  Future<void> _onCategoryChanged(
    GigsCategoryChanged event,
    Emitter<GigsState> emit,
  ) async {
    emit(state.copyWith(
      selectedCategory: event.category.trim(),
      clearError: true,
    ));
    await _fetchAllSections(emit, showShimmer: true);
  }

  Future<void> _onSortChanged(
    GigsSortChanged event,
    Emitter<GigsState> emit,
  ) async {
    emit(state.copyWith(
      selectedSort: event.sortBy.trim(),
      clearError: true,
    ));
    await _fetchAllSections(emit, showShimmer: true);
  }

  Future<void> _onFiltersReset(
    GigsFiltersReset event,
    Emitter<GigsState> emit,
  ) async {
    emit(state.copyWith(
      searchQuery: '',
      selectedCity: 'All Cities',
      selectedCategory: 'All GIGs',
      selectedSort: 'Best Match',
      clearError: true,
    ));
    await _fetchAllSections(emit, showShimmer: true);
  }

  void _onBookmarkToggled(
    GigBookmarkToggled event,
    Emitter<GigsState> emit,
  ) {
    final targetId = event.gigId.trim();
    if (targetId.isEmpty) return;

    final updatedBookmarks = Set<String>.from(state.bookmarkedIds);
    if (updatedBookmarks.contains(targetId)) {
      updatedBookmarks.remove(targetId);
    } else {
      updatedBookmarks.add(targetId);
    }

    emit(state.copyWith(
      bookmarkedIds: updatedBookmarks,
      highPriorityItems:
          _applyLocalBookmarks(state.highPriorityItems, updatedBookmarks),
      proMasterItems:
          _applyLocalBookmarks(state.proMasterItems, updatedBookmarks),
      featuredItems:
          _applyLocalBookmarks(state.featuredItems, updatedBookmarks),
      exploreItems:
          _applyLocalBookmarks(state.exploreItems, updatedBookmarks),
    ));
  }

  Future<void> _fetchAllSections(
    Emitter<GigsState> emit, {
    required bool showShimmer,
  }) async {
    if (showShimmer) {
      emit(state.copyWith(
        isLoadingHighPriority: true,
        isLoadingProMaster: true,
        isLoadingFeatured: true,
        isLoadingExplore: true,
        clearError: true,
      ));
    }

    final searchParam =
        state.searchQuery.trim().isEmpty ? null : state.searchQuery.trim();
    final cityParam = state.selectedCity.trim().isEmpty ||
            state.selectedCity.trim().toLowerCase() == 'all cities'
        ? null
        : state.selectedCity.trim();
    final categoryParam = state.selectedCategory.trim().isEmpty ||
            state.selectedCategory.trim().toLowerCase() == 'all gigs'
        ? null
        : state.selectedCategory.trim();
    final sortParam = state.selectedSort.trim().isEmpty ||
            state.selectedSort.trim() == 'Best Match'
        ? null
        : state.selectedSort.trim();

    await Future.wait([
      _fetchHighPriority(
        emit,
        search: searchParam,
        city: cityParam,
        category: categoryParam,
        sortBy: sortParam,
      ),
      _fetchProMaster(
        emit,
        search: searchParam,
        city: cityParam,
        category: categoryParam,
        sortBy: sortParam,
      ),
      _fetchFeatured(
        emit,
        search: searchParam,
        city: cityParam,
        category: categoryParam,
        sortBy: sortParam,
      ),
      _fetchExplore(
        emit,
        search: searchParam,
        city: cityParam,
        category: categoryParam,
        sortBy: sortParam,
      ),
    ]);
  }

  Future<void> _fetchHighPriority(
    Emitter<GigsState> emit, {
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    try {
      final pageData = await repository.getHighPriorityGigs(
        page: 1,
        limit: _defaultLimit,
        search: search,
        city: city,
        category: category,
        sortBy: sortBy,
      );
      emit(state.copyWith(
        highPriorityItems:
            _applyLocalBookmarks(pageData.paginated.items, state.bookmarkedIds),
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

  Future<void> _fetchProMaster(
    Emitter<GigsState> emit, {
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    try {
      final pageData = await repository.getProMasterGigs(
        page: 1,
        limit: _defaultLimit,
        search: search,
        city: city,
        category: category,
        sortBy: sortBy,
      );
      emit(state.copyWith(
        proMasterItems:
            _applyLocalBookmarks(pageData.paginated.items, state.bookmarkedIds),
        proMasterTotal: pageData.paginated.total,
        isLoadingProMaster: false,
        facets: _pickNonEmptyFacets(pageData.facets, state.facets),
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingProMaster: false,
        errorMessage: _cleanError(e),
      ));
    }
  }

  Future<void> _fetchFeatured(
    Emitter<GigsState> emit, {
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    try {
      final pageData = await repository.getFeaturedGigs(
        page: 1,
        limit: _defaultLimit,
        search: search,
        city: city,
        category: category,
        sortBy: sortBy,
      );
      emit(state.copyWith(
        featuredItems:
            _applyLocalBookmarks(pageData.paginated.items, state.bookmarkedIds),
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

  Future<void> _fetchExplore(
    Emitter<GigsState> emit, {
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    try {
      final pageData = await repository.getExploreGigs(
        page: 1,
        limit: _defaultLimit,
        search: search,
        city: city,
        category: category,
        sortBy: sortBy,
      );
      emit(state.copyWith(
        exploreItems:
            _applyLocalBookmarks(pageData.paginated.items, state.bookmarkedIds),
        exploreTotal: pageData.paginated.total,
        isLoadingExplore: false,
        facets: _pickNonEmptyFacets(pageData.facets, state.facets),
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingExplore: false,
        errorMessage: _cleanError(e),
      ));
    }
  }

  List<GigItemModel> _applyLocalBookmarks(
    List<GigItemModel> items,
    Set<String> bookmarkedIds,
  ) {
    return items
        .map((item) => item.copyWith(
              isFavorite: item.isFavorite || bookmarkedIds.contains(item.id),
            ))
        .toList();
  }

  GigFacets _pickNonEmptyFacets(
    GigFacets incoming,
    GigFacets current,
  ) {
    final hasIncoming =
        incoming.category.isNotEmpty || incoming.subcategory.isNotEmpty;
    return hasIncoming ? incoming : current;
  }

  String _cleanError(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }
}
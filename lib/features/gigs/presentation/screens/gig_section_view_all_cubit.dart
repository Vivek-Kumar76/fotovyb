import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/gig_item_model.dart';
import '../../data/models/gigs_feed_page.dart';
import '../../domain/repositories/gigs_repository.dart';

enum GigSectionType {
  highPriority,
  proMaster,
  featured,
  explore,
}

class GigSectionViewAllState extends Equatable {
  final List<GigItemModel> items;
  final int total;
  final int currentPage;
  final bool isLoadingInitial;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? errorMessage;

  const GigSectionViewAllState({
    this.items = const [],
    this.total = 0,
    this.currentPage = 1,
    this.isLoadingInitial = true,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  GigSectionViewAllState copyWith({
    List<GigItemModel>? items,
    int? total,
    int? currentPage,
    bool? isLoadingInitial,
    bool? isLoadingMore,
    bool? hasReachedMax,
    String? errorMessage,
    bool clearError = false,
  }) {
    return GigSectionViewAllState(
      items: items ?? this.items,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        items,
        total,
        currentPage,
        isLoadingInitial,
        isLoadingMore,
        hasReachedMax,
        errorMessage,
      ];
}

class GigSectionViewAllCubit extends Cubit<GigSectionViewAllState> {
  final GigsRepository repository;
  final GigSectionType section;
  final String searchQuery;
  final String city;
  final String category;
  final String sortBy;

  static const int _pageLimit = 20;

  GigSectionViewAllCubit({
    required this.repository,
    required this.section,
    this.searchQuery = '',
    this.city = 'All Cities',
    this.category = 'All GIGs',
    this.sortBy = 'Best Match',
    List<GigItemModel> initialItems = const [],
    int initialTotal = 0,
  }) : super(
          GigSectionViewAllState(
            items: initialItems,
            total: initialTotal,
            isLoadingInitial: initialItems.isEmpty,
            hasReachedMax:
                initialItems.isNotEmpty && initialItems.length >= initialTotal,
          ),
        );

  Future<GigsFeedPage> _fetchPage(int page) {
    final searchParam =
        searchQuery.trim().isEmpty ? null : searchQuery.trim();
    final cityParam =
        city.trim().isEmpty || city.trim().toLowerCase() == 'all cities'
            ? null
            : city.trim();
    final categoryParam =
        category.trim().isEmpty || category.trim().toLowerCase() == 'all gigs'
            ? null
            : category.trim();
    final sortParam =
        sortBy.trim().isEmpty || sortBy.trim() == 'Best Match'
            ? null
            : sortBy.trim();

    switch (section) {
      case GigSectionType.highPriority:
        return repository.getHighPriorityGigs(
          page: page,
          limit: _pageLimit,
          search: searchParam,
          city: cityParam,
          category: categoryParam,
          sortBy: sortParam,
        );
      case GigSectionType.proMaster:
        return repository.getProMasterGigs(
          page: page,
          limit: _pageLimit,
          search: searchParam,
          city: cityParam,
          category: categoryParam,
          sortBy: sortParam,
        );
      case GigSectionType.featured:
        return repository.getFeaturedGigs(
          page: page,
          limit: _pageLimit,
          search: searchParam,
          city: cityParam,
          category: categoryParam,
          sortBy: sortParam,
        );
      case GigSectionType.explore:
        return repository.getExploreGigs(
          page: page,
          limit: _pageLimit,
          search: searchParam,
          city: cityParam,
          category: categoryParam,
          sortBy: sortParam,
        );
    }
  }

  Future<void> loadInitial({bool forceRefresh = false}) async {
    if (state.items.isEmpty || forceRefresh) {
      emit(state.copyWith(
        isLoadingInitial: state.items.isEmpty,
        clearError: true,
      ));
    }

    try {
      final result = await _fetchPage(1);
      final bookmarkMap = {
        for (final item in state.items) item.id: item.isFavorite,
      };
      final merged = result.paginated.items
          .map((item) => item.copyWith(
                isFavorite: item.isFavorite || (bookmarkMap[item.id] ?? false),
              ))
          .toList();

      emit(state.copyWith(
        items: merged,
        total: result.paginated.total,
        currentPage: result.paginated.page,
        isLoadingInitial: false,
        hasReachedMax: result.paginated.hasReachedMax,
        clearError: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingInitial: false,
        errorMessage: e.toString().replaceFirst('Exception: ', '').trim(),
      ));
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingInitial || state.isLoadingMore || state.hasReachedMax) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true, clearError: true));

    try {
      final nextPage = state.currentPage + 1;
      final result = await _fetchPage(nextPage);
      final existingIds = state.items.map((e) => e.id).toSet();
      final incomingUnique = result.paginated.items
          .where((item) => !existingIds.contains(item.id))
          .toList();

      emit(state.copyWith(
        items: [...state.items, ...incomingUnique],
        total: result.paginated.total,
        currentPage: result.paginated.page,
        isLoadingMore: false,
        hasReachedMax:
            result.paginated.hasReachedMax || incomingUnique.isEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString().replaceFirst('Exception: ', '').trim(),
      ));
    }
  }

  void toggleLocalBookmark(String gigId) {
    final updated = state.items
        .map((item) => item.id == gigId
            ? item.copyWith(isFavorite: !item.isFavorite)
            : item)
        .toList();
    emit(state.copyWith(items: updated));
  }
}
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/opportunities_feed_page.dart';
import '../../data/models/opportunity_item_model.dart';
import '../../domain/repositories/opportunities_repository.dart';

enum OpportunitySectionType {
  highPriority,
  boosted,
  featured,
}

class OpportunitySectionViewAllState extends Equatable {
  final List<OpportunityItemModel> items;
  final int total;
  final int currentPage;
  final bool isLoadingInitial;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? applyingOpportunityId;
  final String? errorMessage;

  const OpportunitySectionViewAllState({
    this.items = const [],
    this.total = 0,
    this.currentPage = 1,
    this.isLoadingInitial = true,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.applyingOpportunityId,
    this.errorMessage,
  });

  OpportunitySectionViewAllState copyWith({
    List<OpportunityItemModel>? items,
    int? total,
    int? currentPage,
    bool? isLoadingInitial,
    bool? isLoadingMore,
    bool? hasReachedMax,
    String? applyingOpportunityId,
    bool clearApplyingId = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return OpportunitySectionViewAllState(
      items: items ?? this.items,
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      applyingOpportunityId: clearApplyingId
          ? null
          : (applyingOpportunityId ?? this.applyingOpportunityId),
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
        applyingOpportunityId,
        errorMessage,
      ];
}

class OpportunitySectionViewAllCubit
    extends Cubit<OpportunitySectionViewAllState> {
  final OpportunitiesRepository repository;
  final OpportunitySectionType section;
  final String budgetRange;
  final Set<String> roles;
  final Set<String> industries;
  final Set<String> locations;

  static const int _pageLimit = 20;

  OpportunitySectionViewAllCubit({
    required this.repository,
    required this.section,
    this.budgetRange = '',
    this.roles = const {},
    this.industries = const {},
    this.locations = const {},
    List<OpportunityItemModel> initialItems = const [],
    int initialTotal = 0,
  }) : super(
          OpportunitySectionViewAllState(
            items: initialItems,
            total: initialTotal,
            isLoadingInitial: initialItems.isEmpty,
            hasReachedMax:
                initialItems.isNotEmpty && initialItems.length >= initialTotal,
          ),
        );

  Future<OpportunitiesFeedPage> _fetchPage(int page) {
    final categoryParam =
        industries.isEmpty ? null : industries.join(',');
    final locationParam =
        locations.isEmpty ? null : locations.join(',');
    final rolesParam = roles.isEmpty ? null : roles.toList();
    final budgetParam =
        budgetRange.trim().isEmpty ? null : budgetRange.trim();

    switch (section) {
      case OpportunitySectionType.highPriority:
        return repository.getHighPriorityOpportunities(
          page: page,
          limit: _pageLimit,
          category: categoryParam,
          location: locationParam,
          roles: rolesParam,
          budgetRange: budgetParam,
        );
      case OpportunitySectionType.boosted:
        return repository.getBoostedOpportunities(
          page: page,
          limit: _pageLimit,
          category: categoryParam,
          location: locationParam,
          roles: rolesParam,
          budgetRange: budgetParam,
        );
      case OpportunitySectionType.featured:
        return repository.getFeaturedOpportunities(
          page: page,
          limit: _pageLimit,
          category: categoryParam,
          location: locationParam,
          roles: rolesParam,
          budgetRange: budgetParam,
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
      final appliedMap = {
        for (final item in state.items) item.id: item.isApplied,
      };
      final merged = result.paginated.items
          .map((item) => item.copyWith(
                isApplied: item.isApplied || (appliedMap[item.id] ?? false),
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

  Future<bool> applyToOpportunity(String opportunityId) async {
    if (state.applyingOpportunityId != null) return false;
    emit(state.copyWith(
      applyingOpportunityId: opportunityId,
      clearError: true,
    ));

    try {
      await repository.applyToOpportunity(opportunityId);
      final updated = state.items
          .map((item) => item.id == opportunityId
              ? item.copyWith(isApplied: true)
              : item)
          .toList();
      emit(state.copyWith(
        items: updated,
        clearApplyingId: true,
      ));
      return true;
    } catch (e) {
      emit(state.copyWith(
        clearApplyingId: true,
        errorMessage: e.toString().replaceFirst('Exception: ', '').trim(),
      ));
      return false;
    }
  }
}
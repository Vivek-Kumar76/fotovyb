import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../identifiable.dart';
import '../paginated_result.dart';
import 'pagination_event.dart';
import 'pagination_state.dart';

typedef PaginationFetcher<T extends Identifiable> = Future<PaginatedResult<T>> Function({
  required int page,
  required int limit,
  Map<String, dynamic>? filters,
});

class PaginationBloc<T extends Identifiable>
    extends Bloc<PaginationEvent<T>, PaginationState<T>> {
  final PaginationFetcher<T> fetcher;
  final int pageSize;
  bool _isFetching = false;

  PaginationBloc({
    required this.fetcher,
    this.pageSize = 15,
  }) : super(PaginationState<T>()) {
    on<PaginationStarted<T>>(_onStarted);
    on<PaginationNextPageRequested<T>>(_onNextPageRequested);
    on<PaginationRefreshed<T>>(_onRefreshed);
    on<PaginationFilterChanged<T>>(_onFilterChanged);
  }

  void _onStarted(
    PaginationStarted<T> event,
    Emitter<PaginationState<T>> emit,
  ) {
    if (event.seedItems.isNotEmpty) {
      emit(state.copyWith(
        status: PaginationStatus.loaded,
        items: event.seedItems,
        currentPage: 1,
        hasReachedMax: event.seedItems.length < pageSize,
      ));
    } else {
      add(const PaginationNextPageRequested());
    }
  }

  Future<void> _onNextPageRequested(
    PaginationNextPageRequested<T> event,
    Emitter<PaginationState<T>> emit,
  ) async {
    if (_isFetching || state.hasReachedMax) return;
    _isFetching = true;

    final isFirstPage = state.items.isEmpty;

    if (isFirstPage) {
      emit(state.copyWith(status: PaginationStatus.loading, errorMessage: () => null));
    } else {
      emit(state.copyWith(isLoadingMore: true, errorMessage: () => null));
    }

    try {
      final nextPage = isFirstPage ? 1 : state.currentPage + 1;
      final result = await fetcher(
        page: nextPage,
        limit: pageSize,
        filters: state.activeFilters,
      );

      // Deduplicate items against existing state by id
      final existingIds = state.items.map((e) => e.id).toSet();
      final freshDistinct = result.items.where((e) => !existingIds.contains(e.id)).toList();
      final combinedItems = List<T>.from(state.items)..addAll(freshDistinct);

      emit(state.copyWith(
        status: PaginationStatus.loaded,
        items: combinedItems,
        currentPage: nextPage,
        hasReachedMax: result.hasReachedMax || result.items.length < pageSize,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: isFirstPage ? PaginationStatus.failure : state.status,
        isLoadingMore: false,
        errorMessage: () => e.toString(),
      ));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onRefreshed(
    PaginationRefreshed<T> event,
    Emitter<PaginationState<T>> emit,
  ) async {
    _isFetching = false;
    emit(state.copyWith(
      items: const [],
      currentPage: 1,
      hasReachedMax: false,
      status: PaginationStatus.loading,
      errorMessage: () => null,
    ));

    try {
      final result = await fetcher(
        page: 1,
        limit: pageSize,
        filters: state.activeFilters,
      );

      emit(state.copyWith(
        status: PaginationStatus.loaded,
        items: result.items,
        currentPage: 1,
        hasReachedMax: result.hasReachedMax || result.items.length < pageSize,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PaginationStatus.failure,
        errorMessage: () => e.toString(),
      ));
    }
  }

  Future<void> _onFilterChanged(
    PaginationFilterChanged<T> event,
    Emitter<PaginationState<T>> emit,
  ) async {
    emit(state.copyWith(
      activeFilters: event.filters,
      items: const [],
      currentPage: 1,
      hasReachedMax: false,
    ));
    add(const PaginationNextPageRequested());
  }
}
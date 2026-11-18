import 'package:equatable/equatable.dart';
import '../identifiable.dart';

enum PaginationStatus { initial, loading, loaded, failure }

class PaginationState<T extends Identifiable> extends Equatable {
  final PaginationStatus status;
  final List<T> items;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? errorMessage;
  final Map<String, dynamic> activeFilters;

  const PaginationState({
    this.status = PaginationStatus.initial,
    this.items = const [],
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.activeFilters = const {},
  });

  PaginationState<T> copyWith({
    PaginationStatus? status,
    List<T>? items,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? Function()? errorMessage,
    Map<String, dynamic>? activeFilters,
  }) {
    return PaginationState<T>(
      status: status ?? this.status,
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      activeFilters: activeFilters ?? this.activeFilters,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        currentPage,
        hasReachedMax,
        isLoadingMore,
        errorMessage,
        activeFilters,
      ];
}
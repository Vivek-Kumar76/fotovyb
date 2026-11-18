import 'package:equatable/equatable.dart';
import '../identifiable.dart';

sealed class PaginationEvent<T extends Identifiable> extends Equatable {
  const PaginationEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched immediately on screen entry with items already present on Home.
final class PaginationStarted<T extends Identifiable> extends PaginationEvent<T> {
  final List<T> seedItems;

  const PaginationStarted({this.seedItems = const []});

  @override
  List<Object?> get props => [seedItems];
}

/// Triggered when the user scrolls near the bottom of the list.
final class PaginationNextPageRequested<T extends Identifiable> extends PaginationEvent<T> {
  const PaginationNextPageRequested();
}

/// Triggered by pull-to-refresh.
final class PaginationRefreshed<T extends Identifiable> extends PaginationEvent<T> {
  const PaginationRefreshed();
}

/// Triggered when search query, category, or city changes.
final class PaginationFilterChanged<T extends Identifiable> extends PaginationEvent<T> {
  final Map<String, dynamic> filters;

  const PaginationFilterChanged(this.filters);

  @override
  List<Object?> get props => [filters];
}
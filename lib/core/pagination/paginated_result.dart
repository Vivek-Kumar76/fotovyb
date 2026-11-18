import 'package:equatable/equatable.dart';
import 'identifiable.dart';

class PaginatedResult<T extends Identifiable> extends Equatable {
  final List<T> items;
  final int total;
  final int page;
  final bool hasReachedMax;

  const PaginatedResult({
    required this.items,
    required this.total,
    required this.page,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [items, total, page, hasReachedMax];
}
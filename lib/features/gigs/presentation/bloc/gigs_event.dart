import 'package:equatable/equatable.dart';

abstract class GigsEvent extends Equatable {
  const GigsEvent();

  @override
  List<Object?> get props => [];
}

class GigsLoadRequested extends GigsEvent {
  const GigsLoadRequested();
}

class GigsRefreshRequested extends GigsEvent {
  const GigsRefreshRequested();
}

class GigsSearchSubmitted extends GigsEvent {
  final String query;

  const GigsSearchSubmitted(this.query);

  @override
  List<Object?> get props => [query];
}

class GigsCityChanged extends GigsEvent {
  final String city;

  const GigsCityChanged(this.city);

  @override
  List<Object?> get props => [city];
}

class GigsCategoryChanged extends GigsEvent {
  final String category;

  const GigsCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class GigsSortChanged extends GigsEvent {
  final String sortBy;

  const GigsSortChanged(this.sortBy);

  @override
  List<Object?> get props => [sortBy];
}

class GigsFiltersReset extends GigsEvent {
  const GigsFiltersReset();
}

class GigBookmarkToggled extends GigsEvent {
  final String gigId;

  const GigBookmarkToggled(this.gigId);

  @override
  List<Object?> get props => [gigId];
}
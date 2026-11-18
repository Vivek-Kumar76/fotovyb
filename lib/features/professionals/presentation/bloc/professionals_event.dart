import 'package:equatable/equatable.dart';
import '../../../home/data/models/creative_pro_model.dart';

abstract class ProfessionalsEvent extends Equatable {
  const ProfessionalsEvent();

  @override
  List<Object?> get props => [];
}

class ProfessionalsLoadRequested extends ProfessionalsEvent {
  const ProfessionalsLoadRequested();
}

class ProfessionalsRefreshRequested extends ProfessionalsEvent {
  const ProfessionalsRefreshRequested();
}

class ProfessionalsSearchChanged extends ProfessionalsEvent {
  final String query;
  const ProfessionalsSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class ProfessionalsCityChanged extends ProfessionalsEvent {
  final String city;
  const ProfessionalsCityChanged(this.city);

  @override
  List<Object?> get props => [city];
}

class ProfessionalsCategoryChanged extends ProfessionalsEvent {
  final String category;
  const ProfessionalsCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class ProfessionalsFiltersReset extends ProfessionalsEvent {
  const ProfessionalsFiltersReset();
}

// ── Stream Update Events (Ordered: 1. Spotlight -> 2. Featured -> 3. Prime -> 4. Rising Stars)

class ProfessionalsSpotlightUpdated extends ProfessionalsEvent {
  final List<CreativeProModel> profiles;
  const ProfessionalsSpotlightUpdated(this.profiles);

  @override
  List<Object?> get props => [profiles];
}

class ProfessionalsFeaturedUpdated extends ProfessionalsEvent {
  final List<CreativeProModel> professionals;
  const ProfessionalsFeaturedUpdated(this.professionals);

  @override
  List<Object?> get props => [professionals];
}

class ProfessionalsPrimeUpdated extends ProfessionalsEvent {
  final List<CreativeProModel> profiles;
  const ProfessionalsPrimeUpdated(this.profiles);

  @override
  List<Object?> get props => [profiles];
}

class ProfessionalsRisingStarsUpdated extends ProfessionalsEvent {
  final List<CreativeProModel> stars;
  const ProfessionalsRisingStarsUpdated(this.stars);

  @override
  List<Object?> get props => [stars];
}

// ── User Actions

class ProfessionalsBookmarkToggled extends ProfessionalsEvent {
  final CreativeProModel pro;
  const ProfessionalsBookmarkToggled(this.pro);

  @override
  List<Object?> get props => [pro];
}
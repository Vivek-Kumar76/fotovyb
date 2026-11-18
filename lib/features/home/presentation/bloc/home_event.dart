import 'package:equatable/equatable.dart';
import '../../data/models/creative_pro_model.dart';
import '../../data/models/brand_opportunity_model.dart';
import '../../data/models/gig_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadRequested extends HomeEvent {
  const HomeLoadRequested();
}

class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}

class HomeCityChanged extends HomeEvent {
  final String city;
  const HomeCityChanged(this.city);

  @override
  List<Object?> get props => [city];
}

class HomeCategoryChanged extends HomeEvent {
  final String category;
  const HomeCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

// ── Existing Creative Pros & Showcase Stream Events ──────────────────────────

class HomeCreativeProsUpdated extends HomeEvent {
  final List<CreativeProModel> professionals;
  const HomeCreativeProsUpdated(this.professionals);

  @override
  List<Object?> get props => [professionals];
}

class HomeSpotlightUpdated extends HomeEvent {
  final List<CreativeProModel> profiles;
  const HomeSpotlightUpdated(this.profiles);

  @override
  List<Object?> get props => [profiles];
}

class HomeFeaturedProsUpdated extends HomeEvent {
  final List<CreativeProModel> professionals;
  const HomeFeaturedProsUpdated(this.professionals);

  @override
  List<Object?> get props => [professionals];
}

class HomePrimeUpdated extends HomeEvent {
  final List<CreativeProModel> profiles;
  const HomePrimeUpdated(this.profiles);

  @override
  List<Object?> get props => [profiles];
}

class HomeRisingStarsUpdated extends HomeEvent {
  final List<CreativeProModel> stars;
  const HomeRisingStarsUpdated(this.stars);

  @override
  List<Object?> get props => [stars];
}

class HomeBookmarkToggled extends HomeEvent {
  final CreativeProModel pro;
  const HomeBookmarkToggled(this.pro);

  @override
  List<Object?> get props => [pro];
}

// ── Brand Opportunities Stream Update Events ─────────────────────────────────

class HomeHighPriorityOppsUpdated extends HomeEvent {
  final List<BrandOpportunityModel> items;
  const HomeHighPriorityOppsUpdated(this.items);

  @override
  List<Object?> get props => [items];
}

class HomeBoostedOppsUpdated extends HomeEvent {
  final List<BrandOpportunityModel> items;
  const HomeBoostedOppsUpdated(this.items);

  @override
  List<Object?> get props => [items];
}

class HomeFeaturedOppsUpdated extends HomeEvent {
  final List<BrandOpportunityModel> items;
  const HomeFeaturedOppsUpdated(this.items);

  @override
  List<Object?> get props => [items];
}

class HomeOpportunitySaveToggled extends HomeEvent {
  final BrandOpportunityModel opportunity;
  const HomeOpportunitySaveToggled(this.opportunity);

  @override
  List<Object?> get props => [opportunity];
}

// ── GIGs Feed Stream Update Events (3 Tiers) ─────────────────────────────────

class HomeHighPriorityGigsUpdated extends HomeEvent {
  final List<GigModel> gigs;
  const HomeHighPriorityGigsUpdated(this.gigs);

  @override
  List<Object?> get props => [gigs];
}

class HomeProMasterGigsUpdated extends HomeEvent {
  final List<GigModel> gigs;
  const HomeProMasterGigsUpdated(this.gigs);

  @override
  List<Object?> get props => [gigs];
}

class HomeFeaturedGigsUpdated extends HomeEvent {
  final List<GigModel> gigs;
  const HomeFeaturedGigsUpdated(this.gigs);

  @override
  List<Object?> get props => [gigs];
}

class HomeGigFavoriteToggled extends HomeEvent {
  final GigModel gig;
  const HomeGigFavoriteToggled(this.gig);

  @override
  List<Object?> get props => [gig];
}
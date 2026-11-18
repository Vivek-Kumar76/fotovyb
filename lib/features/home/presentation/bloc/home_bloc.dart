import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  // Stream Subscriptions: Creative Pros & Showcase
  StreamSubscription? _creativeProsSub;
  StreamSubscription? _spotlightSub;
  StreamSubscription? _featuredProsSub;
  StreamSubscription? _primeSub;
  StreamSubscription? _risingStarsSub;

  // Stream Subscriptions: Brand Opportunities
  StreamSubscription? _highPriorityOppsSub;
  StreamSubscription? _boostedOppsSub;
  StreamSubscription? _featuredOppsSub;

  // Stream Subscriptions: GIGs Feed (3 Tiers)
  StreamSubscription? _highPriorityGigsSub;
  StreamSubscription? _proMasterGigsSub;
  StreamSubscription? _featuredGigsSub;

  HomeBloc({required this.homeRepository}) : super(HomeState.initial()) {
    on<HomeLoadRequested>(_onLoadRequested);
    on<HomeRefreshRequested>(_onRefreshRequested);
    on<HomeCityChanged>(_onCityChanged);
    on<HomeCategoryChanged>(_onCategoryChanged);

    // Existing Creative Pros & Showcase Stream Updates
    on<HomeCreativeProsUpdated>(_onCreativeProsUpdated);
    on<HomeSpotlightUpdated>(_onSpotlightUpdated);
    on<HomeFeaturedProsUpdated>(_onFeaturedProsUpdated);
    on<HomePrimeUpdated>(_onPrimeUpdated);
    on<HomeRisingStarsUpdated>(_onRisingStarsUpdated);
    on<HomeBookmarkToggled>(_onBookmarkToggled);

    // Brand Opportunities Stream Updates
    on<HomeHighPriorityOppsUpdated>(_onHighPriorityOppsUpdated);
    on<HomeBoostedOppsUpdated>(_onBoostedOppsUpdated);
    on<HomeFeaturedOppsUpdated>(_onFeaturedOppsUpdated);
    on<HomeOpportunitySaveToggled>(_onOpportunitySaveToggled);

    // GIGs Feed Stream Updates (3 Tiers)
    on<HomeHighPriorityGigsUpdated>(_onHighPriorityGigsUpdated);
    on<HomeProMasterGigsUpdated>(_onProMasterGigsUpdated);
    on<HomeFeaturedGigsUpdated>(_onFeaturedGigsUpdated);
    on<HomeGigFavoriteToggled>(_onGigFavoriteToggled);
  }

  void _onLoadRequested(HomeLoadRequested event, Emitter<HomeState> emit) {
    _startWatchingStreams(state.selectedCity, state.selectedCategory);
  }

  void _onRefreshRequested(HomeRefreshRequested event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      isLoadingCreativePros: true,
      isLoadingSpotlight: true,
      isLoadingFeaturedPros: true,
      isLoadingPrime: true,
      isLoadingRisingStars: true,
      isLoadingHighPriority: true,
      isLoadingBoosted: true,
      isLoadingFeatured: true,
      isLoadingHighPriorityGigs: true,
      isLoadingProMasterGigs: true,
      isLoadingFeaturedGigs: true,
    ));
    _startWatchingStreams(state.selectedCity, state.selectedCategory);
  }

  void _onCityChanged(HomeCityChanged event, Emitter<HomeState> emit) {
    if (state.selectedCity == event.city) return;
    emit(state.copyWith(selectedCity: event.city));
    _startWatchingStreams(event.city, state.selectedCategory);
  }

  void _onCategoryChanged(HomeCategoryChanged event, Emitter<HomeState> emit) {
    if (state.selectedCategory == event.category) return;
    emit(state.copyWith(selectedCategory: event.category));
    _startWatchingStreams(state.selectedCity, event.category);
  }

  // ── Existing Creative Pros Stream Handlers ─────────────────────────────────

  void _onCreativeProsUpdated(HomeCreativeProsUpdated event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      creativeProfessionals: event.professionals,
      isLoadingCreativePros: false,
    ));
  }

  void _onSpotlightUpdated(HomeSpotlightUpdated event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      spotlightProfiles: event.profiles,
      isLoadingSpotlight: false,
    ));
  }

  void _onFeaturedProsUpdated(HomeFeaturedProsUpdated event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      featuredProfessionals: event.professionals,
      isLoadingFeaturedPros: false,
    ));
  }

  void _onPrimeUpdated(HomePrimeUpdated event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      primeProfiles: event.profiles,
      isLoadingPrime: false,
    ));
  }

  void _onRisingStarsUpdated(HomeRisingStarsUpdated event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      risingStars: event.stars,
      isLoadingRisingStars: false,
    ));
  }

  Future<void> _onBookmarkToggled(HomeBookmarkToggled event, Emitter<HomeState> emit) async {
    await homeRepository.toggleBookmark(event.pro);
  }

  // ── Brand Opportunities Handlers ───────────────────────────────────────────

  void _onHighPriorityOppsUpdated(
    HomeHighPriorityOppsUpdated event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      highPriorityOpportunities: event.items,
      isLoadingHighPriority: false,
    ));
  }

  void _onBoostedOppsUpdated(
    HomeBoostedOppsUpdated event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      boostedOpportunities: event.items,
      isLoadingBoosted: false,
    ));
  }

  void _onFeaturedOppsUpdated(
    HomeFeaturedOppsUpdated event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      featuredOpportunities: event.items,
      isLoadingFeatured: false,
    ));
  }

  Future<void> _onOpportunitySaveToggled(
    HomeOpportunitySaveToggled event,
    Emitter<HomeState> emit,
  ) async {
    final targetId = event.opportunity.id;
    final updatedSavedStatus = !event.opportunity.isSaved;

    final updatedHighPriority = state.highPriorityOpportunities.map((item) {
      return item.id == targetId ? item.copyWith(isSaved: updatedSavedStatus) : item;
    }).toList();

    final updatedBoosted = state.boostedOpportunities.map((item) {
      return item.id == targetId ? item.copyWith(isSaved: updatedSavedStatus) : item;
    }).toList();

    final updatedFeatured = state.featuredOpportunities.map((item) {
      return item.id == targetId ? item.copyWith(isSaved: updatedSavedStatus) : item;
    }).toList();

    emit(state.copyWith(
      highPriorityOpportunities: updatedHighPriority,
      boostedOpportunities: updatedBoosted,
      featuredOpportunities: updatedFeatured,
    ));

    await homeRepository.toggleSaveOpportunity(targetId);
  }

  // ── GIGs Feed Handlers (3 Tiers) ───────────────────────────────────────────

  void _onHighPriorityGigsUpdated(
    HomeHighPriorityGigsUpdated event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      highPriorityGigs: event.gigs,
      isLoadingHighPriorityGigs: false,
    ));
  }

  void _onProMasterGigsUpdated(
    HomeProMasterGigsUpdated event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      proMasterGigs: event.gigs,
      isLoadingProMasterGigs: false,
    ));
  }

  void _onFeaturedGigsUpdated(
    HomeFeaturedGigsUpdated event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(
      featuredGigs: event.gigs,
      isLoadingFeaturedGigs: false,
    ));
  }

  Future<void> _onGigFavoriteToggled(
    HomeGigFavoriteToggled event,
    Emitter<HomeState> emit,
  ) async {
    final targetId = event.gig.id;
    final updatedFav = !event.gig.isFavorite;

    final updatedHighPriority = state.highPriorityGigs.map((g) {
      return g.id == targetId ? g.copyWith(isFavorite: updatedFav) : g;
    }).toList();

    final updatedProMaster = state.proMasterGigs.map((g) {
      return g.id == targetId ? g.copyWith(isFavorite: updatedFav) : g;
    }).toList();

    final updatedFeatured = state.featuredGigs.map((g) {
      return g.id == targetId ? g.copyWith(isFavorite: updatedFav) : g;
    }).toList();

    emit(state.copyWith(
      highPriorityGigs: updatedHighPriority,
      proMasterGigs: updatedProMaster,
      featuredGigs: updatedFeatured,
    ));

    await homeRepository.toggleFavoriteGig(targetId);
  }

  // ── Stream Subscription Lifecycle ──────────────────────────────────────────

  void _startWatchingStreams(String city, String category) {
    _cancelSubscriptions();

    // Creative Pros & Showcase Watchers
    _creativeProsSub = homeRepository
        .watchCreativeProfessionals(city: city, category: category)
        .listen((items) => add(HomeCreativeProsUpdated(items)));

    _spotlightSub = homeRepository
        .watchSpotlightProfiles(city: city, category: category)
        .listen((items) => add(HomeSpotlightUpdated(items)));

    _featuredProsSub = homeRepository
        .watchFeaturedProfessionals(city: city, category: category)
        .listen((items) => add(HomeFeaturedProsUpdated(items)));

    _primeSub = homeRepository
        .watchPrimeProfiles(city: city, category: category)
        .listen((items) => add(HomePrimeUpdated(items)));

    _risingStarsSub = homeRepository
        .watchRisingStars(city: city, category: category)
        .listen((items) => add(HomeRisingStarsUpdated(items)));

    // Brand Opportunities Watchers
    _highPriorityOppsSub = homeRepository
        .watchHighPriorityOpportunities(city: city, category: category)
        .listen((items) => add(HomeHighPriorityOppsUpdated(items)));

    _boostedOppsSub = homeRepository
        .watchBoostedOpportunities(city: city, category: category)
        .listen((items) => add(HomeBoostedOppsUpdated(items)));

    _featuredOppsSub = homeRepository
        .watchFeaturedOpportunities(city: city, category: category)
        .listen((items) => add(HomeFeaturedOppsUpdated(items)));

    // GIGs Feed Watchers (3 Tiers)
    _highPriorityGigsSub = homeRepository
        .watchHighPriorityGigs(city: city, category: category)
        .listen((items) => add(HomeHighPriorityGigsUpdated(items)));

    _proMasterGigsSub = homeRepository
        .watchProMasterGigs(city: city, category: category)
        .listen((items) => add(HomeProMasterGigsUpdated(items)));

    _featuredGigsSub = homeRepository
        .watchFeaturedGigs(city: city, category: category)
        .listen((items) => add(HomeFeaturedGigsUpdated(items)));
  }

  void _cancelSubscriptions() {
    _creativeProsSub?.cancel();
    _spotlightSub?.cancel();
    _featuredProsSub?.cancel();
    _primeSub?.cancel();
    _risingStarsSub?.cancel();

    _highPriorityOppsSub?.cancel();
    _boostedOppsSub?.cancel();
    _featuredOppsSub?.cancel();

    _highPriorityGigsSub?.cancel();
    _proMasterGigsSub?.cancel();
    _featuredGigsSub?.cancel();
  }

  @override
  Future<void> close() {
    _cancelSubscriptions();
    return super.close();
  }
}
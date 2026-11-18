import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/professionals_repository.dart';
import 'professionals_event.dart';
import 'professionals_state.dart';

class ProfessionalsBloc extends Bloc<ProfessionalsEvent, ProfessionalsState> {
  final ProfessionalsRepository professionalsRepository;

  StreamSubscription? _spotlightSub;
  StreamSubscription? _featuredProsSub;
  StreamSubscription? _primeSub;
  StreamSubscription? _risingStarsSub;
  Timer? _searchDebounce;

  ProfessionalsBloc({required this.professionalsRepository})
      : super(ProfessionalsState.initial()) {
    on<ProfessionalsLoadRequested>(_onLoadRequested);
    on<ProfessionalsRefreshRequested>(_onRefreshRequested);
    on<ProfessionalsSearchChanged>(_onSearchChanged);
    on<ProfessionalsCityChanged>(_onCityChanged);
    on<ProfessionalsCategoryChanged>(_onCategoryChanged);
    on<ProfessionalsFiltersReset>(_onFiltersReset);

    on<ProfessionalsSpotlightUpdated>(_onSpotlightUpdated);
    on<ProfessionalsFeaturedUpdated>(_onFeaturedUpdated);
    on<ProfessionalsPrimeUpdated>(_onPrimeUpdated);
    on<ProfessionalsRisingStarsUpdated>(_onRisingStarsUpdated);
    on<ProfessionalsBookmarkToggled>(_onBookmarkToggled);
  }

  void _onLoadRequested(
    ProfessionalsLoadRequested event,
    Emitter<ProfessionalsState> emit,
  ) {
    _startWatchingStreams(
      search: state.searchQuery,
      city: state.selectedCity,
      category: state.selectedCategory,
    );
  }

  void _onRefreshRequested(
    ProfessionalsRefreshRequested event,
    Emitter<ProfessionalsState> emit,
  ) {
    emit(state.copyWith(
      isLoadingSpotlight: true,
      isLoadingFeaturedPros: true,
      isLoadingPrime: true,
      isLoadingRisingStars: true,
    ));
    _startWatchingStreams(
      search: state.searchQuery,
      city: state.selectedCity,
      category: state.selectedCategory,
    );
  }

  void _onSearchChanged(
    ProfessionalsSearchChanged event,
    Emitter<ProfessionalsState> emit,
  ) {
    final trimmed = event.query.trim();
    if (state.searchQuery == trimmed) return;

    emit(state.copyWith(
      searchQuery: trimmed,
      isLoadingSpotlight: true,
      isLoadingFeaturedPros: true,
      isLoadingPrime: true,
      isLoadingRisingStars: true,
    ));

    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      _startWatchingStreams(
        search: trimmed,
        city: state.selectedCity,
        category: state.selectedCategory,
      );
    });
  }

  void _onCityChanged(
    ProfessionalsCityChanged event,
    Emitter<ProfessionalsState> emit,
  ) {
    if (state.selectedCity == event.city) return;
    emit(state.copyWith(
      selectedCity: event.city,
      isLoadingSpotlight: true,
      isLoadingFeaturedPros: true,
      isLoadingPrime: true,
      isLoadingRisingStars: true,
    ));
    _startWatchingStreams(
      search: state.searchQuery,
      city: event.city,
      category: state.selectedCategory,
    );
  }

  void _onCategoryChanged(
    ProfessionalsCategoryChanged event,
    Emitter<ProfessionalsState> emit,
  ) {
    if (state.selectedCategory == event.category) return;
    emit(state.copyWith(
      selectedCategory: event.category,
      isLoadingSpotlight: true,
      isLoadingFeaturedPros: true,
      isLoadingPrime: true,
      isLoadingRisingStars: true,
    ));
    _startWatchingStreams(
      search: state.searchQuery,
      city: state.selectedCity,
      category: event.category,
    );
  }

  void _onFiltersReset(
    ProfessionalsFiltersReset event,
    Emitter<ProfessionalsState> emit,
  ) {
    if (!state.hasActiveFilters) return;
    emit(state.copyWith(
      searchQuery: '',
      selectedCity: 'All',
      selectedCategory: 'All',
      isLoadingSpotlight: true,
      isLoadingFeaturedPros: true,
      isLoadingPrime: true,
      isLoadingRisingStars: true,
    ));
    _startWatchingStreams(search: '', city: 'All', category: 'All');
  }

  // ── Stream Handlers ────────────────────────────────────────────────────────

  void _onSpotlightUpdated(
    ProfessionalsSpotlightUpdated event,
    Emitter<ProfessionalsState> emit,
  ) {
    emit(state.copyWith(
      spotlightProfiles: event.profiles,
      isLoadingSpotlight: false,
    ));
  }

  void _onFeaturedUpdated(
    ProfessionalsFeaturedUpdated event,
    Emitter<ProfessionalsState> emit,
  ) {
    emit(state.copyWith(
      featuredProfessionals: event.professionals,
      isLoadingFeaturedPros: false,
    ));
  }

  void _onPrimeUpdated(
    ProfessionalsPrimeUpdated event,
    Emitter<ProfessionalsState> emit,
  ) {
    emit(state.copyWith(
      primeProfiles: event.profiles,
      isLoadingPrime: false,
    ));
  }

  void _onRisingStarsUpdated(
    ProfessionalsRisingStarsUpdated event,
    Emitter<ProfessionalsState> emit,
  ) {
    emit(state.copyWith(
      risingStars: event.stars,
      isLoadingRisingStars: false,
    ));
  }

  Future<void> _onBookmarkToggled(
    ProfessionalsBookmarkToggled event,
    Emitter<ProfessionalsState> emit,
  ) async {
    await professionalsRepository.toggleBookmark(event.pro);
  }

  // ── Stream Subscription Lifecycle ──────────────────────────────────────────

  void _startWatchingStreams({
    required String search,
    required String city,
    required String category,
  }) {
    _cancelSubscriptions();

    _spotlightSub = professionalsRepository
        .watchSpotlightProfiles(search: search, city: city, category: category)
        .listen((items) => add(ProfessionalsSpotlightUpdated(items)));

    _featuredProsSub = professionalsRepository
        .watchFeaturedProfessionals(search: search, city: city, category: category)
        .listen((items) => add(ProfessionalsFeaturedUpdated(items)));

    _primeSub = professionalsRepository
        .watchPrimeProfiles(search: search, city: city, category: category)
        .listen((items) => add(ProfessionalsPrimeUpdated(items)));

    _risingStarsSub = professionalsRepository
        .watchRisingStars(search: search, city: city, category: category)
        .listen((items) => add(ProfessionalsRisingStarsUpdated(items)));
  }

  void _cancelSubscriptions() {
    _spotlightSub?.cancel();
    _featuredProsSub?.cancel();
    _primeSub?.cancel();
    _risingStarsSub?.cancel();
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    _cancelSubscriptions();
    return super.close();
  }
}
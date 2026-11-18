import 'package:equatable/equatable.dart';
import '../../../home/data/models/creative_pro_model.dart';

class ProfessionalsState extends Equatable {
  final String searchQuery;
  final String selectedCity;
  final String selectedCategory;

  // 1. Spotlight
  final List<CreativeProModel> spotlightProfiles;
  final bool isLoadingSpotlight;

  // 2. Featured
  final List<CreativeProModel> featuredProfessionals;
  final bool isLoadingFeaturedPros;

  // 3. Prime
  final List<CreativeProModel> primeProfiles;
  final bool isLoadingPrime;

  // 4. Rising Stars
  final List<CreativeProModel> risingStars;
  final bool isLoadingRisingStars;

  const ProfessionalsState({
    this.searchQuery = '',
    this.selectedCity = 'All',
    this.selectedCategory = 'All',
    this.spotlightProfiles = const [],
    this.isLoadingSpotlight = true,
    this.featuredProfessionals = const [],
    this.isLoadingFeaturedPros = true,
    this.primeProfiles = const [],
    this.isLoadingPrime = true,
    this.risingStars = const [],
    this.isLoadingRisingStars = true,
  });

  factory ProfessionalsState.initial() => const ProfessionalsState();

  bool get hasActiveFilters =>
      searchQuery.trim().isNotEmpty ||
      selectedCity != 'All' ||
      selectedCategory != 'All';

  ProfessionalsState copyWith({
    String? searchQuery,
    String? selectedCity,
    String? selectedCategory,
    List<CreativeProModel>? spotlightProfiles,
    bool? isLoadingSpotlight,
    List<CreativeProModel>? featuredProfessionals,
    bool? isLoadingFeaturedPros,
    List<CreativeProModel>? primeProfiles,
    bool? isLoadingPrime,
    List<CreativeProModel>? risingStars,
    bool? isLoadingRisingStars,
  }) {
    return ProfessionalsState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      spotlightProfiles: spotlightProfiles ?? this.spotlightProfiles,
      isLoadingSpotlight: isLoadingSpotlight ?? this.isLoadingSpotlight,
      featuredProfessionals:
          featuredProfessionals ?? this.featuredProfessionals,
      isLoadingFeaturedPros:
          isLoadingFeaturedPros ?? this.isLoadingFeaturedPros,
      primeProfiles: primeProfiles ?? this.primeProfiles,
      isLoadingPrime: isLoadingPrime ?? this.isLoadingPrime,
      risingStars: risingStars ?? this.risingStars,
      isLoadingRisingStars: isLoadingRisingStars ?? this.isLoadingRisingStars,
    );
  }

  @override
  List<Object?> get props => [
        searchQuery,
        selectedCity,
        selectedCategory,
        spotlightProfiles,
        isLoadingSpotlight,
        featuredProfessionals,
        isLoadingFeaturedPros,
        primeProfiles,
        isLoadingPrime,
        risingStars,
        isLoadingRisingStars,
      ];
}
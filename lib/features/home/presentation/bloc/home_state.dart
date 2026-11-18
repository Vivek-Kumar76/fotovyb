import 'package:equatable/equatable.dart';
import '../../data/models/creative_pro_model.dart';
import '../../data/models/brand_opportunity_model.dart';
import '../../data/models/gig_model.dart';

class HomeState extends Equatable {
  final String selectedCity;
  final String selectedCategory;

  // ── Creative Pros & Showcase Lists[cite: 19]
  final List<CreativeProModel> creativeProfessionals;
  final bool isLoadingCreativePros;

  final List<CreativeProModel> spotlightProfiles;
  final bool isLoadingSpotlight;

  final List<CreativeProModel> featuredProfessionals;
  final bool isLoadingFeaturedPros;

  final List<CreativeProModel> primeProfiles;
  final bool isLoadingPrime;

  final List<CreativeProModel> risingStars;
  final bool isLoadingRisingStars;

  // ── Brand Opportunities (3-Tier)[cite: 19]
  final List<BrandOpportunityModel> highPriorityOpportunities;
  final bool isLoadingHighPriority;

  final List<BrandOpportunityModel> boostedOpportunities;
  final bool isLoadingBoosted;

  final List<BrandOpportunityModel> featuredOpportunities;
  final bool isLoadingFeatured;

  // ── GIGs Feed (3-Tier)
  final List<GigModel> highPriorityGigs;
  final bool isLoadingHighPriorityGigs;

  final List<GigModel> proMasterGigs;
  final bool isLoadingProMasterGigs;

  final List<GigModel> featuredGigs;
  final bool isLoadingFeaturedGigs;

  const HomeState({
    this.selectedCity = 'All',
    this.selectedCategory = 'All',
    this.creativeProfessionals = const [],
    this.isLoadingCreativePros = true,
    this.spotlightProfiles = const [],
    this.isLoadingSpotlight = true,
    this.featuredProfessionals = const [],
    this.isLoadingFeaturedPros = true,
    this.primeProfiles = const [],
    this.isLoadingPrime = true,
    this.risingStars = const [],
    this.isLoadingRisingStars = true,
    this.highPriorityOpportunities = const [],
    this.isLoadingHighPriority = true,
    this.boostedOpportunities = const [],
    this.isLoadingBoosted = true,
    this.featuredOpportunities = const [],
    this.isLoadingFeatured = true,
    this.highPriorityGigs = const [],
    this.isLoadingHighPriorityGigs = true,
    this.proMasterGigs = const [],
    this.isLoadingProMasterGigs = true,
    this.featuredGigs = const [],
    this.isLoadingFeaturedGigs = true,
  });

  factory HomeState.initial() => const HomeState();

  HomeState copyWith({
    String? selectedCity,
    String? selectedCategory,
    List<CreativeProModel>? creativeProfessionals,
    bool? isLoadingCreativePros,
    List<CreativeProModel>? spotlightProfiles,
    bool? isLoadingSpotlight,
    List<CreativeProModel>? featuredProfessionals,
    bool? isLoadingFeaturedPros,
    List<CreativeProModel>? primeProfiles,
    bool? isLoadingPrime,
    List<CreativeProModel>? risingStars,
    bool? isLoadingRisingStars,
    List<BrandOpportunityModel>? highPriorityOpportunities,
    bool? isLoadingHighPriority,
    List<BrandOpportunityModel>? boostedOpportunities,
    bool? isLoadingBoosted,
    List<BrandOpportunityModel>? featuredOpportunities,
    bool? isLoadingFeatured,
    List<GigModel>? highPriorityGigs,
    bool? isLoadingHighPriorityGigs,
    List<GigModel>? proMasterGigs,
    bool? isLoadingProMasterGigs,
    List<GigModel>? featuredGigs,
    bool? isLoadingFeaturedGigs,
  }) {
    return HomeState(
      selectedCity: selectedCity ?? this.selectedCity,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      creativeProfessionals: creativeProfessionals ?? this.creativeProfessionals,
      isLoadingCreativePros: isLoadingCreativePros ?? this.isLoadingCreativePros,
      spotlightProfiles: spotlightProfiles ?? this.spotlightProfiles,
      isLoadingSpotlight: isLoadingSpotlight ?? this.isLoadingSpotlight,
      featuredProfessionals: featuredProfessionals ?? this.featuredProfessionals,
      isLoadingFeaturedPros: isLoadingFeaturedPros ?? this.isLoadingFeaturedPros,
      primeProfiles: primeProfiles ?? this.primeProfiles,
      isLoadingPrime: isLoadingPrime ?? this.isLoadingPrime,
      risingStars: risingStars ?? this.risingStars,
      isLoadingRisingStars: isLoadingRisingStars ?? this.isLoadingRisingStars,
      highPriorityOpportunities:
          highPriorityOpportunities ?? this.highPriorityOpportunities,
      isLoadingHighPriority: isLoadingHighPriority ?? this.isLoadingHighPriority,
      boostedOpportunities:
          boostedOpportunities ?? this.boostedOpportunities,
      isLoadingBoosted: isLoadingBoosted ?? this.isLoadingBoosted,
      featuredOpportunities:
          featuredOpportunities ?? this.featuredOpportunities,
      isLoadingFeatured: isLoadingFeatured ?? this.isLoadingFeatured,
      highPriorityGigs: highPriorityGigs ?? this.highPriorityGigs,
      isLoadingHighPriorityGigs:
          isLoadingHighPriorityGigs ?? this.isLoadingHighPriorityGigs,
      proMasterGigs: proMasterGigs ?? this.proMasterGigs,
      isLoadingProMasterGigs:
          isLoadingProMasterGigs ?? this.isLoadingProMasterGigs,
      featuredGigs: featuredGigs ?? this.featuredGigs,
      isLoadingFeaturedGigs:
          isLoadingFeaturedGigs ?? this.isLoadingFeaturedGigs,
    );
  }

  @override
  List<Object?> get props => [
        selectedCity,
        selectedCategory,
        creativeProfessionals,
        isLoadingCreativePros,
        spotlightProfiles,
        isLoadingSpotlight,
        featuredProfessionals,
        isLoadingFeaturedPros,
        primeProfiles,
        isLoadingPrime,
        risingStars,
        isLoadingRisingStars,
        highPriorityOpportunities,
        isLoadingHighPriority,
        boostedOpportunities,
        isLoadingBoosted,
        featuredOpportunities,
        isLoadingFeatured,
        highPriorityGigs,
        isLoadingHighPriorityGigs,
        proMasterGigs,
        isLoadingProMasterGigs,
        featuredGigs,
        isLoadingFeaturedGigs,
      ];
}
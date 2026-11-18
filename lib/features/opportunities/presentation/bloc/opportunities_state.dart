import 'package:equatable/equatable.dart';
import '../../data/models/opportunities_feed_page.dart';
import '../../data/models/opportunity_item_model.dart';

class OpportunitiesState extends Equatable {
  final List<OpportunityItemModel> highPriorityItems;
  final List<OpportunityItemModel> boostedItems;
  final List<OpportunityItemModel> featuredItems;

  final int highPriorityTotal;
  final int boostedTotal;
  final int featuredTotal;

  final bool isLoadingHighPriority;
  final bool isLoadingBoosted;
  final bool isLoadingFeatured;

  final String selectedBudgetRange;
  final Set<String> selectedRoles;
  final Set<String> selectedIndustries;
  final Set<String> selectedLocations;
  final String selectedRating;

  final OpportunityFacets facets;
  final String? applyingOpportunityId;
  final String? errorMessage;

  const OpportunitiesState({
    this.highPriorityItems = const [],
    this.boostedItems = const [],
    this.featuredItems = const [],
    this.highPriorityTotal = 0,
    this.boostedTotal = 0,
    this.featuredTotal = 0,
    this.isLoadingHighPriority = true,
    this.isLoadingBoosted = true,
    this.isLoadingFeatured = true,
    this.selectedBudgetRange = '',
    this.selectedRoles = const {},
    this.selectedIndustries = const {},
    this.selectedLocations = const {},
    this.selectedRating = '',
    this.facets = const OpportunityFacets(),
    this.applyingOpportunityId,
    this.errorMessage,
  });

  int get activeFilterCount {
    int count = 0;
    if (selectedBudgetRange.isNotEmpty) count++;
    count += selectedRoles.length;
    count += selectedIndustries.length;
    count += selectedLocations.length;
    if (selectedRating.isNotEmpty && selectedRating != 'Any Rating') count++;
    return count;
  }

  bool get hasActiveFilters => activeFilterCount > 0;

  OpportunitiesState copyWith({
    List<OpportunityItemModel>? highPriorityItems,
    List<OpportunityItemModel>? boostedItems,
    List<OpportunityItemModel>? featuredItems,
    int? highPriorityTotal,
    int? boostedTotal,
    int? featuredTotal,
    bool? isLoadingHighPriority,
    bool? isLoadingBoosted,
    bool? isLoadingFeatured,
    String? selectedBudgetRange,
    Set<String>? selectedRoles,
    Set<String>? selectedIndustries,
    Set<String>? selectedLocations,
    String? selectedRating,
    OpportunityFacets? facets,
    String? applyingOpportunityId,
    bool clearApplyingId = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return OpportunitiesState(
      highPriorityItems: highPriorityItems ?? this.highPriorityItems,
      boostedItems: boostedItems ?? this.boostedItems,
      featuredItems: featuredItems ?? this.featuredItems,
      highPriorityTotal: highPriorityTotal ?? this.highPriorityTotal,
      boostedTotal: boostedTotal ?? this.boostedTotal,
      featuredTotal: featuredTotal ?? this.featuredTotal,
      isLoadingHighPriority:
          isLoadingHighPriority ?? this.isLoadingHighPriority,
      isLoadingBoosted: isLoadingBoosted ?? this.isLoadingBoosted,
      isLoadingFeatured: isLoadingFeatured ?? this.isLoadingFeatured,
      selectedBudgetRange: selectedBudgetRange ?? this.selectedBudgetRange,
      selectedRoles: selectedRoles ?? this.selectedRoles,
      selectedIndustries: selectedIndustries ?? this.selectedIndustries,
      selectedLocations: selectedLocations ?? this.selectedLocations,
      selectedRating: selectedRating ?? this.selectedRating,
      facets: facets ?? this.facets,
      applyingOpportunityId: clearApplyingId
          ? null
          : (applyingOpportunityId ?? this.applyingOpportunityId),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        highPriorityItems,
        boostedItems,
        featuredItems,
        highPriorityTotal,
        boostedTotal,
        featuredTotal,
        isLoadingHighPriority,
        isLoadingBoosted,
        isLoadingFeatured,
        selectedBudgetRange,
        selectedRoles,
        selectedIndustries,
        selectedLocations,
        selectedRating,
        facets,
        applyingOpportunityId,
        errorMessage,
      ];
}
import 'package:equatable/equatable.dart';
import '../../data/models/gig_item_model.dart';
import '../../data/models/gigs_feed_page.dart';

class GigsState extends Equatable {
  final List<GigItemModel> highPriorityItems;
  final List<GigItemModel> proMasterItems;
  final List<GigItemModel> featuredItems;
  final List<GigItemModel> exploreItems;

  final int highPriorityTotal;
  final int proMasterTotal;
  final int featuredTotal;
  final int exploreTotal;

  final bool isLoadingHighPriority;
  final bool isLoadingProMaster;
  final bool isLoadingFeatured;
  final bool isLoadingExplore;

  final String searchQuery;
  final String selectedCity;
  final String selectedCategory;
  final String selectedSort;

  final Set<String> bookmarkedIds;
  final GigFacets facets;
  final String? errorMessage;

  const GigsState({
    this.highPriorityItems = const [],
    this.proMasterItems = const [],
    this.featuredItems = const [],
    this.exploreItems = const [],
    this.highPriorityTotal = 0,
    this.proMasterTotal = 0,
    this.featuredTotal = 0,
    this.exploreTotal = 0,
    this.isLoadingHighPriority = true,
    this.isLoadingProMaster = true,
    this.isLoadingFeatured = true,
    this.isLoadingExplore = true,
    this.searchQuery = '',
    this.selectedCity = 'All Cities',
    this.selectedCategory = 'All GIGs',
    this.selectedSort = 'Best Match',
    this.bookmarkedIds = const {},
    this.facets = const GigFacets(),
    this.errorMessage,
  });

  int get totalMatchingGigs {
    final sum =
        highPriorityTotal + proMasterTotal + featuredTotal + exploreTotal;
    if (sum > 0) return sum;
    return highPriorityItems.length +
        proMasterItems.length +
        featuredItems.length +
        exploreItems.length;
  }

  bool get hasActiveFilters {
    return searchQuery.trim().isNotEmpty ||
        (selectedCity.trim().isNotEmpty &&
            selectedCity.trim().toLowerCase() != 'all cities') ||
        (selectedCategory.trim().isNotEmpty &&
            selectedCategory.trim().toLowerCase() != 'all gigs') ||
        (selectedSort.trim().isNotEmpty && selectedSort.trim() != 'Best Match');
  }

  GigsState copyWith({
    List<GigItemModel>? highPriorityItems,
    List<GigItemModel>? proMasterItems,
    List<GigItemModel>? featuredItems,
    List<GigItemModel>? exploreItems,
    int? highPriorityTotal,
    int? proMasterTotal,
    int? featuredTotal,
    int? exploreTotal,
    bool? isLoadingHighPriority,
    bool? isLoadingProMaster,
    bool? isLoadingFeatured,
    bool? isLoadingExplore,
    String? searchQuery,
    String? selectedCity,
    String? selectedCategory,
    String? selectedSort,
    Set<String>? bookmarkedIds,
    GigFacets? facets,
    String? errorMessage,
    bool clearError = false,
  }) {
    return GigsState(
      highPriorityItems: highPriorityItems ?? this.highPriorityItems,
      proMasterItems: proMasterItems ?? this.proMasterItems,
      featuredItems: featuredItems ?? this.featuredItems,
      exploreItems: exploreItems ?? this.exploreItems,
      highPriorityTotal: highPriorityTotal ?? this.highPriorityTotal,
      proMasterTotal: proMasterTotal ?? this.proMasterTotal,
      featuredTotal: featuredTotal ?? this.featuredTotal,
      exploreTotal: exploreTotal ?? this.exploreTotal,
      isLoadingHighPriority:
          isLoadingHighPriority ?? this.isLoadingHighPriority,
      isLoadingProMaster: isLoadingProMaster ?? this.isLoadingProMaster,
      isLoadingFeatured: isLoadingFeatured ?? this.isLoadingFeatured,
      isLoadingExplore: isLoadingExplore ?? this.isLoadingExplore,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSort: selectedSort ?? this.selectedSort,
      bookmarkedIds: bookmarkedIds ?? this.bookmarkedIds,
      facets: facets ?? this.facets,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        highPriorityItems,
        proMasterItems,
        featuredItems,
        exploreItems,
        highPriorityTotal,
        proMasterTotal,
        featuredTotal,
        exploreTotal,
        isLoadingHighPriority,
        isLoadingProMaster,
        isLoadingFeatured,
        isLoadingExplore,
        searchQuery,
        selectedCity,
        selectedCategory,
        selectedSort,
        bookmarkedIds,
        facets,
        errorMessage,
      ];
}
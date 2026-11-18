import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/pagination/paginated_result.dart';
import '../models/gig_item_model.dart';
import '../models/gigs_feed_page.dart';

abstract class GigsRemoteDataSource {
  Future<GigsFeedPage> fetchHighPriorityGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  });

  Future<GigsFeedPage> fetchProMasterGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  });

  Future<GigsFeedPage> fetchFeaturedGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  });

  Future<GigsFeedPage> fetchExploreGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  });
}

class GigsRemoteDataSourceImpl implements GigsRemoteDataSource {
  final ApiClient apiClient;

  GigsRemoteDataSourceImpl({required this.apiClient});

  String? _mapSortParam(String? uiSort) {
    if (uiSort == null || uiSort.trim().isEmpty) return null;
    switch (uiSort.trim()) {
      case 'Best Match':
        return null;
      case 'Price: Low to High':
        return 'price_asc';
      case 'Price: High to Low':
        return 'price_desc';
      case 'Fastest Delivery':
        return 'delivery_asc';
      case 'Top Rated':
        return 'rating_desc';
      case 'Newest':
        return 'newest';
      default:
        return uiSort.trim();
    }
  }

  Future<GigsFeedPage> _fetchSection({
    required String section,
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    final queryParameters = <String, dynamic>{
      'section': section,
      'page': page,
      'limit': limit,
    };

    if (search != null && search.trim().isNotEmpty) {
      queryParameters['search'] = search.trim();
    }
    if (city != null &&
        city.trim().isNotEmpty &&
        city.trim().toLowerCase() != 'all cities') {
      queryParameters['city'] = city.trim();
    }
    if (category != null &&
        category.trim().isNotEmpty &&
        category.trim().toLowerCase() != 'all gigs') {
      queryParameters['category'] = category.trim();
    }

    final mappedSort = _mapSortParam(sortBy);
    if (mappedSort != null && mappedSort.isNotEmpty) {
      queryParameters['sortBy'] = mappedSort;
    }

    final response = await apiClient.get(
      ApiEndpoints.gigsPageBase,
      queryParameters: queryParameters,
    );

    final Map<String, dynamic> body = response.data is String
        ? jsonDecode(response.data as String) as Map<String, dynamic>
        : (response.data as Map<String, dynamic>);

    final rawData = body['data'];
    final List<dynamic> rawItems;
    if (rawData is List) {
      rawItems = rawData;
    } else if (rawData is Map<String, dynamic> && rawData['items'] is List) {
      rawItems = rawData['items'] as List<dynamic>;
    } else {
      rawItems = const <dynamic>[];
    }

    final items = rawItems
        .map((e) => GigItemModel.fromJson(
              Map<String, dynamic>.from(e as Map),
              fallbackSection: section,
            ))
        .toList();

    final pagination =
        body['pagination'] as Map<String, dynamic>? ?? const <String, dynamic>{};
    final total = (pagination['total'] as num?)?.toInt() ?? items.length;
    final currentPage = (pagination['page'] as num?)?.toInt() ?? page;
    final hasMore = pagination['hasMore'] as bool?;
    final hasReachedMax = hasMore != null ? !hasMore : items.length < limit;

    final facets = GigFacets.fromJson(
      body['facets'] as Map<String, dynamic>?,
    );

    return GigsFeedPage(
      paginated: PaginatedResult<GigItemModel>(
        items: items,
        total: total,
        page: currentPage,
        hasReachedMax: hasReachedMax,
      ),
      facets: facets,
    );
  }

  @override
  Future<GigsFeedPage> fetchHighPriorityGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) {
    return _fetchSection(
      section: 'high-priority',
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
      sortBy: sortBy,
    );
  }

  @override
  Future<GigsFeedPage> fetchProMasterGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) {
    return _fetchSection(
      section: 'pro-master',
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
      sortBy: sortBy,
    );
  }

  @override
  Future<GigsFeedPage> fetchFeaturedGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) {
    return _fetchSection(
      section: 'featured',
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
      sortBy: sortBy,
    );
  }

  @override
  Future<GigsFeedPage> fetchExploreGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) {
    return _fetchSection(
      section: 'explore',
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
      sortBy: sortBy,
    );
  }
}
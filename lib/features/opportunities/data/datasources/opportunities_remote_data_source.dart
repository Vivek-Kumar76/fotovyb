import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/pagination/paginated_result.dart';
import '../models/opportunities_feed_page.dart';
import '../models/opportunity_item_model.dart';

abstract class OpportunitiesRemoteDataSource {
  Future<OpportunitiesFeedPage> fetchHighPriorityOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  });

  Future<OpportunitiesFeedPage> fetchBoostedOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  });

  Future<OpportunitiesFeedPage> fetchFeaturedOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  });

  Future<void> applyToOpportunity(String opportunityId);
}

class OpportunitiesRemoteDataSourceImpl
    implements OpportunitiesRemoteDataSource {
  final ApiClient apiClient;

  OpportunitiesRemoteDataSourceImpl({required this.apiClient});

  Future<OpportunitiesFeedPage> _fetchSection({
    required String section,
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) async {
    final queryParameters = <String, dynamic>{
      'section': section,
      'page': page,
      'limit': limit,
    };

    if (category != null && category.trim().isNotEmpty) {
      queryParameters['category'] = category.trim();
    }
    if (location != null && location.trim().isNotEmpty) {
      queryParameters['location'] = location.trim();
    }
    if (roles != null && roles.isNotEmpty) {
      final cleanedRoles =
          roles.map((r) => r.trim()).where((r) => r.isNotEmpty).toList();
      if (cleanedRoles.isNotEmpty) {
        queryParameters['roles'] = cleanedRoles.join(',');
      }
    }
    if (budgetRange != null && budgetRange.trim().isNotEmpty) {
      queryParameters['budgetRange'] = budgetRange.trim();
    }

    final response = await apiClient.get(
      ApiEndpoints.opportunitiesPageBase,
      queryParameters: queryParameters,
    );

    final Map<String, dynamic> body = response.data is String
        ? jsonDecode(response.data as String) as Map<String, dynamic>
        : (response.data as Map<String, dynamic>);

    // Root `data` is a List in `/api/opportunities` (with fallback if nested under `items`)
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
        .map((e) => OpportunityItemModel.fromJson(
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

    final facets = OpportunityFacets.fromJson(
      body['facets'] as Map<String, dynamic>?,
    );

    return OpportunitiesFeedPage(
      paginated: PaginatedResult<OpportunityItemModel>(
        items: items,
        total: total,
        page: currentPage,
        hasReachedMax: hasReachedMax,
      ),
      facets: facets,
    );
  }

  @override
  Future<OpportunitiesFeedPage> fetchHighPriorityOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) {
    return _fetchSection(
      section: 'high-priority',
      page: page,
      limit: limit,
      category: category,
      location: location,
      roles: roles,
      budgetRange: budgetRange,
    );
  }

  @override
  Future<OpportunitiesFeedPage> fetchBoostedOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) {
    return _fetchSection(
      section: 'boosted',
      page: page,
      limit: limit,
      category: category,
      location: location,
      roles: roles,
      budgetRange: budgetRange,
    );
  }

  @override
  Future<OpportunitiesFeedPage> fetchFeaturedOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) {
    return _fetchSection(
      section: 'featured',
      page: page,
      limit: limit,
      category: category,
      location: location,
      roles: roles,
      budgetRange: budgetRange,
    );
  }

  @override
  Future<void> applyToOpportunity(String opportunityId) async {
    if (opportunityId.trim().isEmpty) return;
    await apiClient.post(
      '${ApiEndpoints.opportunitiesPageBase}/${opportunityId.trim()}/apply',
    );
  }
}
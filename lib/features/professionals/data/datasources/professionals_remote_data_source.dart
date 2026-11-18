import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/pagination/paginated_result.dart';
import '../../../home/data/models/creative_pro_model.dart';

abstract class ProfessionalsRemoteDataSource {
  // 1. Spotlight
  Future<PaginatedResult<CreativeProModel>> fetchSpotlightProfiles({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  });

  // 2. Prime
  Future<PaginatedResult<CreativeProModel>> fetchPrimeProfiles({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  });

  // 3. Featured
  Future<PaginatedResult<CreativeProModel>> fetchFeaturedProfessionals({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  });

  // 4. Rising Star
  Future<PaginatedResult<CreativeProModel>> fetchRisingStars({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  });

  Future<void> toggleBookmark(String professionalId);
}

class ProfessionalsRemoteDataSourceImpl implements ProfessionalsRemoteDataSource {
  final ApiClient apiClient;

  ProfessionalsRemoteDataSourceImpl({required this.apiClient});

  Future<PaginatedResult<CreativeProModel>> _fetchSection({
    required String endpoint,
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (search != null && search.trim().isNotEmpty) {
      queryParameters['search'] = search.trim();
    }
    if (city != null && city.trim().isNotEmpty && city != 'All') {
      queryParameters['location'] = city.trim();
    }
    if (category != null && category.trim().isNotEmpty && category != 'All') {
      queryParameters['category'] = category.trim();
    }

    final response = await apiClient.get(
      endpoint,
      queryParameters: queryParameters,
    );

    final Map<String, dynamic> body = response.data is String
        ? jsonDecode(response.data as String) as Map<String, dynamic>
        : (response.data as Map<String, dynamic>);

    final dataMap = body['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
    final rawItems = dataMap['items'] as List<dynamic>? ?? <dynamic>[];
    final pagination =
        dataMap['pagination'] as Map<String, dynamic>? ?? <String, dynamic>{};

    final items = rawItems.map((e) {
      final map = Map<String, dynamic>.from(e as Map<String, dynamic>);

      // Flatten nested cardDisplayImage object ({ _id, objectKey, viewUrl }) if present
      if (map['cardDisplayImage'] is Map) {
        final nestedUrl =
            (map['cardDisplayImage'] as Map)['viewUrl']?.toString().trim() ?? '';
        if ((map['cardDisplayImageUrl']?.toString().trim().isEmpty ?? true) &&
            nestedUrl.isNotEmpty) {
          map['cardDisplayImageUrl'] = nestedUrl;
        }
        map['cardDisplayImage'] = nestedUrl;
      }

      // Bridge numeric price / hourlyRate into startingPrice for CreativeProModel
      final existingStartingPrice =
          map['startingPrice']?.toString().trim() ?? '';
      if (existingStartingPrice.isEmpty) {
        final priceNum = (map['price'] as num?)?.toDouble() ?? 0;
        final hourlyNum = (map['hourlyRate'] as num?)?.toDouble() ?? 0;
        if (priceNum > 0) {
          map['startingPrice'] = priceNum.toInt().toString();
        } else if (hourlyNum > 0) {
          map['startingPrice'] = '${hourlyNum.toInt()}/hr';
        }
      }

      return CreativeProModel.fromJson(map);
    }).toList();

    final total = (pagination['total'] as num?)?.toInt() ?? items.length;
    final currentPage = (pagination['page'] as num?)?.toInt() ?? page;
    final hasNextPage = pagination['hasNextPage'] as bool?;
    final hasReachedMax =
        hasNextPage != null ? !hasNextPage : items.length < limit;

    return PaginatedResult<CreativeProModel>(
      items: items,
      total: total,
      page: currentPage,
      hasReachedMax: hasReachedMax,
    );
  }

  // ── 1. Spotlight
  @override
  Future<PaginatedResult<CreativeProModel>> fetchSpotlightProfiles({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) {
    return _fetchSection(
      endpoint: ApiEndpoints.professionalsSpotlight,
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
    );
  }

  // ── 2. Prime
  @override
  Future<PaginatedResult<CreativeProModel>> fetchPrimeProfiles({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) {
    return _fetchSection(
      endpoint: ApiEndpoints.professionalsPrime,
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
    );
  }

  // ── 3. Featured
  @override
  Future<PaginatedResult<CreativeProModel>> fetchFeaturedProfessionals({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) {
    return _fetchSection(
      endpoint: ApiEndpoints.professionalsFeatured,
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
    );
  }

  // ── 4. Rising Star
  @override
  Future<PaginatedResult<CreativeProModel>> fetchRisingStars({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) {
    return _fetchSection(
      endpoint: ApiEndpoints.professionalsRisingStars,
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
    );
  }

  @override
  Future<void> toggleBookmark(String professionalId) async {}
}
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/creative_pro_model.dart';
import '../models/brand_opportunity_model.dart';
import '../models/gig_model.dart';

abstract class HomeRemoteDataSource {
  // Existing Creative Professionals
  Future<List<CreativeProModel>> fetchCreativeProfessionals({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  });

  Future<List<CreativeProModel>> fetchSpotlightProfiles({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  });

  Future<List<CreativeProModel>> fetchFeaturedProfessionals({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  });

  Future<List<CreativeProModel>> fetchPrimeProfiles({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  });

  Future<List<CreativeProModel>> fetchRisingStars({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  });

  // Existing Brand Opportunities
  Future<List<BrandOpportunityModel>> fetchHighPriorityOpportunities({
    int page = 1,
    int limit = 10,
    String? city,
    String? category,
  });

  Future<List<BrandOpportunityModel>> fetchBoostedOpportunities({
    int page = 1,
    int limit = 10,
    String? city,
    String? category,
  });

  Future<List<BrandOpportunityModel>> fetchFeaturedOpportunities({
    int page = 1,
    int limit = 10,
    String? city,
    String? category,
  });

  // ── GIGs Feed (3 Tiers) ───────────────────────────────────────────────────
  Future<List<GigModel>> fetchHighPriorityGigs({
    int page = 1,
    int limit = 12,
    String? city,
    String? category,
  });

  Future<List<GigModel>> fetchProMasterGigs({
    int page = 1,
    int limit = 12,
    String? city,
    String? category,
  });

  Future<List<GigModel>> fetchFeaturedGigs({
    int page = 1,
    int limit = 12,
    String? city,
    String? category,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});

  // ── Existing Creative Pros ─────────────────────────────────────────────────
  @override
  Future<List<CreativeProModel>> fetchCreativeProfessionals({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.creativeProfessionals,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList
        .map((json) => CreativeProModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CreativeProModel>> fetchSpotlightProfiles({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.spotlight,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList
        .map((json) => CreativeProModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CreativeProModel>> fetchFeaturedProfessionals({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.featuredProfessionals,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList
        .map((json) => CreativeProModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CreativeProModel>> fetchPrimeProfiles({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.prime,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList
        .map((json) => CreativeProModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CreativeProModel>> fetchRisingStars({
    int page = 1,
    int limit = 15,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.risingStars,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList
        .map((json) => CreativeProModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // ── Existing Brand Opportunities ───────────────────────────────────────────
  @override
  Future<List<BrandOpportunityModel>> fetchHighPriorityOpportunities({
    int page = 1,
    int limit = 10,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.opportunitiesHighPriority,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList
        .map((json) => BrandOpportunityModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<BrandOpportunityModel>> fetchBoostedOpportunities({
    int page = 1,
    int limit = 10,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.opportunitiesBoosted,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList
        .map((json) => BrandOpportunityModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<BrandOpportunityModel>> fetchFeaturedOpportunities({
    int page = 1,
    int limit = 10,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.opportunitiesFeatured,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList
        .map((json) => BrandOpportunityModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // ── GIGs Feed Implementations ──────────────────────────────────────────────

  @override
  Future<List<GigModel>> fetchHighPriorityGigs({
    int page = 1,
    int limit = 12,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.gigsHighPriority,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList.map((json) {
      final map = json as Map<String, dynamic>;
      final gig = GigModel.fromJson(map);
      return gig.recognition.isEmpty
          ? gig.copyWith(recognition: 'highPriority')
          : gig;
    }).toList();
  }

  @override
  Future<List<GigModel>> fetchProMasterGigs({
    int page = 1,
    int limit = 12,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.gigsProMaster,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList.map((json) {
      final map = json as Map<String, dynamic>;
      final gig = GigModel.fromJson(map);
      return gig.recognition.isEmpty
          ? gig.copyWith(recognition: 'proMaster')
          : gig;
    }).toList();
  }

  @override
  Future<List<GigModel>> fetchFeaturedGigs({
    int page = 1,
    int limit = 12,
    String? city,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};
    if (city != null && city != 'All') queryParams['city'] = city;
    if (category != null && category != 'All') queryParams['category'] = category;

    final response = await apiClient.get(
      ApiEndpoints.gigsFeatured,
      queryParameters: queryParams,
    );
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList.map((json) {
      final map = json as Map<String, dynamic>;
      final gig = GigModel.fromJson(map);
      return gig.recognition.isEmpty
          ? gig.copyWith(recognition: 'featured')
          : gig;
    }).toList();
  }
}
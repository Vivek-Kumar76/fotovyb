import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/creative_pro_model.dart';
import '../../data/models/brand_opportunity_model.dart';
import '../../data/models/gig_model.dart';

abstract class HomeRepository {
  // ── Creative Professionals & Spotlights SWR Streams[cite: 16]
  Stream<List<CreativeProModel>> watchCreativeProfessionals({String? city, String? category});
  Stream<List<CreativeProModel>> watchSpotlightProfiles({String? city, String? category});
  Stream<List<CreativeProModel>> watchFeaturedProfessionals({String? city, String? category});
  Stream<List<CreativeProModel>> watchPrimeProfiles({String? city, String? category});
  Stream<List<CreativeProModel>> watchRisingStars({String? city, String? category});

  // ── Brand Opportunities SWR Streams[cite: 16]
  Stream<List<BrandOpportunityModel>> watchHighPriorityOpportunities({String? city, String? category});
  Stream<List<BrandOpportunityModel>> watchBoostedOpportunities({String? city, String? category});
  Stream<List<BrandOpportunityModel>> watchFeaturedOpportunities({String? city, String? category});

  // ── GIGs Feed SWR Streams (3 Tiers)
  Stream<List<GigModel>> watchHighPriorityGigs({String? city, String? category});
  Stream<List<GigModel>> watchProMasterGigs({String? city, String? category});
  Stream<List<GigModel>> watchFeaturedGigs({String? city, String? category});

  // ── Paginated Fetchers: Creative Professionals[cite: 16]
  Future<Result<List<CreativeProModel>, Failure>> getCreativeProfessionals({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  Future<Result<List<CreativeProModel>, Failure>> getSpotlightProfiles({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  Future<Result<List<CreativeProModel>, Failure>> getFeaturedProfessionals({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  Future<Result<List<CreativeProModel>, Failure>> getPrimeProfiles({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  Future<Result<List<CreativeProModel>, Failure>> getRisingStars({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  // ── Paginated Fetchers: Brand Opportunities[cite: 16]
  Future<Result<List<BrandOpportunityModel>, Failure>> getHighPriorityOpportunities({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  Future<Result<List<BrandOpportunityModel>, Failure>> getBoostedOpportunities({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  Future<Result<List<BrandOpportunityModel>, Failure>> getFeaturedOpportunities({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  // ── Paginated Fetchers: GIGs Feed (3 Tiers)
  Future<Result<List<GigModel>, Failure>> getHighPriorityGigs({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  Future<Result<List<GigModel>, Failure>> getProMasterGigs({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  Future<Result<List<GigModel>, Failure>> getFeaturedGigs({
    required int page,
    required int limit,
    String? city,
    String? category,
  });

  // ── User Actions[cite: 16]
  Future<void> toggleBookmark(CreativeProModel pro);
  Future<void> toggleSaveOpportunity(String opportunityId);
  Future<void> toggleFavoriteGig(String gigId);
}
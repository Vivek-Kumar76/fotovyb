import '../../../../core/errors/failures.dart';
import '../../../../core/pagination/paginated_result.dart';
import '../../../../core/utils/result.dart';
import '../../../home/data/models/creative_pro_model.dart';

abstract class ProfessionalsRepository {
  // ── SWR Streams (Ordered: 1. Spotlight -> 2. Featured -> 3. Prime -> 4. Rising Stars)
  Stream<List<CreativeProModel>> watchSpotlightProfiles({
    String? search,
    String? city,
    String? category,
  });

  Stream<List<CreativeProModel>> watchFeaturedProfessionals({
    String? search,
    String? city,
    String? category,
  });

  Stream<List<CreativeProModel>> watchPrimeProfiles({
    String? search,
    String? city,
    String? category,
  });

  Stream<List<CreativeProModel>> watchRisingStars({
    String? search,
    String? city,
    String? category,
  });

  // ── Paginated Fetchers for "View All" / "See All" Screens
  Future<Result<PaginatedResult<CreativeProModel>, Failure>> getSpotlightProfiles({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  });

  Future<Result<PaginatedResult<CreativeProModel>, Failure>> getFeaturedProfessionals({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  });

  Future<Result<PaginatedResult<CreativeProModel>, Failure>> getPrimeProfiles({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  });

  Future<Result<PaginatedResult<CreativeProModel>, Failure>> getRisingStars({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  });

  // ── User Actions
  Future<void> toggleBookmark(CreativeProModel pro);
}
import 'dart:async';
import '../../../../core/errors/failures.dart';
import '../../../../core/pagination/paginated_result.dart';
import '../../../../core/utils/result.dart';
import '../../../home/data/models/creative_pro_model.dart';
import '../../domain/repositories/professionals_repository.dart';
import '../datasources/professionals_local_data_source.dart';
import '../datasources/professionals_remote_data_source.dart';

class ProfessionalsRepositoryImpl implements ProfessionalsRepository {
  final ProfessionalsRemoteDataSource remoteDataSource;
  final ProfessionalsLocalDataSource localDataSource;

  ProfessionalsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  bool _isDefaultQuery({String? search, String? city, String? category}) {
    final noSearch = search == null || search.trim().isEmpty;
    final noCity = city == null || city.trim().isEmpty || city == 'All';
    final noCategory =
        category == null || category.trim().isEmpty || category == 'All';
    return noSearch && noCity && noCategory;
  }

  // ── 1. Spotlight SWR Stream ────────────────────────────────────────────────

  @override
  Stream<List<CreativeProModel>> watchSpotlightProfiles({
    String? search,
    String? city,
    String? category,
  }) async* {
    final useDefaultCache = _isDefaultQuery(
      search: search,
      city: city,
      category: category,
    );

    if (useDefaultCache) {
      final cached = localDataSource.getCachedSpotlightProfiles();
      if (cached != null && cached.isNotEmpty) {
        yield cached;
      }
    }

    try {
      final remote = await remoteDataSource.fetchSpotlightProfiles(
        page: 1,
        limit: 15,
        search: search,
        city: city,
        category: category,
      );
      if (useDefaultCache) {
        await localDataSource.cacheSpotlightProfiles(remote.items);
      }
      yield remote.items;
    } catch (_) {
      if (!useDefaultCache) yield const [];
    }
  }

  // ── 2. Featured Professionals SWR Stream ───────────────────────────────────

  @override
  Stream<List<CreativeProModel>> watchFeaturedProfessionals({
    String? search,
    String? city,
    String? category,
  }) async* {
    final useDefaultCache = _isDefaultQuery(
      search: search,
      city: city,
      category: category,
    );

    if (useDefaultCache) {
      final cached = localDataSource.getCachedFeaturedProfessionals();
      if (cached != null && cached.isNotEmpty) {
        yield cached;
      }
    }

    try {
      final remote = await remoteDataSource.fetchFeaturedProfessionals(
        page: 1,
        limit: 15,
        search: search,
        city: city,
        category: category,
      );
      if (useDefaultCache) {
        await localDataSource.cacheFeaturedProfessionals(remote.items);
      }
      yield remote.items;
    } catch (_) {
      if (!useDefaultCache) yield const [];
    }
  }

  // ── 3. Prime Profiles SWR Stream ───────────────────────────────────────────

  @override
  Stream<List<CreativeProModel>> watchPrimeProfiles({
    String? search,
    String? city,
    String? category,
  }) async* {
    final useDefaultCache = _isDefaultQuery(
      search: search,
      city: city,
      category: category,
    );

    if (useDefaultCache) {
      final cached = localDataSource.getCachedPrimeProfiles();
      if (cached != null && cached.isNotEmpty) {
        yield cached;
      }
    }

    try {
      final remote = await remoteDataSource.fetchPrimeProfiles(
        page: 1,
        limit: 15,
        search: search,
        city: city,
        category: category,
      );
      if (useDefaultCache) {
        await localDataSource.cachePrimeProfiles(remote.items);
      }
      yield remote.items;
    } catch (_) {
      if (!useDefaultCache) yield const [];
    }
  }

  // ── 4. Rising Stars SWR Stream ─────────────────────────────────────────────

  @override
  Stream<List<CreativeProModel>> watchRisingStars({
    String? search,
    String? city,
    String? category,
  }) async* {
    final useDefaultCache = _isDefaultQuery(
      search: search,
      city: city,
      category: category,
    );

    if (useDefaultCache) {
      final cached = localDataSource.getCachedRisingStars();
      if (cached != null && cached.isNotEmpty) {
        yield cached;
      }
    }

    try {
      final remote = await remoteDataSource.fetchRisingStars(
        page: 1,
        limit: 15,
        search: search,
        city: city,
        category: category,
      );
      if (useDefaultCache) {
        await localDataSource.cacheRisingStars(remote.items);
      }
      yield remote.items;
    } catch (_) {
      if (!useDefaultCache) yield const [];
    }
  }

  // ── Paginated Fetchers for "View All" / "See All" Screens ──────────────────

  @override
  Future<Result<PaginatedResult<CreativeProModel>, Failure>> getSpotlightProfiles({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchSpotlightProfiles(
        page: page,
        limit: limit,
        search: search,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PaginatedResult<CreativeProModel>, Failure>> getFeaturedProfessionals({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchFeaturedProfessionals(
        page: page,
        limit: limit,
        search: search,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PaginatedResult<CreativeProModel>, Failure>> getPrimeProfiles({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchPrimeProfiles(
        page: page,
        limit: limit,
        search: search,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PaginatedResult<CreativeProModel>, Failure>> getRisingStars({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchRisingStars(
        page: page,
        limit: limit,
        search: search,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  // ── User Actions ───────────────────────────────────────────────────────────

  @override
  Future<void> toggleBookmark(CreativeProModel pro) async {
    try {
      await remoteDataSource.toggleBookmark(pro.id);
    } catch (_) {}
  }
}
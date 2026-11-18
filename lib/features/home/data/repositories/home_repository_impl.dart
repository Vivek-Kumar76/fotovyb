import 'dart:async';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/creative_pro_model.dart';
import '../models/brand_opportunity_model.dart';
import '../models/gig_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  // ── Existing Creative Pros & Showcase Watchers ─────────────────────────────

  @override
  Stream<List<CreativeProModel>> watchCreativeProfessionals({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedCreativeProfessionals();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchCreativeProfessionals(
        page: 1,
        limit: 15,
        city: city,
        category: category,
      );
      await localDataSource.cacheCreativeProfessionals(remote);
      yield remote;
    } catch (_) {}
  }

  @override
  Stream<List<CreativeProModel>> watchSpotlightProfiles({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedSpotlightProfiles();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchSpotlightProfiles(
        page: 1,
        limit: 15,
        city: city,
        category: category,
      );
      await localDataSource.cacheSpotlightProfiles(remote);
      yield remote;
    } catch (_) {}
  }

  @override
  Stream<List<CreativeProModel>> watchFeaturedProfessionals({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedFeaturedProfessionals();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchFeaturedProfessionals(
        page: 1,
        limit: 15,
        city: city,
        category: category,
      );
      await localDataSource.cacheFeaturedProfessionals(remote);
      yield remote;
    } catch (_) {}
  }

  @override
  Stream<List<CreativeProModel>> watchPrimeProfiles({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedPrimeProfiles();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchPrimeProfiles(
        page: 1,
        limit: 15,
        city: city,
        category: category,
      );
      await localDataSource.cachePrimeProfiles(remote);
      yield remote;
    } catch (_) {}
  }

  @override
  Stream<List<CreativeProModel>> watchRisingStars({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedRisingStars();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchRisingStars(
        page: 1,
        limit: 15,
        city: city,
        category: category,
      );
      await localDataSource.cacheRisingStars(remote);
      yield remote;
    } catch (_) {}
  }

  // ── Brand Opportunities SWR Watchers (3 Tiers) ─────────────────────────────

  @override
  Stream<List<BrandOpportunityModel>> watchHighPriorityOpportunities({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedHighPriorityOpportunities();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchHighPriorityOpportunities(
        page: 1,
        limit: 10,
        city: city,
        category: category,
      );
      await localDataSource.cacheHighPriorityOpportunities(remote);
      yield remote;
    } catch (_) {}
  }

  @override
  Stream<List<BrandOpportunityModel>> watchBoostedOpportunities({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedBoostedOpportunities();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchBoostedOpportunities(
        page: 1,
        limit: 10,
        city: city,
        category: category,
      );
      await localDataSource.cacheBoostedOpportunities(remote);
      yield remote;
    } catch (_) {}
  }

  @override
  Stream<List<BrandOpportunityModel>> watchFeaturedOpportunities({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedFeaturedOpportunities();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchFeaturedOpportunities(
        page: 1,
        limit: 10,
        city: city,
        category: category,
      );
      await localDataSource.cacheFeaturedOpportunities(remote);
      yield remote;
    } catch (_) {}
  }

  // ── GIGs Feed SWR Watchers (3 Tiers) ───────────────────────────────────────

  @override
  Stream<List<GigModel>> watchHighPriorityGigs({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedHighPriorityGigs();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchHighPriorityGigs(
        page: 1,
        limit: 12,
        city: city,
        category: category,
      );
      await localDataSource.cacheHighPriorityGigs(remote);
      yield remote;
    } catch (_) {}
  }

  @override
  Stream<List<GigModel>> watchProMasterGigs({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedProMasterGigs();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchProMasterGigs(
        page: 1,
        limit: 12,
        city: city,
        category: category,
      );
      await localDataSource.cacheProMasterGigs(remote);
      yield remote;
    } catch (_) {}
  }

  @override
  Stream<List<GigModel>> watchFeaturedGigs({
    String? city,
    String? category,
  }) async* {
    final cached = localDataSource.getCachedFeaturedGigs();
    if (cached != null && cached.isNotEmpty) {
      yield cached;
    }
    try {
      final remote = await remoteDataSource.fetchFeaturedGigs(
        page: 1,
        limit: 12,
        city: city,
        category: category,
      );
      await localDataSource.cacheFeaturedGigs(remote);
      yield remote;
    } catch (_) {}
  }

  // ── Paginated Fetchers: Creative Professionals ─────────────────────────────

  @override
  Future<Result<List<CreativeProModel>, Failure>> getCreativeProfessionals({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchCreativeProfessionals(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<CreativeProModel>, Failure>> getSpotlightProfiles({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchSpotlightProfiles(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<CreativeProModel>, Failure>> getFeaturedProfessionals({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchFeaturedProfessionals(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<CreativeProModel>, Failure>> getPrimeProfiles({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchPrimeProfiles(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<CreativeProModel>, Failure>> getRisingStars({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchRisingStars(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  // ── Paginated Fetchers: Brand Opportunities ────────────────────────────────

  @override
  Future<Result<List<BrandOpportunityModel>, Failure>> getHighPriorityOpportunities({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchHighPriorityOpportunities(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<BrandOpportunityModel>, Failure>> getBoostedOpportunities({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchBoostedOpportunities(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<BrandOpportunityModel>, Failure>> getFeaturedOpportunities({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchFeaturedOpportunities(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  // ── Paginated Fetchers: GIGs Feed (3 Tiers) ────────────────────────────────

  @override
  Future<Result<List<GigModel>, Failure>> getHighPriorityGigs({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchHighPriorityGigs(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<GigModel>, Failure>> getProMasterGigs({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchProMasterGigs(
        page: page,
        limit: limit,
        city: city,
        category: category,
      );
      return Success(data);
    } catch (e) {
      return FailureResult(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<GigModel>, Failure>> getFeaturedGigs({
    required int page,
    required int limit,
    String? city,
    String? category,
  }) async {
    try {
      final data = await remoteDataSource.fetchFeaturedGigs(
        page: page,
        limit: limit,
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
    // Optimistic toggle or remote API bookmark action
  }

  @override
  Future<void> toggleSaveOpportunity(String opportunityId) async {
    // Optimistic toggle or remote API bookmark action
  }

  @override
  Future<void> toggleFavoriteGig(String gigId) async {
    // Optimistic toggle or remote API favorite action
  }
}
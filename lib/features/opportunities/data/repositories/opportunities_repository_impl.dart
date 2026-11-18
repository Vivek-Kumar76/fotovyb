import '../../domain/repositories/opportunities_repository.dart';
import '../datasources/opportunities_local_data_source.dart';
import '../datasources/opportunities_remote_data_source.dart';
import '../models/opportunities_feed_page.dart';

class OpportunitiesRepositoryImpl implements OpportunitiesRepository {
  final OpportunitiesRemoteDataSource remoteDataSource;
  final OpportunitiesLocalDataSource localDataSource;

  OpportunitiesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  bool _hasNoFilters({
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) {
    final hasCategory = category != null && category.trim().isNotEmpty;
    final hasLocation = location != null && location.trim().isNotEmpty;
    final hasRoles = roles != null && roles.isNotEmpty;
    final hasBudget = budgetRange != null && budgetRange.trim().isNotEmpty;
    return !hasCategory && !hasLocation && !hasRoles && !hasBudget;
  }

  @override
  Future<OpportunitiesFeedPage?> getCachedSection(String section) {
    return localDataSource.getCachedSection(section);
  }

  @override
  Future<OpportunitiesFeedPage> getHighPriorityOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) async {
    final result = await remoteDataSource.fetchHighPriorityOpportunities(
      page: page,
      limit: limit,
      category: category,
      location: location,
      roles: roles,
      budgetRange: budgetRange,
    );

    if (page == 1 &&
        _hasNoFilters(
          category: category,
          location: location,
          roles: roles,
          budgetRange: budgetRange,
        )) {
      await localDataSource.cacheSection('high-priority', result);
    }
    return result;
  }

  @override
  Future<OpportunitiesFeedPage> getBoostedOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) async {
    final result = await remoteDataSource.fetchBoostedOpportunities(
      page: page,
      limit: limit,
      category: category,
      location: location,
      roles: roles,
      budgetRange: budgetRange,
    );

    if (page == 1 &&
        _hasNoFilters(
          category: category,
          location: location,
          roles: roles,
          budgetRange: budgetRange,
        )) {
      await localDataSource.cacheSection('boosted', result);
    }
    return result;
  }

  @override
  Future<OpportunitiesFeedPage> getFeaturedOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  }) async {
    final result = await remoteDataSource.fetchFeaturedOpportunities(
      page: page,
      limit: limit,
      category: category,
      location: location,
      roles: roles,
      budgetRange: budgetRange,
    );

    if (page == 1 &&
        _hasNoFilters(
          category: category,
          location: location,
          roles: roles,
          budgetRange: budgetRange,
        )) {
      await localDataSource.cacheSection('featured', result);
    }
    return result;
  }

  @override
  Future<void> applyToOpportunity(String opportunityId) {
    return remoteDataSource.applyToOpportunity(opportunityId);
  }
}
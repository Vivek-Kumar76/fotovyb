import '../../domain/repositories/gigs_repository.dart';
import '../datasources/gigs_local_data_source.dart';
import '../datasources/gigs_remote_data_source.dart';
import '../models/gigs_feed_page.dart';

class GigsRepositoryImpl implements GigsRepository {
  final GigsRemoteDataSource remoteDataSource;
  final GigsLocalDataSource localDataSource;

  GigsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  bool _hasNoFilters({
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) {
    final hasSearch = search != null && search.trim().isNotEmpty;
    final hasCity = city != null &&
        city.trim().isNotEmpty &&
        city.trim().toLowerCase() != 'all cities';
    final hasCategory = category != null &&
        category.trim().isNotEmpty &&
        category.trim().toLowerCase() != 'all gigs';
    final hasSort = sortBy != null &&
        sortBy.trim().isNotEmpty &&
        sortBy.trim() != 'Best Match';
    return !hasSearch && !hasCity && !hasCategory && !hasSort;
  }

  @override
  Future<GigsFeedPage?> getCachedSection(String section) {
    return localDataSource.getCachedSection(section);
  }

  @override
  Future<GigsFeedPage> getHighPriorityGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    final result = await remoteDataSource.fetchHighPriorityGigs(
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
      sortBy: sortBy,
    );

    if (page == 1 &&
        _hasNoFilters(
          search: search,
          city: city,
          category: category,
          sortBy: sortBy,
        )) {
      await localDataSource.cacheSection('high-priority', result);
    }
    return result;
  }

  @override
  Future<GigsFeedPage> getProMasterGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    final result = await remoteDataSource.fetchProMasterGigs(
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
      sortBy: sortBy,
    );

    if (page == 1 &&
        _hasNoFilters(
          search: search,
          city: city,
          category: category,
          sortBy: sortBy,
        )) {
      await localDataSource.cacheSection('pro-master', result);
    }
    return result;
  }

  @override
  Future<GigsFeedPage> getFeaturedGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    final result = await remoteDataSource.fetchFeaturedGigs(
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
      sortBy: sortBy,
    );

    if (page == 1 &&
        _hasNoFilters(
          search: search,
          city: city,
          category: category,
          sortBy: sortBy,
        )) {
      await localDataSource.cacheSection('featured', result);
    }
    return result;
  }

  @override
  Future<GigsFeedPage> getExploreGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  }) async {
    final result = await remoteDataSource.fetchExploreGigs(
      page: page,
      limit: limit,
      search: search,
      city: city,
      category: category,
      sortBy: sortBy,
    );

    if (page == 1 &&
        _hasNoFilters(
          search: search,
          city: city,
          category: category,
          sortBy: sortBy,
        )) {
      await localDataSource.cacheSection('explore', result);
    }
    return result;
  }
}
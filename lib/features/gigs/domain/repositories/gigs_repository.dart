import '../../data/models/gigs_feed_page.dart';

abstract class GigsRepository {
  Future<GigsFeedPage?> getCachedSection(String section);

  Future<GigsFeedPage> getHighPriorityGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  });

  Future<GigsFeedPage> getProMasterGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  });

  Future<GigsFeedPage> getFeaturedGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  });

  Future<GigsFeedPage> getExploreGigs({
    required int page,
    required int limit,
    String? search,
    String? city,
    String? category,
    String? sortBy,
  });
}
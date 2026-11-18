import '../../data/models/opportunities_feed_page.dart';

abstract class OpportunitiesRepository {
  Future<OpportunitiesFeedPage?> getCachedSection(String section);

  Future<OpportunitiesFeedPage> getHighPriorityOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  });

  Future<OpportunitiesFeedPage> getBoostedOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  });

  Future<OpportunitiesFeedPage> getFeaturedOpportunities({
    required int page,
    required int limit,
    String? category,
    String? location,
    List<String>? roles,
    String? budgetRange,
  });

  Future<void> applyToOpportunity(String opportunityId);
}
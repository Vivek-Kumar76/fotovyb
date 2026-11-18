import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/pagination/paginated_result.dart';
import '../models/gig_item_model.dart';
import '../models/gigs_feed_page.dart';

abstract class GigsLocalDataSource {
  Future<GigsFeedPage?> getCachedSection(String section);
  Future<void> cacheSection(String section, GigsFeedPage feedPage);
  Future<void> clearAllCache();
}

class GigsLocalDataSourceImpl implements GigsLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _keyPrefix = 'gigs_swr_v1_';

  GigsLocalDataSourceImpl({required this.sharedPreferences});

  String _cacheKey(String section) =>
      '$_keyPrefix${section.trim().toLowerCase()}';

  @override
  Future<GigsFeedPage?> getCachedSection(String section) async {
    final raw = sharedPreferences.getString(_cacheKey(section));
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final rawItems = decoded['items'] as List<dynamic>? ?? const <dynamic>[];
      final items = rawItems
          .map((e) => GigItemModel.fromJson(
                Map<String, dynamic>.from(e as Map),
                fallbackSection: section,
              ))
          .toList();

      final total = (decoded['total'] as num?)?.toInt() ?? items.length;
      final page = (decoded['page'] as num?)?.toInt() ?? 1;
      final hasReachedMax = decoded['hasReachedMax'] as bool? ?? true;
      final facets = GigFacets.fromJson(
        decoded['facets'] as Map<String, dynamic>?,
      );

      return GigsFeedPage(
        paginated: PaginatedResult<GigItemModel>(
          items: items,
          total: total,
          page: page,
          hasReachedMax: hasReachedMax,
        ),
        facets: facets,
      );
    } catch (_) {
      await sharedPreferences.remove(_cacheKey(section));
      return null;
    }
  }

  @override
  Future<void> cacheSection(
    String section,
    GigsFeedPage feedPage,
  ) async {
    final payload = <String, dynamic>{
      'items': feedPage.paginated.items.map((e) => e.toJson()).toList(),
      'total': feedPage.paginated.total,
      'page': feedPage.paginated.page,
      'hasReachedMax': feedPage.paginated.hasReachedMax,
      'facets': feedPage.facets.toJson(),
    };
    await sharedPreferences.setString(_cacheKey(section), jsonEncode(payload));
  }

  @override
  Future<void> clearAllCache() async {
    final keys = sharedPreferences
        .getKeys()
        .where((k) => k.startsWith(_keyPrefix))
        .toList();
    for (final k in keys) {
      await sharedPreferences.remove(k);
    }
  }
}
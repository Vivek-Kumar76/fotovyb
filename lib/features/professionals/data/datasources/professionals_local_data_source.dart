import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../home/data/models/creative_pro_model.dart';

abstract class ProfessionalsLocalDataSource {
  // 1. Spotlight
  List<CreativeProModel>? getCachedSpotlightProfiles();
  Future<void> cacheSpotlightProfiles(List<CreativeProModel> items);

  // 2. Featured
  List<CreativeProModel>? getCachedFeaturedProfessionals();
  Future<void> cacheFeaturedProfessionals(List<CreativeProModel> items);

  // 3. Prime
  List<CreativeProModel>? getCachedPrimeProfiles();
  Future<void> cachePrimeProfiles(List<CreativeProModel> items);

  // 4. Rising Stars
  List<CreativeProModel>? getCachedRisingStars();
  Future<void> cacheRisingStars(List<CreativeProModel> items);
}

class ProfessionalsLocalDataSourceImpl implements ProfessionalsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProfessionalsLocalDataSourceImpl({required this.sharedPreferences});

  static const String _kSpotlightKey = 'cache_pros_spotlight';
  static const String _kFeaturedKey = 'cache_pros_featured';
  static const String _kPrimeKey = 'cache_pros_prime';
  static const String _kRisingStarsKey = 'cache_pros_rising_stars';

  List<CreativeProModel>? _readList(String key) {
    final rawJson = sharedPreferences.getString(key);
    if (rawJson == null) return null;
    try {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((e) => CreativeProModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeList(String key, List<CreativeProModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(key, encoded);
  }

  @override
  List<CreativeProModel>? getCachedSpotlightProfiles() => _readList(_kSpotlightKey);

  @override
  Future<void> cacheSpotlightProfiles(List<CreativeProModel> items) =>
      _writeList(_kSpotlightKey, items);

  @override
  List<CreativeProModel>? getCachedFeaturedProfessionals() => _readList(_kFeaturedKey);

  @override
  Future<void> cacheFeaturedProfessionals(List<CreativeProModel> items) =>
      _writeList(_kFeaturedKey, items);

  @override
  List<CreativeProModel>? getCachedPrimeProfiles() => _readList(_kPrimeKey);

  @override
  Future<void> cachePrimeProfiles(List<CreativeProModel> items) =>
      _writeList(_kPrimeKey, items);

  @override
  List<CreativeProModel>? getCachedRisingStars() => _readList(_kRisingStarsKey);

  @override
  Future<void> cacheRisingStars(List<CreativeProModel> items) =>
      _writeList(_kRisingStarsKey, items);
}
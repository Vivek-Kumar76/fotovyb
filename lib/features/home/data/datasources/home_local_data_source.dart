import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/creative_pro_model.dart';
import '../models/brand_opportunity_model.dart';
import '../models/gig_model.dart';

abstract class HomeLocalDataSource {
  List<CreativeProModel>? getCachedCreativeProfessionals();
  Future<void> cacheCreativeProfessionals(List<CreativeProModel> items);

  List<CreativeProModel>? getCachedSpotlightProfiles();
  Future<void> cacheSpotlightProfiles(List<CreativeProModel> items);

  List<CreativeProModel>? getCachedFeaturedProfessionals();
  Future<void> cacheFeaturedProfessionals(List<CreativeProModel> items);

  List<CreativeProModel>? getCachedPrimeProfiles();
  Future<void> cachePrimeProfiles(List<CreativeProModel> items);

  List<CreativeProModel>? getCachedRisingStars();
  Future<void> cacheRisingStars(List<CreativeProModel> items);

  // ── Brand Opportunities Local Cache
  List<BrandOpportunityModel>? getCachedHighPriorityOpportunities();
  Future<void> cacheHighPriorityOpportunities(List<BrandOpportunityModel> items);

  List<BrandOpportunityModel>? getCachedBoostedOpportunities();
  Future<void> cacheBoostedOpportunities(List<BrandOpportunityModel> items);

  List<BrandOpportunityModel>? getCachedFeaturedOpportunities();
  Future<void> cacheFeaturedOpportunities(List<BrandOpportunityModel> items);

  // ── GIGs Feed Local Cache (3 Tiers)
  List<GigModel>? getCachedHighPriorityGigs();
  Future<void> cacheHighPriorityGigs(List<GigModel> items);

  List<GigModel>? getCachedProMasterGigs();
  Future<void> cacheProMasterGigs(List<GigModel> items);

  List<GigModel>? getCachedFeaturedGigs();
  Future<void> cacheFeaturedGigs(List<GigModel> items);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeLocalDataSourceImpl({required this.sharedPreferences});

  static const String _kCreativeProsKey = 'cache_home_creative_pros';
  static const String _kSpotlightKey = 'cache_home_spotlight';
  static const String _kFeaturedProsKey = 'cache_home_featured_pros';
  static const String _kPrimeKey = 'cache_home_prime';
  static const String _kRisingStarsKey = 'cache_home_rising_stars';

  // Opportunities Keys
  static const String _kHighPriorityOppsKey = 'cache_home_opps_high_priority';
  static const String _kBoostedOppsKey = 'cache_home_opps_boosted';
  static const String _kFeaturedOppsKey = 'cache_home_opps_featured';

  // GIGs Keys
  static const String _kHighPriorityGigsKey = 'cache_home_gigs_high_priority';
  static const String _kProMasterGigsKey = 'cache_home_gigs_pro_master';
  static const String _kFeaturedGigsKey = 'cache_home_gigs_featured';

  @override
  List<CreativeProModel>? getCachedCreativeProfessionals() {
    final rawJson = sharedPreferences.getString(_kCreativeProsKey);
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

  @override
  Future<void> cacheCreativeProfessionals(List<CreativeProModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kCreativeProsKey, encoded);
  }

  @override
  List<CreativeProModel>? getCachedSpotlightProfiles() {
    final rawJson = sharedPreferences.getString(_kSpotlightKey);
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

  @override
  Future<void> cacheSpotlightProfiles(List<CreativeProModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kSpotlightKey, encoded);
  }

  @override
  List<CreativeProModel>? getCachedFeaturedProfessionals() {
    final rawJson = sharedPreferences.getString(_kFeaturedProsKey);
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

  @override
  Future<void> cacheFeaturedProfessionals(List<CreativeProModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kFeaturedProsKey, encoded);
  }

  @override
  List<CreativeProModel>? getCachedPrimeProfiles() {
    final rawJson = sharedPreferences.getString(_kPrimeKey);
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

  @override
  Future<void> cachePrimeProfiles(List<CreativeProModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kPrimeKey, encoded);
  }

  @override
  List<CreativeProModel>? getCachedRisingStars() {
    final rawJson = sharedPreferences.getString(_kRisingStarsKey);
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

  @override
  Future<void> cacheRisingStars(List<CreativeProModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kRisingStarsKey, encoded);
  }

  // ── Brand Opportunities Implementations ────────────────────────────────────

  @override
  List<BrandOpportunityModel>? getCachedHighPriorityOpportunities() {
    final rawJson = sharedPreferences.getString(_kHighPriorityOppsKey);
    if (rawJson == null) return null;
    try {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((e) => BrandOpportunityModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheHighPriorityOpportunities(List<BrandOpportunityModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kHighPriorityOppsKey, encoded);
  }

  @override
  List<BrandOpportunityModel>? getCachedBoostedOpportunities() {
    final rawJson = sharedPreferences.getString(_kBoostedOppsKey);
    if (rawJson == null) return null;
    try {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((e) => BrandOpportunityModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheBoostedOpportunities(List<BrandOpportunityModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kBoostedOppsKey, encoded);
  }

  @override
  List<BrandOpportunityModel>? getCachedFeaturedOpportunities() {
    final rawJson = sharedPreferences.getString(_kFeaturedOppsKey);
    if (rawJson == null) return null;
    try {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((e) => BrandOpportunityModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheFeaturedOpportunities(List<BrandOpportunityModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kFeaturedOppsKey, encoded);
  }

  // ── GIGs Feed Implementations ──────────────────────────────────────────────

  @override
  List<GigModel>? getCachedHighPriorityGigs() {
    final rawJson = sharedPreferences.getString(_kHighPriorityGigsKey);
    if (rawJson == null) return null;
    try {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((e) => GigModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheHighPriorityGigs(List<GigModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kHighPriorityGigsKey, encoded);
  }

  @override
  List<GigModel>? getCachedProMasterGigs() {
    final rawJson = sharedPreferences.getString(_kProMasterGigsKey);
    if (rawJson == null) return null;
    try {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((e) => GigModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheProMasterGigs(List<GigModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kProMasterGigsKey, encoded);
  }

  @override
  List<GigModel>? getCachedFeaturedGigs() {
    final rawJson = sharedPreferences.getString(_kFeaturedGigsKey);
    if (rawJson == null) return null;
    try {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((e) => GigModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheFeaturedGigs(List<GigModel> items) async {
    final encoded = jsonEncode(items.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(_kFeaturedGigsKey, encoded);
  }
}
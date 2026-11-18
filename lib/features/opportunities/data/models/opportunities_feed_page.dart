import 'package:equatable/equatable.dart';
import '../../../../core/pagination/paginated_result.dart';
import 'opportunity_item_model.dart';

class OpportunityFacets extends Equatable {
  final Map<String, int> sections;
  final Map<String, int> categories;
  final Map<String, int> locations;
  final Map<String, int> roles;
  final Map<String, int> budgetRange;

  const OpportunityFacets({
    this.sections = const {},
    this.categories = const {},
    this.locations = const {},
    this.roles = const {},
    this.budgetRange = const {},
  });

  factory OpportunityFacets.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const OpportunityFacets();
    return OpportunityFacets(
      sections: _parseIntMap(json['sections']),
      categories: _parseIntMap(json['categories']),
      locations: _parseIntMap(json['locations']),
      roles: _parseIntMap(json['roles']),
      budgetRange: _parseIntMap(json['budgetRange']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sections': sections,
      'categories': categories,
      'locations': locations,
      'roles': roles,
      'budgetRange': budgetRange,
    };
  }

  static Map<String, int> _parseIntMap(dynamic raw) {
    if (raw is! Map) return const {};
    final result = <String, int>{};
    raw.forEach((key, value) {
      final k = key.toString().trim();
      final v = value is num ? value.toInt() : int.tryParse(value.toString()) ?? 0;
      if (k.isNotEmpty) {
        result[k] = v;
      }
    });
    return result;
  }

  @override
  List<Object?> get props => [
        sections,
        categories,
        locations,
        roles,
        budgetRange,
      ];
}

class OpportunitiesFeedPage {
  final PaginatedResult<OpportunityItemModel> paginated;
  final OpportunityFacets facets;

  const OpportunitiesFeedPage({
    required this.paginated,
    this.facets = const OpportunityFacets(),
  });
}
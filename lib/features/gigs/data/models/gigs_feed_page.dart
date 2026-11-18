import 'package:equatable/equatable.dart';
import '../../../../core/pagination/paginated_result.dart';
import 'gig_item_model.dart';

class GigFacets extends Equatable {
  final Map<String, int> category;
  final Map<String, int> subcategory;

  const GigFacets({
    this.category = const {},
    this.subcategory = const {},
  });

  factory GigFacets.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const GigFacets();
    return GigFacets(
      category: _parseIntMap(json['category']),
      subcategory: _parseIntMap(json['subcategory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'subcategory': subcategory,
    };
  }

  static Map<String, int> _parseIntMap(dynamic raw) {
    if (raw is! Map) return const {};
    final result = <String, int>{};
    raw.forEach((key, value) {
      final k = key.toString().trim();
      final v =
          value is num ? value.toInt() : int.tryParse(value.toString()) ?? 0;
      if (k.isNotEmpty) {
        result[k] = v;
      }
    });
    return result;
  }

  @override
  List<Object?> get props => [category, subcategory];
}

class GigsFeedPage {
  final PaginatedResult<GigItemModel> paginated;
  final GigFacets facets;

  const GigsFeedPage({
    required this.paginated,
    this.facets = const GigFacets(),
  });
}
import 'package:equatable/equatable.dart';
import '../../../../core/pagination/identifiable.dart';

class OpportunityItemModel extends Equatable implements Identifiable {
  @override
  final String id;
  final String title;
  final String description;
  final String brand;
  final String category;
  final String section;
  final String location;
  final String duration;
  final String budgetDisplay;
  final double budgetAmount;
  final List<String> roles;
  final String imageUrl;
  final bool isUrgent;
  final bool isBoosted;
  final bool isFeatured;
  final bool isApplied;
  final DateTime? createdAt;

  const OpportunityItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.brand,
    required this.category,
    required this.section,
    required this.location,
    required this.duration,
    required this.budgetDisplay,
    required this.budgetAmount,
    required this.roles,
    required this.imageUrl,
    required this.isUrgent,
    required this.isBoosted,
    required this.isFeatured,
    required this.isApplied,
    this.createdAt,
  });

  factory OpportunityItemModel.fromJson(
    Map<String, dynamic> json, {
    String fallbackSection = '',
  }) {
    final parsedId =
        json['id']?.toString() ?? json['_id']?.toString() ?? '';

    final parsedTitle = _firstNonEmpty([
          json['title'],
          json['projectTitle'],
          json['name'],
        ]) ??
        'Creative Opportunity';

    final parsedDesc = _firstNonEmpty([
          json['description'],
          json['summary'],
          json['subtitle'],
          json['brief'],
        ]) ??
        '';

    final parsedBrand = _extractBrand(json);

    final parsedCategory = _firstNonEmpty([
          json['category'],
          json['industry'],
          json['industryCategory'],
        ]) ??
        'General';

    final parsedSection = _firstNonEmpty([
          json['section'],
          fallbackSection,
        ]) ??
        'featured';

    final parsedLocation = _firstNonEmpty([
          json['location'],
          json['city'],
        ]) ??
        'Remote';

    final parsedDuration = _firstNonEmpty([
          json['duration'],
          json['timeline'],
          json['projectDuration'],
        ]) ??
        'Flexible';

    final parsedRoles = _extractStringList([
      json['roles'],
      json['requiredRoles'],
      json['tags'],
      json['skills'],
      json['subCategory'],
    ]);

    final parsedImage = _extractImageUrl(json);

    final rawBudget = json['budget'] ??
        json['price'] ??
        json['amount'] ??
        json['compensation'] ??
        json['budgetAmount'];
    final numBudget = rawBudget is num
        ? rawBudget.toDouble()
        : double.tryParse(
              rawBudget?.toString().replaceAll(RegExp(r'[^0-9.]'), '') ?? '',
            ) ??
            0.0;

    final rawBudgetLabel = _firstNonEmpty([
      json['budgetLabel'],
      json['formattedBudget'],
      if (rawBudget is String && rawBudget.trim().isNotEmpty) rawBudget,
      json['budgetRange'],
    ]);

    final effectiveBudgetDisplay = rawBudgetLabel != null
        ? (rawBudgetLabel.startsWith('₹') ? rawBudgetLabel : '₹$rawBudgetLabel')
        : (numBudget > 0 ? _formatIndianCurrency(numBudget) : 'On Request');

    final secLower = parsedSection.toLowerCase();

    return OpportunityItemModel(
      id: parsedId,
      title: parsedTitle,
      description: parsedDesc,
      brand: parsedBrand,
      category: parsedCategory,
      section: parsedSection,
      location: parsedLocation,
      duration: parsedDuration,
      budgetDisplay: effectiveBudgetDisplay,
      budgetAmount: numBudget,
      roles: parsedRoles,
      imageUrl: parsedImage,
      isUrgent: json['isUrgent'] == true || secLower == 'high-priority',
      isBoosted: json['isBoosted'] == true || secLower == 'boosted',
      isFeatured: json['isFeatured'] == true || secLower == 'featured',
      isApplied: json['isApplied'] == true || json['hasApplied'] == true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'brand': brand,
      'category': category,
      'section': section,
      'location': location,
      'duration': duration,
      'budgetLabel': budgetDisplay,
      'budget': budgetAmount,
      'roles': roles,
      'imageUrl': imageUrl,
      'isUrgent': isUrgent,
      'isBoosted': isBoosted,
      'isFeatured': isFeatured,
      'isApplied': isApplied,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    };
  }

  OpportunityItemModel copyWith({
    String? id,
    String? title,
    String? description,
    String? brand,
    String? category,
    String? section,
    String? location,
    String? duration,
    String? budgetDisplay,
    double? budgetAmount,
    List<String>? roles,
    String? imageUrl,
    bool? isUrgent,
    bool? isBoosted,
    bool? isFeatured,
    bool? isApplied,
    DateTime? createdAt,
  }) {
    return OpportunityItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      section: section ?? this.section,
      location: location ?? this.location,
      duration: duration ?? this.duration,
      budgetDisplay: budgetDisplay ?? this.budgetDisplay,
      budgetAmount: budgetAmount ?? this.budgetAmount,
      roles: roles ?? this.roles,
      imageUrl: imageUrl ?? this.imageUrl,
      isUrgent: isUrgent ?? this.isUrgent,
      isBoosted: isBoosted ?? this.isBoosted,
      isFeatured: isFeatured ?? this.isFeatured,
      isApplied: isApplied ?? this.isApplied,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get hasValidImage {
    final trimmed = imageUrl.trim();
    return trimmed.isNotEmpty &&
        (trimmed.startsWith('http://') || trimmed.startsWith('https://'));
  }

  static String? _firstNonEmpty(List<dynamic> candidates) {
    for (final item in candidates) {
      if (item is String && item.trim().isNotEmpty) {
        return item.trim();
      }
    }
    return null;
  }

  static String _extractBrand(Map<String, dynamic> json) {
    final direct = _firstNonEmpty([
      json['brand'],
      json['brandName'],
      json['companyName'],
      json['clientName'],
      json['organization'],
    ]);
    if (direct != null) return direct.toUpperCase();

    final postedBy = json['postedBy'];
    if (postedBy is Map) {
      final nested = _firstNonEmpty([
        postedBy['brandName'],
        postedBy['companyName'],
        postedBy['fullName'],
        postedBy['name'],
      ]);
      if (nested != null) return nested.toUpperCase();
    }
    return 'VERIFIED BRAND';
  }

  static String _extractImageUrl(Map<String, dynamic> json) {
    final candidates = [
      json['imageUrl'],
      json['coverImage'],
      json['bannerImage'],
      json['cardDisplayImageUrl'],
      json['cardImage'],
      json['thumbnail'],
      json['image'],
    ];
    for (final c in candidates) {
      if (c is String && c.trim().isNotEmpty) return c.trim();
      if (c is Map) {
        final viewUrl = c['viewUrl']?.toString().trim() ?? '';
        if (viewUrl.isNotEmpty) return viewUrl;
      }
    }
    return '';
  }

  static List<String> _extractStringList(List<dynamic> candidates) {
    for (final c in candidates) {
      if (c is List && c.isNotEmpty) {
        final cleaned = c
            .map((e) => e.toString().trim())
            .where((s) => s.isNotEmpty)
            .toList();
        if (cleaned.isNotEmpty) return cleaned;
      }
    }
    return const <String>[];
  }

  static String _formatIndianCurrency(double value) {
    final intVal = value.round();
    final str = intVal.toString();
    if (str.length <= 3) return '₹$str';
    final lastThree = str.substring(str.length - 3);
    final rest = str.substring(0, str.length - 3);
    final formattedRest = rest.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{2})+$)'),
      (m) => '${m[1]},',
    );
    return '₹$formattedRest,$lastThree';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        brand,
        category,
        section,
        location,
        duration,
        budgetDisplay,
        budgetAmount,
        roles,
        imageUrl,
        isUrgent,
        isBoosted,
        isFeatured,
        isApplied,
        createdAt,
      ];
}
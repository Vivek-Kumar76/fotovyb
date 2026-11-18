import 'package:equatable/equatable.dart';
import '../../../../core/pagination/identifiable.dart';

class GigPackageTierItem extends Equatable {
  final String label;
  final String priceDisplay;
  final double amount;

  const GigPackageTierItem({
    required this.label,
    required this.priceDisplay,
    required this.amount,
  });

  factory GigPackageTierItem.fromJson(Map<String, dynamic> json) {
    final label = (json['label'] ?? json['name'] ?? 'Standard').toString().trim();
    final rawPrice = json['price'] ?? json['amount'] ?? 0;
    final amount = rawPrice is num
        ? rawPrice.toDouble()
        : double.tryParse(
              rawPrice.toString().replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;
    final priceDisplay = rawPrice is String && rawPrice.trim().startsWith('₹')
        ? rawPrice.trim()
        : GigItemModel.formatIndianCurrency(amount);

    return GigPackageTierItem(
      label: label.isEmpty ? 'Standard' : label,
      priceDisplay: priceDisplay,
      amount: amount,
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'price': amount,
      };

  @override
  List<Object?> get props => [label, priceDisplay, amount];
}

class GigSellerInfo extends Equatable {
  final String id;
  final String name;
  final String userName;
  final String avatar;
  final String role;
  final String badge;
  final String city;
  final double avgRating;
  final int totalReviews;

  const GigSellerInfo({
    required this.id,
    required this.name,
    required this.userName,
    required this.avatar,
    required this.role,
    required this.badge,
    required this.city,
    required this.avgRating,
    required this.totalReviews,
  });

  factory GigSellerInfo.fromJson(
    Map<String, dynamic>? json, {
    String fallbackBadge = 'Verified Pro',
  }) {
    if (json == null) {
      return GigSellerInfo(
        id: '',
        name: 'Creative Pro',
        userName: '',
        avatar: '',
        role: 'Creative',
        badge: fallbackBadge,
        city: 'India',
        avgRating: 0.0,
        totalReviews: 0,
      );
    }

    final parsedName = (json['name'] ?? json['fullName'] ?? 'Creative Pro')
        .toString()
        .trim();
    final parsedRole = (json['role'] ?? 'Creative').toString().trim();
    final parsedBadge = (json['badge'] ?? json['tier'] ?? '')
        .toString()
        .trim();

    return GigSellerInfo(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: parsedName.isEmpty ? 'Creative Pro' : parsedName,
      userName: (json['userName'] ?? '').toString().trim(),
      avatar: (json['avatar'] ?? json['profileImage'] ?? '').toString().trim(),
      role: parsedRole.isEmpty ? 'Creative' : parsedRole,
      badge: parsedBadge.isNotEmpty
          ? parsedBadge
          : (parsedRole.isNotEmpty ? parsedRole : fallbackBadge),
      city: (json['city'] ?? json['location'] ?? 'India').toString().trim(),
      avgRating: (json['avgRating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userName': userName,
        'avatar': avatar,
        'role': role,
        'badge': badge,
        'city': city,
        'avgRating': avgRating,
        'totalReviews': totalReviews,
      };

  bool get hasValidAvatar {
    final trimmed = avatar.trim();
    return trimmed.isNotEmpty &&
        (trimmed.startsWith('http://') || trimmed.startsWith('https://'));
  }

  String get initial => name.isNotEmpty ? name[0].toUpperCase() : 'P';

  @override
  List<Object?> get props => [
        id,
        name,
        userName,
        avatar,
        role,
        badge,
        city,
        avgRating,
        totalReviews,
      ];
}

class GigItemModel extends Equatable implements Identifiable {
  @override
  final String id;
  final String slug;
  final String title;
  final String description;
  final String category;
  final String subcategory;
  final List<String> tags;
  final double price;
  final double startingPrice;
  final String formattedPrice;
  final String coverImageUrl;
  final String activeSection;
  final String intendedSection;
  final String recognition;
  final bool featured;
  final double rating;
  final int reviewCount;
  final String deliveryTime;
  final GigSellerInfo professional;
  final List<GigPackageTierItem> packageTiers;
  final bool isFavorite;
  final DateTime? createdAt;

  const GigItemModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.tags,
    required this.price,
    required this.startingPrice,
    required this.formattedPrice,
    required this.coverImageUrl,
    required this.activeSection,
    required this.intendedSection,
    required this.recognition,
    required this.featured,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.professional,
    required this.packageTiers,
    this.isFavorite = false,
    this.createdAt,
  });

  factory GigItemModel.fromJson(
    Map<String, dynamic> json, {
    String fallbackSection = 'explore',
  }) {
    final parsedId =
        (json['id'] ?? json['_id'] ?? '').toString().trim();
    final parsedTitle =
        (json['title'] ?? 'Creative Service GIG').toString().trim();
    final parsedCategory =
        (json['category'] ?? 'Creative').toString().trim();
    final parsedSubcategory =
        (json['subcategory'] ?? '').toString().trim();

    final rawCoverUrl = (json['coverImageUrl'] ?? json['coverImage'] ?? '')
        .toString()
        .trim();

    final parsedPrice = (json['price'] as num?)?.toDouble() ??
        (json['startingPrice'] as num?)?.toDouble() ??
        0.0;
    final parsedStartingPrice = (json['startingPrice'] as num?)?.toDouble() ??
        parsedPrice;
    final effectiveBasePrice =
        parsedStartingPrice > 0 ? parsedStartingPrice : parsedPrice;

    final rawTags = json['tags'] as List<dynamic>? ?? const <dynamic>[];
    final parsedTags = rawTags
        .map((e) => e.toString().trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final parsedSection = (json['activeSection'] ??
            json['section'] ??
            fallbackSection)
        .toString()
        .trim();

    final rawTiers =
        json['packageTiers'] ?? json['tiers'] ?? const <dynamic>[];
    final parsedTiers = <GigPackageTierItem>[];
    if (rawTiers is List && rawTiers.isNotEmpty) {
      for (final item in rawTiers) {
        if (item is Map) {
          parsedTiers.add(
            GigPackageTierItem.fromJson(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    if (parsedTiers.isEmpty) {
      final base = effectiveBasePrice > 0 ? effectiveBasePrice : 2500.0;
      final standard = (base * 1.8).roundToDouble();
      final premium = (base * 3.2).roundToDouble();
      parsedTiers.addAll([
        GigPackageTierItem(
          label: 'Basic',
          priceDisplay: formatIndianCurrency(base),
          amount: base,
        ),
        GigPackageTierItem(
          label: 'Standard',
          priceDisplay: formatIndianCurrency(standard),
          amount: standard,
        ),
        GigPackageTierItem(
          label: 'Premium',
          priceDisplay: formatIndianCurrency(premium),
          amount: premium,
        ),
      ]);
    }

    final profMap = json['professional'] is Map
        ? Map<String, dynamic>.from(json['professional'] as Map)
        : null;

    final parsedRating = (json['rating'] as num?)?.toDouble() ??
        (profMap?['avgRating'] as num?)?.toDouble() ??
        0.0;
    final parsedReviews = (json['reviewCount'] as num?)?.toInt() ??
        (profMap?['totalReviews'] as num?)?.toInt() ??
        0;

    return GigItemModel(
      id: parsedId,
      slug: (json['slug'] ?? '').toString().trim(),
      title: parsedTitle.isEmpty ? 'Creative Service GIG' : parsedTitle,
      description: (json['description'] ?? '').toString().trim(),
      category: parsedCategory.isEmpty ? 'Creative' : parsedCategory,
      subcategory: parsedSubcategory,
      tags: parsedTags.isNotEmpty
          ? parsedTags
          : [
              if (parsedCategory.isNotEmpty) parsedCategory,
              if (parsedSubcategory.isNotEmpty &&
                  parsedSubcategory != parsedCategory)
                parsedSubcategory,
            ],
      price: parsedPrice,
      startingPrice: effectiveBasePrice,
      formattedPrice: effectiveBasePrice > 0
          ? formatIndianCurrency(effectiveBasePrice)
          : 'On Request',
      coverImageUrl: rawCoverUrl,
      activeSection: parsedSection,
      intendedSection:
          (json['intendedSection'] ?? parsedSection).toString().trim(),
      recognition: (json['recognition'] ?? parsedSection).toString().trim(),
      featured: json['featured'] == true || parsedSection == 'featured',
      rating: parsedRating,
      reviewCount: parsedReviews,
      deliveryTime: (json['deliveryTime'] ?? json['delivery'] ?? '2-3 days')
          .toString()
          .trim(),
      professional: GigSellerInfo.fromJson(profMap),
      packageTiers: parsedTiers,
      isFavorite: json['isFavorite'] == true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'slug': slug,
        'title': title,
        'description': description,
        'category': category,
        'subcategory': subcategory,
        'tags': tags,
        'price': price,
        'startingPrice': startingPrice,
        'coverImageUrl': coverImageUrl,
        'activeSection': activeSection,
        'intendedSection': intendedSection,
        'recognition': recognition,
        'featured': featured,
        'rating': rating,
        'reviewCount': reviewCount,
        'deliveryTime': deliveryTime,
        'professional': professional.toJson(),
        'packageTiers': packageTiers.map((t) => t.toJson()).toList(),
        'isFavorite': isFavorite,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      };

  GigItemModel copyWith({
    bool? isFavorite,
  }) {
    return GigItemModel(
      id: id,
      slug: slug,
      title: title,
      description: description,
      category: category,
      subcategory: subcategory,
      tags: tags,
      price: price,
      startingPrice: startingPrice,
      formattedPrice: formattedPrice,
      coverImageUrl: coverImageUrl,
      activeSection: activeSection,
      intendedSection: intendedSection,
      recognition: recognition,
      featured: featured,
      rating: rating,
      reviewCount: reviewCount,
      deliveryTime: deliveryTime,
      professional: professional,
      packageTiers: packageTiers,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt,
    );
  }

  bool get hasValidCover {
    final trimmed = coverImageUrl.trim();
    return trimmed.isNotEmpty &&
        (trimmed.startsWith('http://') || trimmed.startsWith('https://'));
  }

  String get ratingDisplay => rating > 0 ? rating.toStringAsFixed(1) : 'New';

  static String formatIndianCurrency(double value) {
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
        slug,
        title,
        description,
        category,
        subcategory,
        tags,
        price,
        startingPrice,
        formattedPrice,
        coverImageUrl,
        activeSection,
        intendedSection,
        recognition,
        featured,
        rating,
        reviewCount,
        deliveryTime,
        professional,
        packageTiers,
        isFavorite,
        createdAt,
      ];
}
import 'package:equatable/equatable.dart';
import '../../../../core/pagination/identifiable.dart';

class GigModel extends Equatable implements Identifiable {
  @override
  final String id;
  final String title;
  final String slug;
  final String category;
  final String subcategory;
  final num price;
  final num startingPrice;
  final String status;
  final bool featured;
  final String activeSection;
  final String promotionStatus;
  final String description;
  final List<String> tags;
  final String coverImageUrl;
  final String recognition;
  final double rating;
  final int reviewCount;
  final GigProfessional professional;
  final bool isFavorite;
  final String deliveryTime;

  const GigModel({
    required this.id,
    required this.title,
    this.slug = '',
    this.category = 'Creative',
    this.subcategory = '',
    this.price = 0,
    this.startingPrice = 0,
    this.status = 'published',
    this.featured = false,
    this.activeSection = '',
    this.promotionStatus = '',
    this.description = '',
    this.tags = const [],
    this.coverImageUrl = '',
    this.recognition = '',
    this.rating = 5.0,
    this.reviewCount = 0,
    required this.professional,
    this.isFavorite = false,
    this.deliveryTime = '1–2 days',
  });

  /// Formatted price with rupee symbol (e.g. "₹24,000")
  String get formattedPrice {
    final amount = startingPrice > 0 ? startingPrice : price;
    return '₹${amount.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  /// Package pricing tiers for the High Priority Card (Basic / Standard / Premium)[cite: 12]
  List<GigPackageTier> get packageTiers {
    final base = (startingPrice > 0 ? startingPrice : price).toDouble();
    return [
      GigPackageTier(
        label: 'Basic',
        price: '₹${base.toInt()}',
        duration: '1-2 days',
      ),
      GigPackageTier(
        label: 'Standard',
        price: '₹${(base * 2.2).toInt()}',
        duration: '3-4 days',
      ),
      GigPackageTier(
        label: 'Premium',
        price: '₹${(base * 4.5).toInt()}',
        duration: '5-7 days',
      ),
    ];
  }

  factory GigModel.fromJson(Map<String, dynamic> json) {
    final profJson = json['professional'] as Map<String, dynamic>? ?? {};
    final rawTags = json['tags'] as List<dynamic>? ?? [];

    return GigModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Creative',
      subcategory: json['subcategory']?.toString() ?? '',
      price: json['price'] as num? ?? 0,
      startingPrice: json['startingPrice'] as num? ?? json['price'] as num? ?? 0,
      status: json['status']?.toString() ?? 'published',
      featured: json['featured'] == true,
      activeSection: json['activeSection']?.toString() ?? '',
      promotionStatus: json['promotionStatus']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      tags: rawTags.map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList(),
      coverImageUrl: json['coverImageUrl']?.toString() ??
          json['coverImage']?.toString() ??
          '',
      recognition: json['recognition']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ??
          (profJson['avgRating'] as num?)?.toDouble() ??
          5.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ??
          (profJson['totalReviews'] as num?)?.toInt() ??
          0,
      professional: GigProfessional.fromJson(profJson),
      isFavorite: json['isFavorite'] == true || json['is_favorite'] == true,
      deliveryTime: json['deliveryTime']?.toString() ?? '1–2 days',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'category': category,
      'subcategory': subcategory,
      'price': price,
      'startingPrice': startingPrice,
      'status': status,
      'featured': featured,
      'activeSection': activeSection,
      'promotionStatus': promotionStatus,
      'description': description,
      'tags': tags,
      'coverImageUrl': coverImageUrl,
      'recognition': recognition,
      'rating': rating,
      'reviewCount': reviewCount,
      'professional': professional.toJson(),
      'isFavorite': isFavorite,
      'deliveryTime': deliveryTime,
    };
  }

  GigModel copyWith({
    String? id,
    String? title,
    String? slug,
    String? category,
    String? subcategory,
    num? price,
    num? startingPrice,
    bool? featured,
    String? activeSection,
    String? promotionStatus,
    String? description,
    List<String>? tags,
    String? coverImageUrl,
    String? recognition,
    double? rating,
    int? reviewCount,
    GigProfessional? professional,
    bool? isFavorite,
    String? deliveryTime,
  }) {
    return GigModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      price: price ?? this.price,
      startingPrice: startingPrice ?? this.startingPrice,
      featured: featured ?? this.featured,
      activeSection: activeSection ?? this.activeSection,
      promotionStatus: promotionStatus ?? this.promotionStatus,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      recognition: recognition ?? this.recognition,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      professional: professional ?? this.professional,
      isFavorite: isFavorite ?? this.isFavorite,
      deliveryTime: deliveryTime ?? this.deliveryTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        category,
        subcategory,
        price,
        startingPrice,
        featured,
        activeSection,
        promotionStatus,
        description,
        tags,
        coverImageUrl,
        recognition,
        rating,
        reviewCount,
        professional,
        isFavorite,
        deliveryTime,
      ];
}

class GigProfessional extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final double avgRating;
  final int totalReviews;
  final String badge;
  final String city;

  const GigProfessional({
    this.id = '',
    this.name = 'Creative Pro',
    this.avatar = '',
    this.avgRating = 5.0,
    this.totalReviews = 0,
    this.badge = 'Rising Star',
    this.city = 'Bangalore',
  });

  factory GigProfessional.fromJson(Map<String, dynamic> json) {
    return GigProfessional(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Creative Pro',
      avatar: json['avatar']?.toString() ?? '',
      avgRating: (json['avgRating'] as num?)?.toDouble() ?? 5.0,
      totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
      badge: json['badge']?.toString() ?? 'Rising Star',
      city: json['city']?.toString() ?? 'Bangalore',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'avgRating': avgRating,
      'totalReviews': totalReviews,
      'badge': badge,
      'city': city,
    };
  }

  @override
  List<Object?> get props => [id, name, avatar, avgRating, totalReviews, badge, city];
}

class GigPackageTier extends Equatable {
  final String label;
  final String price;
  final String duration;

  const GigPackageTier({
    required this.label,
    required this.price,
    required this.duration,
  });

  @override
  List<Object?> get props => [label, price, duration];
}
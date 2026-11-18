import 'package:equatable/equatable.dart';
import '../../../../core/pagination/identifiable.dart';

class CreativeProModel extends Equatable implements Identifiable {
  @override
  final String id;
  final String userId;
  final String userName;
  final String fullName;
  final String role;
  final String location;
  final String experience;
  final int experienceYears;
  final String startingPrice;
  final List<String> subCategories;
  final List<String> industries;
  final List<String> skills;
  final double rating;
  final int totalReviews;
  final int projectCount;
  final bool isAvailable;
  final bool isFeatured;
  final bool isFavourite;
  final String avatar;
  final String coverImage;
  final String cardDisplayImageUrl;
  final String recognition;

  const CreativeProModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.fullName,
    required this.role,
    required this.location,
    required this.experience,
    required this.experienceYears,
    required this.startingPrice,
    required this.subCategories,
    required this.industries,
    required this.skills,
    required this.rating,
    required this.totalReviews,
    required this.projectCount,
    required this.isAvailable,
    required this.isFeatured,
    required this.isFavourite,
    required this.avatar,
    required this.coverImage,
    required this.cardDisplayImageUrl,
    required this.recognition,
  });

  factory CreativeProModel.fromJson(Map<String, dynamic> json) {
    final rawName = (json['fullName']?.toString().trim().isNotEmpty ?? false)
        ? json['fullName'].toString().trim()
        : (json['name']?.toString().trim().isNotEmpty ?? false)
            ? json['name'].toString().trim()
            : (json['userName']?.toString().trim().isNotEmpty ?? false)
                ? json['userName'].toString().trim()
                : 'Creative Artist';

    final subCats = (json['subCategory'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .where((s) => s.trim().isNotEmpty)
            .toList() ??
        [];

    final rawRole = json['role']?.toString().trim() ?? '';
    final effectiveRole = rawRole.isNotEmpty
        ? rawRole
        : (subCats.isNotEmpty
            ? subCats.first
            : (json['industryCategory']?.toString().trim().isNotEmpty ?? false)
                ? json['industryCategory'].toString().trim()
                : 'Creative Professional');

    final indList = (json['industries'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .where((s) => s.trim().isNotEmpty)
            .toList() ??
        [];

    final skillList = (json['skills'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .where((s) => s.trim().isNotEmpty)
            .toList() ??
        [];

    final effectiveSkills = skillList.isNotEmpty
        ? skillList
        : (subCats.length > 1 ? subCats.sublist(1) : <String>[]);

    final rawRating = json['rating'] ?? json['avgRating'];
    final parsedRating = (rawRating is num) ? rawRating.toDouble() : 0.0;

    final rawReviews = json['totalReviews'] ?? json['reviewCount'];
    final parsedReviews = (rawReviews is num) ? rawReviews.toInt() : 0;

    final rawYears = json['experienceYears'];
    final parsedYears = (rawYears is num) ? rawYears.toInt() : 0;

    final rawProjects = json['projectCount'];
    final parsedProjects = (rawProjects is num) ? rawProjects.toInt() : 0;

    return CreativeProModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      userName: json['userName']?.toString() ?? '',
      fullName: rawName,
      role: effectiveRole,
      location: (json['location']?.toString().trim().isNotEmpty ?? false)
          ? json['location'].toString().trim()
          : 'Mumbai',
      experience: json['experience']?.toString().trim() ?? '',
      experienceYears: parsedYears,
      startingPrice: json['startingPrice']?.toString().trim() ?? '',
      subCategories: subCats,
      industries: indList,
      skills: effectiveSkills,
      rating: parsedRating,
      totalReviews: parsedReviews,
      projectCount: parsedProjects,
      isAvailable: json['isAvailable'] == true || json['availability'] == 'Available',
      isFeatured: json['featured'] == true,
      isFavourite: json['isFavourite'] == true || json['isFavourited'] == true,
      avatar: json['avatar']?.toString().trim() ?? '',
      coverImage: json['coverImage']?.toString().trim() ?? '',
      cardDisplayImageUrl: json['cardDisplayImageUrl']?.toString().trim() ??
          json['cardImage']?.toString().trim() ??
          '',
      recognition: json['recognition']?.toString().trim() ?? 'creative',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'fullName': fullName,
      'role': role,
      'location': location,
      'experience': experience,
      'experienceYears': experienceYears,
      'startingPrice': startingPrice,
      'subCategory': subCategories,
      'industries': industries,
      'skills': skills,
      'rating': rating,
      'totalReviews': totalReviews,
      'projectCount': projectCount,
      'isAvailable': isAvailable,
      'featured': isFeatured,
      'isFavourite': isFavourite,
      'avatar': avatar,
      'coverImage': coverImage,
      'cardDisplayImageUrl': cardDisplayImageUrl,
      'recognition': recognition,
    };
  }

  CreativeProModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? fullName,
    String? role,
    String? location,
    String? experience,
    int? experienceYears,
    String? startingPrice,
    List<String>? subCategories,
    List<String>? industries,
    List<String>? skills,
    double? rating,
    int? totalReviews,
    int? projectCount,
    bool? isAvailable,
    bool? isFeatured,
    bool? isFavourite,
    String? avatar,
    String? coverImage,
    String? cardDisplayImageUrl,
    String? recognition,
  }) {
    return CreativeProModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      location: location ?? this.location,
      experience: experience ?? this.experience,
      experienceYears: experienceYears ?? this.experienceYears,
      startingPrice: startingPrice ?? this.startingPrice,
      subCategories: subCategories ?? this.subCategories,
      industries: industries ?? this.industries,
      skills: skills ?? this.skills,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      projectCount: projectCount ?? this.projectCount,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      isFavourite: isFavourite ?? this.isFavourite,
      avatar: avatar ?? this.avatar,
      coverImage: coverImage ?? this.coverImage,
      cardDisplayImageUrl: cardDisplayImageUrl ?? this.cardDisplayImageUrl,
      recognition: recognition ?? this.recognition,
    );
  }

  String get formattedPrice {
    if (startingPrice.isEmpty) return "Custom";
    return startingPrice.startsWith("₹") ? startingPrice : "₹$startingPrice";
  }

  String get experienceSubtitle {
    if (experienceYears > 0) return "$location • $experienceYears yrs";
    if (experience.isNotEmpty) return "$location • $experience";
    return location;
  }

  String get ratingDisplay => rating > 0 ? rating.toStringAsFixed(1) : "New";

  bool get isTopRated => rating >= 4.5 || isFeatured;

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        fullName,
        role,
        location,
        experience,
        experienceYears,
        startingPrice,
        subCategories,
        industries,
        skills,
        rating,
        totalReviews,
        projectCount,
        isAvailable,
        isFeatured,
        isFavourite,
        avatar,
        coverImage,
        cardDisplayImageUrl,
        recognition,
      ];
}
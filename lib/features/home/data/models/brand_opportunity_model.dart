import 'package:equatable/equatable.dart';
import '../../../../core/pagination/identifiable.dart';

class BrandOpportunityModel extends Equatable implements Identifiable {
  @override
  final String id;
  final String title;
  final String brand;
  final String brandLogo;
  final String location;
  final String budget;
  final String description;
  final List<String> roles;
  final String timeRemaining;
  final bool urgent;
  final String visibilityTier;
  final bool isSaved;

  const BrandOpportunityModel({
    required this.id,
    required this.title,
    required this.brand,
    this.brandLogo = '',
    this.location = 'Remote',
    this.budget = 'Negotiable',
    this.description = '',
    this.roles = const [],
    this.timeRemaining = '',
    this.urgent = false,
    this.visibilityTier = 'high_priority',
    this.isSaved = false,
  });

  factory BrandOpportunityModel.fromJson(Map<String, dynamic> json) {
    return BrandOpportunityModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      brand: json['brand']?.toString() ?? 'Brand',
      brandLogo: json['brandLogo']?.toString() ?? '',
      location: json['location']?.toString() ?? 'Remote',
      budget: json['budget']?.toString() ?? 'Negotiable',
      description: json['description']?.toString() ?? '',
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => e.toString().trim())
              .where((e) => e.isNotEmpty)
              .toList() ??
          const [],
      timeRemaining: json['timeRemaining']?.toString() ?? '',
      urgent: json['urgent'] == true,
      visibilityTier: json['visibilityTier']?.toString() ??
          json['recognition']?.toString() ??
          'high_priority',
      isSaved: json['isSaved'] == true || json['is_saved'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'brand': brand,
      'brandLogo': brandLogo,
      'location': location,
      'budget': budget,
      'description': description,
      'roles': roles,
      'timeRemaining': timeRemaining,
      'urgent': urgent,
      'visibilityTier': visibilityTier,
      'isSaved': isSaved,
    };
  }

  BrandOpportunityModel copyWith({
    String? id,
    String? title,
    String? brand,
    String? brandLogo,
    String? location,
    String? budget,
    String? description,
    List<String>? roles,
    String? timeRemaining,
    bool? urgent,
    String? visibilityTier,
    bool? isSaved,
  }) {
    return BrandOpportunityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      brand: brand ?? this.brand,
      brandLogo: brandLogo ?? this.brandLogo,
      location: location ?? this.location,
      budget: budget ?? this.budget,
      description: description ?? this.description,
      roles: roles ?? this.roles,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      urgent: urgent ?? this.urgent,
      visibilityTier: visibilityTier ?? this.visibilityTier,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        brand,
        brandLogo,
        location,
        budget,
        description,
        roles,
        timeRemaining,
        urgent,
        visibilityTier,
        isSaved,
      ];
}
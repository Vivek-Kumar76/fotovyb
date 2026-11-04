import 'package:flutter/material.dart';

class SubscriptionPlan {
  final String id;
  final String name;
  final int price;
  final String duration;
  final String? tag;
  final Color? tagColor;
  final String description;
  final List<String> includedFeatures;
  final List<String> excludedFeatures;
  final String support;
  final String gigAddonQuota;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    this.tag,
    this.tagColor,
    required this.description,
    required this.includedFeatures,
    this.excludedFeatures = const [],
    required this.support,
    required this.gigAddonQuota,
  });
}

class SubscriptionAddon {
  final String id;
  final String title;
  final String subtitle;
  final int price;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  bool isSelected;

  SubscriptionAddon({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.isSelected = false,
  });
}
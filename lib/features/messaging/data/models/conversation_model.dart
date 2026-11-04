import 'package:flutter/material.dart';

enum ConversationTag { gigOrder, collab, brief }

class ConversationModel {
  final String id;
  final String name;
  final String avatar;
  final String subtitle;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final ConversationTag tag;
  final bool isSelected;

  const ConversationModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.subtitle,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    required this.tag,
    this.isSelected = false,
  });

  String get tagLabel {
    switch (tag) {
      case ConversationTag.gigOrder:
        return "GIG Order";
      case ConversationTag.collab:
        return "Collab";
      case ConversationTag.brief:
        return "Brief";
    }
  }

  Color get tagColor {
    switch (tag) {
      case ConversationTag.gigOrder:
        return const Color(0xff0D9488); // Teal
      case ConversationTag.collab:
        return const Color(0xff8B5CF6); // Purple
      case ConversationTag.brief:
        return const Color(0xffD97706); // Amber
    }
  }
}
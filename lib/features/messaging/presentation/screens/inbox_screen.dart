import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/conversation_model.dart';
import '../widgets/conversation_tile.dart';
import 'chat_room_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  int _selectedFilterIndex = 0;

  final List<Map<String, dynamic>> _filters = const [
    {"label": "All", "count": 12},
    {"label": "Brands", "count": 7},
    {"label": "Creatives", "count": 3},
    {"label": "GIG Orders", "count": null},
  ];

  final List<ConversationModel> _conversations = const [
    ConversationModel(
      id: "1",
      name: "Rahul Sharma",
      avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80",
      subtitle: "Volta Motors",
      lastMessage: "We loved your portfolio! Can we discuss the E...",
      time: "2m ago",
      unreadCount: 3,
      isOnline: true,
      tag: ConversationTag.gigOrder,
      isSelected: true,
    ),
    ConversationModel(
      id: "2",
      name: "Mei Lin",
      avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80",
      subtitle: "Fashion Stylist",
      lastMessage: "Hey! Open for collab on the Vogue shoot next ...",
      time: "18m ago",
      unreadCount: 1,
      isOnline: true,
      tag: ConversationTag.collab,
    ),
    ConversationModel(
      id: "3",
      name: "Ananya Gupta",
      avatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=150&q=80",
      subtitle: "Vogue India",
      lastMessage: "Confirmed! Please send the invoice for the February ...",
      time: "1h ago",
      isOnline: false,
      tag: ConversationTag.brief,
    ),
    ConversationModel(
      id: "4",
      name: "Kofi Mensah",
      avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80",
      subtitle: "Photographer",
      lastMessage: "Just sent the edited shots — check folder. Let me kn...",
      time: "3h ago",
      isOnline: true,
      tag: ConversationTag.gigOrder,
    ),
    ConversationModel(
      id: "5",
      name: "Samir Nair",
      avatar: "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?auto=format&fit=crop&w=150&q=80",
      subtitle: "Lumière Hotels",
      lastMessage: "Can you share your availability for the Goa property ...",
      time: "Yesterday",
      isOnline: false,
      tag: ConversationTag.brief,
    ),
    ConversationModel(
      id: "6",
      name: "Sofia Reyes",
      avatar: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=150&q=80",
      subtitle: "Art Director",
      lastMessage: "The storyboards are done! Sending you the PDF right...",
      time: "Yesterday",
      isOnline: false,
      tag: ConversationTag.collab,
    ),
    ConversationModel(
      id: "7",
      name: "Divya Khanna",
      avatar: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=150&q=80",
      subtitle: "FreshBlend Co.",
      lastMessage: "Perfect! Approved the reels. Can we do 5 more next ...",
      time: "Mon",
      isOnline: false,
      tag: ConversationTag.gigOrder,
    ),
    ConversationModel(
      id: "8",
      name: "Marco Bianchi",
      avatar: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=150&q=80",
      subtitle: "Model",
      lastMessage: "Definitely in for the editorial. What is the call time?",
      time: "Sun",
      isOnline: true,
      tag: ConversationTag.collab,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      appBar: AppBar(
        titleSpacing: 16,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              "FOTOVYB",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                color: isDark ? Colors.white70 : const Color(0xff0F172A),
              ),
            ),
            const SizedBox(width: 8),
            Container(width: 1, height: 16, color: borderColor),
            const SizedBox(width: 8),
            Text(
              "Inbox",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit_square, size: 20),
            onPressed: () {},
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips Horizontal Scroll
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = _selectedFilterIndex == index;
                final filter = _filters[index];
                final count = filter['count'];

                return GestureDetector(
                  onTap: () => setState(() => _selectedFilterIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff134E4A)
                          : (isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9)),
                      borderRadius: AppRadius.radiusFull,
                    ),
                    child: Row(
                      children: [
                        Text(
                          filter['label'] as String,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? Colors.white : textColor,
                          ),
                        ),
                        if (count != null) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xff0D9488) : const Color(0xff0F766E),
                              borderRadius: AppRadius.radiusFull,
                            ),
                            child: Text(
                              "$count",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 6),
          Divider(height: 1, color: borderColor),

          // Conversation List
          Expanded(
            child: ListView.separated(
              itemCount: _conversations.length,
              separatorBuilder: (_, __) => Divider(height: 1, color: borderColor, indent: 70),
              itemBuilder: (context, index) {
                final conv = _conversations[index];
                return ConversationTile(
                  conversation: conv,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatRoomScreen(conversation: conv),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
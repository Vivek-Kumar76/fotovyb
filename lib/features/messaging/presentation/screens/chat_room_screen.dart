import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/conversation_model.dart';
import '../../data/models/message_model.dart';
import '../widgets/gig_deal_banner.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/quick_action_chips.dart';
import '../widgets/chat_input_bar.dart';

class ChatRoomScreen extends StatefulWidget {
  final ConversationModel conversation;

  const ChatRoomScreen({super.key, required this.conversation});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _msgCtrl = TextEditingController();

  final List<MessageModel> _messages = [
    const MessageModel(
      id: "1",
      senderName: "Rahul Sharma",
      senderAvatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80",
      text: "Hi! I am Rahul from Volta Motors. We came across your profile on FOTOVYB and were really impressed by your automotive campaign work.",
      time: "10:02 AM",
      isMe: false,
    ),
    const MessageModel(
      id: "2",
      senderName: "Rahul Sharma",
      senderAvatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80",
      text: "We are looking for a photographer and stylist team for a 3-day EV campaign shoot in Bangalore.",
      time: "10:03 AM",
      isMe: false,
    ),
    const MessageModel(
      id: "3",
      senderName: "Kofi Mensah",
      senderAvatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80",
      text: "Hi Rahul! Thanks so much. Would love to hear more — what is the creative vision for the shoot?",
      time: "10:15 AM",
      isMe: true,
    ),
    const MessageModel(
      id: "4",
      senderName: "Rahul Sharma",
      senderAvatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80",
      text: "Cinematic editorial feel — clean studio and outdoor. Car as the hero, fashion-forward styling. Budget is 85,000 for the full shoot.",
      time: "10:18 AM",
      isMe: false,
    ),
    const MessageModel(
      id: "5",
      senderName: "Kofi Mensah",
      senderAvatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80",
      text: "That sounds amazing! Cinematic editorial is my forte. Sending over my portfolio with automotive campaign references:",
      time: "10:22 AM",
      isMe: true,
      attachment: FileAttachment(
        fileName: "Campaign Portfolio — Kofi Mensah.pdf",
        fileSize: "3.4 MB",
        fileType: "pdf",
      ),
    ),
    const MessageModel(
      id: "6",
      senderName: "Rahul Sharma",
      senderAvatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80",
      text: "We loved your portfolio! Can we discuss the EV campaign shoot dates?",
      time: "10:31 AM",
      isMe: false,
    ),
  ];

  void _sendMessage([String? customText]) {
    final text = customText ?? _msgCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderName: "Kofi Mensah",
          senderAvatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80",
          text: text,
          time: "Just now",
          isMe: true,
        ),
      );
    });
    _msgCtrl.clear();
  }

  @override
  void dispose() {
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDark ? AppColors.textSecondaryDark : const Color(0xff64748B);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(widget.conversation.avatar),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xff10B981),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.conversation.name,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xff0D9488),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "GIG Order",
                          style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "${widget.conversation.subtitle} · 🟢 Online",
                    style: TextStyle(fontSize: 10.5, color: textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, size: 20),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // Pinned Deal Banner
          GigDealBanner(
            title: "Cinematic Fashion & Editorial Pho...",
            status: "In Discussion",
            price: "₹85,000",
            date: "March 15, 2026",
            onAcceptTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Deal accepted! Generating contract..."),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),

          // Date Separator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Today, Jan 28",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: textSecondary,
              ),
            ),
          ),

          // Message Stream
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),

          // Quick Suggested Prompts
          QuickActionChips(
            onChipSelected: (prompt) => _sendMessage(prompt),
          ),

          // Input Bar
          ChatInputBar(
            controller: _msgCtrl,
            onSend: () => _sendMessage(),
          ),
        ],
      ),
    );
  }
}
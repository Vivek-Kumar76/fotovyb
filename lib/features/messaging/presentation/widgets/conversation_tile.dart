import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/conversation_model.dart';

class ConversationTile extends StatelessWidget {
  final ConversationModel conversation;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textMuted = isDark ? AppColors.textMutedDark : const Color(0xff64748B);
    final tileBg = conversation.isSelected
        ? (isDark ? const Color(0xff064E3B).withValues(alpha: 0.25) : const Color(0xffF0FDF4))
        : Colors.transparent;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: tileBg,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Active Indicator Line
              Container(
                width: 3.5,
                color: conversation.isSelected ? AppColors.primary : Colors.transparent,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar + Status Dot
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(conversation.avatar),
                          ),
                          if (conversation.isOnline)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: const Color(0xff10B981),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDark ? AppColors.surfaceDark : Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),

                      // Content Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    conversation.name,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  conversation.time,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: 11,
                                    color: textMuted,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                  decoration: BoxDecoration(
                                    color: conversation.tagColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    conversation.tagLabel,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    conversation.subtitle,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: 12,
                                      color: textMuted,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    conversation.lastMessage,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: 12.5,
                                      fontWeight: conversation.unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
                                      color: conversation.unreadCount > 0 ? textColor : textMuted,
                                    ),
                                  ),
                                ),
                                if (conversation.unreadCount > 0)
                                  Container(
                                    margin: const EdgeInsets.only(left: 6),
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff0D9488),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "${conversation.unreadCount}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
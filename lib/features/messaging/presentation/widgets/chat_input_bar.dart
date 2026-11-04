import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final barBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    return Container(
      decoration: BoxDecoration(
        color: barBg,
        border: Border(top: BorderSide(color: borderColor, width: 1)),
      ),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Attach File Button
            IconButton(
              icon: const Icon(Icons.attach_file_rounded, color: Color(0xff64748B), size: 22),
              onPressed: () {},
            ),
            // Media Gallery Button
            IconButton(
              icon: const Icon(Icons.image_outlined, color: Color(0xff64748B), size: 22),
              onPressed: () {},
            ),
            // Text Input Pill
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC),
                  borderRadius: AppRadius.radiusFull,
                  border: Border.all(color: borderColor),
                ),
                child: TextField(
                  controller: controller,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 13,
                    color: textColor,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xff94A3B8)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Send Circular Button
            GestureDetector(
              onTap: onSend,
              child: Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xff164E54),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
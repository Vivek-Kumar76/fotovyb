import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class QuickActionChips extends StatelessWidget {
  final ValueChanged<String> onChipSelected;

  const QuickActionChips({super.key, required this.onChipSelected});

  final List<String> _actions = const [
    "Schedule a call",
    "Available this week",
    "Send more details",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final textColor = isDark ? AppColors.textPrimaryDark : const Color(0xff0F172A);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        children: _actions.map((act) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onChipSelected(act),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: AppRadius.radiusFull,
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome, size: 13, color: Color(0xff0D9488)),
                    const SizedBox(width: 6),
                    Text(
                      act,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
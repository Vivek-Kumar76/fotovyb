import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigPricingTabs extends StatelessWidget {
  final List<Map<String, dynamic>> tiers;
  final int selectedIndex;
  final ValueChanged<int> onTierSelected;

  const GigPricingTabs({
    super.key,
    required this.tiers,
    required this.selectedIndex,
    required this.onTierSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color activeTabBg = isDark ? const Color(0xff064E3B).withValues(alpha: 0.35) : const Color(0xffE6F7EF);

    final currentTier = tiers[selectedIndex];
    final List<String> features = List<String>.from(currentTier['features'] as List);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Segmented 3-Button Tier Switcher
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9),
              borderRadius: AppRadius.radiusFull,
            ),
            child: Row(
              children: List.generate(tiers.length, (index) {
                final isSelected = selectedIndex == index;
                final tier = tiers[index];
                final isPopular = tier['isPopular'] == true;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTierSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? (isDark ? AppColors.surfaceDark : Colors.white) : Colors.transparent,
                        borderRadius: AppRadius.radiusFull,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tier['name'] as String,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                              color: isSelected ? AppColors.primary : textSecondary,
                            ),
                          ),
                          if (isPopular) ...[
                            const SizedBox(width: 4),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xffD97706),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),

          // Active Package Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: isDark ? AppColors.primary.withValues(alpha: 0.3) : borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentTier['price'] as String,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: activeTabBg,
                        borderRadius: AppRadius.radiusFull,
                      ),
                      child: Text(
                        "${currentTier['name']} Package",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  currentTier['subtitle'] as String,
                  style: TextStyle(fontSize: 12, color: textSecondary),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),

                // Deliveries and revisions pill row
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule_outlined, size: 14, color: textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          currentTier['delivery'] as String,
                          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: textColor),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(Icons.refresh_rounded, size: 14, color: textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          currentTier['revisions'] as String,
                          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: textColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Checklist
                ...features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(fontSize: 12.5, color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
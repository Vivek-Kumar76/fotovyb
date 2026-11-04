import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/subscription_plan_model.dart';

class SubscriptionAddonsSection extends StatelessWidget {
  final List<SubscriptionAddon> addons;
  final ValueChanged<String> onToggleAddon;

  const SubscriptionAddonsSection({
    super.key,
    required this.addons,
    required this.onToggleAddon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);
    final textSecondary = isDark ? AppColors.textSecondaryDark : const Color(0xff64748B);
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Title (Protected with Expanded against narrow-screen overflow)
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xffD97706),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.stars_rounded, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Creative Add-ons",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    Text(
                      "Boost visibility & unlock limits whenever you need",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 11,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Addon Cards List (68% / 32% Flex Partitioning)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addons.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (ctx, idx) {
              final addon = addons[idx];

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: addon.isSelected
                        ? const Color(0xff0D9488)
                        : borderColor,
                    width: addon.isSelected ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: addon.isSelected
                          ? const Color(0xff0D9488).withValues(alpha: 0.08)
                          : Colors.black.withValues(alpha: 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Icon
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: addon.iconBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(addon.icon, color: addon.iconColor, size: 19),
                    ),
                    const SizedBox(width: 10),

                    // Details (68% Flex Allocation)
                    Expanded(
                      flex: 68,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Price (65% / 35% Inner Flex Allocation)
                          Row(
                            children: [
                              Expanded(
                                flex: 65,
                                child: Text(
                                  addon.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w800,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                flex: 35,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "+ ₹${addon.price}",
                                    style: const TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xff0D9488),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            addon.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 10.5,
                              height: 1.25,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Toggle Button (32% Flex Allocation with FittedBox Guard)
                    Expanded(
                      flex: 32,
                      child: GestureDetector(
                        onTap: () => onToggleAddon(addon.id),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: addon.isSelected
                                ? AppColors.buttonGradientCreative
                                : null,
                            color: addon.isSelected
                                ? null
                                : const Color(0xffE6F4F1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                addon.isSelected ? "Added ✓" : "+ Add",
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w800,
                                  color: addon.isSelected
                                      ? Colors.white
                                      : const Color(0xff0D9488),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/subscription_plan_model.dart';

class SubscriptionTiersSection extends StatelessWidget {
  final List<SubscriptionPlan> plans;
  final String selectedPlanId;
  final int addonsTotal;
  final ValueChanged<String> onPlanSelected;
  final VoidCallback onProceed;

  const SubscriptionTiersSection({
    super.key,
    required this.plans,
    required this.selectedPlanId,
    required this.addonsTotal,
    required this.onPlanSelected,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: plans.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (ctx, index) {
        final plan = plans[index];
        final isSelected = selectedPlanId == plan.id;

        return _ZoomablePlanCard(
          plan: plan,
          isSelected: isSelected,
          addonsTotal: addonsTotal,
          onTap: () => onPlanSelected(plan.id),
          onProceed: onProceed,
        );
      },
    );
  }
}

class _ZoomablePlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isSelected;
  final int addonsTotal;
  final VoidCallback onTap;
  final VoidCallback onProceed;

  const _ZoomablePlanCard({
    required this.plan,
    required this.isSelected,
    required this.addonsTotal,
    required this.onTap,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);
    final textSecondary = isDark ? AppColors.textSecondaryDark : const Color(0xff64748B);

    // ── Crisp White Interior with High-Definition Teal Accent
    final BoxDecoration cardDecoration = isSelected
        ? BoxDecoration(
            color: isDark ? const Color(0xff13232C) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xff0D9488),
              width: 2.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff0D9488).withValues(alpha: 0.16),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          )
        : BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isDark ? AppColors.borderDark : const Color(0xffE2E8F0),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          );

    final dynamicPrice = isSelected ? (plan.price + addonsTotal) : plan.price;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.02 : 0.985,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: cardDecoration,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Top Ribbon
              if (plan.tag != null || isSelected)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.buttonGradientCreative : null,
                    color: isSelected ? null : (plan.tagColor ?? const Color(0xffD97706)),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 60,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected) ...[
                              const Icon(Icons.check_circle_rounded, size: 12, color: Colors.white),
                              const SizedBox(width: 4),
                            ],
                            Flexible(
                              child: Text(
                                isSelected ? "SELECTED PLAN" : (plan.tag ?? ""),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (isSelected && addonsTotal > 0)
                        Flexible(
                          flex: 40,
                          child: Text(
                            "+ ₹$addonsTotal Add-ons",
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

              // ── Plan Content Body
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header Row (62% Left / 38% Right Responsive Split)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 62,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plan.name,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: isSelected ? const Color(0xff0D9488) : textColor,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                plan.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 11,
                                  height: 1.3,
                                  color: textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          flex: 38,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerRight,
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      color: isSelected ? const Color(0xff0F766E) : textColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "₹$dynamicPrice",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: -0.5,
                                          color: isSelected ? const Color(0xff0D9488) : textColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " / ${plan.duration}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: textSecondary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (isSelected && addonsTotal > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerRight,
                                    child: const Text(
                                      "Base + Add-ons Active",
                                      style: TextStyle(
                                        fontFamily: AppTypography.fontFamilySans,
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff0D9488),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Divider(
                      height: 1,
                      color: isSelected
                          ? const Color(0xff0D9488).withValues(alpha: 0.25)
                          : const Color(0xffF1F5F9),
                    ),
                    const SizedBox(height: 12),

                    // ── Features List
                    ...plan.includedFeatures.map((feat) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.check_circle_rounded,
                                size: 14,
                                color: isSelected
                                    ? const Color(0xff0D9488)
                                    : const Color(0xff10B981),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feat,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 11.5,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                  color: textColor,
                                  height: 1.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    ...plan.excludedFeatures.map((feat) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.remove_circle_outline_rounded,
                                size: 14,
                                color: Color(0xffCBD5E1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feat,
                                style: const TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 11.5,
                                  color: Color(0xff94A3B8),
                                  height: 1.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 4),

                    // ── Badges
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _buildBadge(
                          "Support: ${plan.support}",
                          isSelected ? const Color(0xffCCFBF1) : const Color(0xffE6F4F1),
                          const Color(0xff0F766E),
                        ),
                        _buildBadge(
                          "Addon Quota: ${plan.gigAddonQuota}",
                          const Color(0xffFEF3C7),
                          const Color(0xffB45309),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ── Button
                    GestureDetector(
                      onTap: () {
                        onTap();
                        onProceed();
                      },
                      child: Container(
                        height: 42,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: isSelected ? AppColors.buttonGradientCreative : null,
                          color: isSelected
                              ? null
                              : (isDark ? const Color(0xff1E293B) : const Color(0xffF1F5F9)),
                          borderRadius: BorderRadius.circular(22),
                          border: isSelected
                              ? null
                              : Border.all(color: const Color(0xffCBD5E1)),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xff0D9488).withValues(alpha: 0.35),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          plan.price == 0
                              ? "Continue Free"
                              : (isSelected
                                  ? "Get Started — ₹$dynamicPrice"
                                  : "Choose ${plan.name} (₹${plan.price})"),
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: isSelected ? Colors.white : textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: textCol,
        ),
      ),
    );
  }
}
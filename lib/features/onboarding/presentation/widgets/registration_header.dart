import 'package:flutter/material.dart';
import 'package:p1/core/tokens/tokens.dart';

class RegistrationHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepNames;
  final String categoryTag;
  final String title;
  final String subtitle;
  final String? badgeText;
  final IconData? badgeIcon;
  final bool showDoThisLater;
  final bool isBusiness;
  final Gradient? customGradient;
  final VoidCallback onBackTap;
  final VoidCallback? onDoThisLaterTap;

  const RegistrationHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepNames,
    required this.categoryTag,
    required this.title,
    required this.subtitle,
    this.badgeText,
    this.badgeIcon,
    this.showDoThisLater = false,
    this.isBusiness = false,
    this.customGradient,
    required this.onBackTap,
    this.onDoThisLaterTap,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;
    final screenWidth = mediaQuery.size.width;
    final isSmallScreen = screenWidth < 360;

    // Auto-detect business flow from flag, tag, or title
    final bool isBiz = isBusiness ||
        categoryTag.toLowerCase().contains('biz') ||
        categoryTag.toLowerCase().contains('business') ||
        title.toLowerCase().contains('business');

    // Creative: #2E7D6E -> #1C3A5E | Business: #1C3A5E -> #2A5FAA
    final Gradient headerGradient = customGradient ??
        (isBiz
            ? AppColors.buttonGradientBusiness
            : AppColors.buttonGradientCreative);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: headerGradient,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        isSmallScreen ? 12 : 16,
        topPadding + (isSmallScreen ? 6 : 10),
        isSmallScreen ? 12 : 16,
        isSmallScreen ? 18 : 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Top Navigation Row: Back Button & Step Indicators
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Back Button
              GestureDetector(
                onTap: onBackTap,
                child: Container(
                  width: isSmallScreen ? 34 : 38,
                  height: isSmallScreen ? 34 : 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.white,
                    size: isSmallScreen ? 20 : 24,
                  ),
                ),
              ),
              SizedBox(width: isSmallScreen ? 8 : 12),

              // Step Tabs with Underline Progress Bars
              Expanded(
                child: Row(
                  children: List.generate(totalSteps, (index) {
                    final isCurrent = index == currentStep;
                    final isPassed = index < currentStep;
                    final stepName = index < stepNames.length ? stepNames[index] : "";

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              stepName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: isSmallScreen ? 8.5 : 9.5,
                                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                                color: isCurrent
                                    ? Colors.white
                                    : (isPassed
                                        ? Colors.white.withValues(alpha: 0.85)
                                        : Colors.white.withValues(alpha: 0.35)),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 3.5,
                              decoration: BoxDecoration(
                                color: isCurrent
                                    ? Colors.white
                                    : (isPassed
                                        ? Colors.white.withValues(alpha: 0.75)
                                        : Colors.white.withValues(alpha: 0.2)),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Optional "Later" Action
              if (showDoThisLater) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onDoThisLaterTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      "Later",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: isSmallScreen ? 11 : 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: isSmallScreen ? 14 : 18),

          // ── Step Tag & Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "STEP ${currentStep + 1} OF $totalSteps · ${categoryTag.toUpperCase()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: isSmallScreen ? 10 : 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              if (badgeText != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (badgeIcon != null) ...[
                        Icon(badgeIcon, size: 11, color: Colors.white),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        badgeText!,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 5),

          // ── Main Header Title
          Text(
            title,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: isSmallScreen ? 19 : 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.2,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 4),

          // ── Subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: isSmallScreen ? 11.5 : 12.5,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
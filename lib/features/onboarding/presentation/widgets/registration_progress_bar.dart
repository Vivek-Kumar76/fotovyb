import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart'; //[cite: 2]

class RegistrationProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String>? stepNames;
  final bool showStepLabel;

  const RegistrationProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.stepNames,
    this.showStepLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary; //[cite: 1]
    final Color inactiveColor = isDark
        ? AppColors.surfaceSecondaryDark
        : AppColors.borderLight; //[cite: 1]
    final Color textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight; //[cite: 1]
    final Color textMuted = isDark
        ? AppColors.textMutedDark
        : AppColors.textMutedLight; //[cite: 1]

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showStepLabel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'STEP ${currentStep + 1} OF $totalSteps',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                  fontSize: AppTypography.sizeXs, //[cite: 6]
                  fontWeight: AppTypography.bold, //[cite: 6]
                  letterSpacing: 1.0,
                  color: textMuted,
                ),
              ),
              if (stepNames != null && currentStep < stepNames!.length)
                Text(
                  stepNames![currentStep],
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                    fontSize: AppTypography.sizeXs, //[cite: 6]
                    fontWeight: AppTypography.semibold, //[cite: 6]
                    color: textColor,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.space2), //[cite: 5]
        ],

        // ── Segmented Progress Bar
        Row(
          children: List.generate(totalSteps, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep;

            return Expanded(
              child: AnimatedContainer(
                duration: AppAnimations.normal, //[cite: 8]
                curve: AppAnimations.easeInOut, //[cite: 8]
                height: 4.5,
                margin: EdgeInsets.only(
                  right: index < totalSteps - 1 ? AppSpacing.space1 + 1 : 0, //[cite: 5]
                ),
                decoration: BoxDecoration(
                  color: (isCompleted || isCurrent) ? activeColor : inactiveColor,
                  borderRadius: AppRadius.radiusFull, //[cite: 3]
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: activeColor.withValues(alpha: 0.35),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
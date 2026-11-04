import 'package:flutter/material.dart';
import '../../../core/tokens/tokens.dart';

class PrimaryGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Gradient? gradient;
  final bool isLoading;
  final double height;

  const PrimaryGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.gradient,
    this.isLoading = false,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Ink(
          decoration: BoxDecoration(
            // Uses custom gradient if provided, otherwise falls back to AppColors.buttonGradient
            gradient: isDisabled ? null : (gradient ?? AppColors.buttonGradient),
            color: isDisabled
                ? (isDark ? AppColors.disabledDark : AppColors.disabled)
                : null,
            borderRadius: AppRadius.radiusFull,
          ),
          child: Container(
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: AppColors.textOnPrimary,
                          fontSize: AppTypography.sizeSm + 0.5,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: AppSpacing.space2),
                        icon!,
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
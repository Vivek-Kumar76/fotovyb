import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/tokens/tokens.dart'; //[cite: 2]

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color surfaceColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight; //[cite: 1]
    final Color borderColor = isDark
        ? AppColors.borderDark
        : AppColors.borderLight; //[cite: 1]
    final Color textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight; //[cite: 1]
    final Color hintColor = isDark
        ? AppColors.textMutedDark
        : AppColors.textMutedLight; //[cite: 1]
    final Color labelColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight; //[cite: 1]
    final Color activePrimary = isDark
        ? AppColors.primaryDark
        : AppColors.primary; //[cite: 1]

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans, //[cite: 6]
              fontSize: AppTypography.sizeXs, //[cite: 6]
              fontWeight: AppTypography.bold, //[cite: 6]
              color: labelColor,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space2), //[cite: 5]
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          maxLines: maxLines,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans, //[cite: 6]
            fontSize: AppTypography.sizeSm, //[cite: 6]
            fontWeight: AppTypography.medium, //[cite: 6]
            color: textColor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: AppTypography.sizeSm, //[cite: 6]
              fontWeight: AppTypography.regular, //[cite: 6]
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: errorText != null
                ? (isDark
                    ? const Color(0xFF3B1E1E)
                    : const Color(0xFFFFF0F0))
                : surfaceColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space4, //[cite: 5]
              vertical: AppSpacing.space3 + 2, //[cite: 5]
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.radiusMd, //[cite: 3]
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.radiusMd, //[cite: 3]
              borderSide: BorderSide(
                color: errorText != null ? AppColors.danger : borderColor, //[cite: 1]
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.radiusMd, //[cite: 3]
              borderSide: BorderSide(
                color: errorText != null ? AppColors.danger : activePrimary, //[cite: 1]
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.radiusMd, //[cite: 3]
              borderSide: const BorderSide(color: AppColors.danger), //[cite: 1]
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.space1 + 2), //[cite: 5]
          Row(
            children: [
              const Icon(
                Icons.error_outline,
                size: 14,
                color: AppColors.danger, //[cite: 1]
              ),
              const SizedBox(width: AppSpacing.space1), //[cite: 5]
              Text(
                errorText!,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                  fontSize: AppTypography.sizeXs + 1, //[cite: 6]
                  color: AppColors.danger, //[cite: 1]
                  fontWeight: AppTypography.medium, //[cite: 6]
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
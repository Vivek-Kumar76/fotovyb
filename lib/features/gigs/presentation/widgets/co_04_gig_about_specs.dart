import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigAboutSpecs extends StatelessWidget {
  const GigAboutSpecs({super.key});

  final List<String> specialties = const ["Editorial", "Cinematic", "Commercial", "Automotive"];
  final List<String> industries = const ["Fashion", "Automotive", "Luxury Goods", "Lifestyle"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color chipBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9);
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About This GIG",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "I offer high-end cinematic fashion and editorial photography services tailored for brands, magazines, and luxury clients. With 6+ years of experience, I specialize in creating visually striking campaign imagery that elevates your brand narrative. My approach combines technical expertise with creative vision to deliver compelling visual stories.",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 13,
              color: textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),

          // Specialties Tags
          Text(
            "SPECIALTIES",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: specialties.map((spec) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: AppRadius.radiusFull,
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  spec,
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: textColor),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.space3),

          // Industries Tags
          Text(
            "TARGET INDUSTRIES",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: industries.map((ind) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: AppRadius.radiusFull,
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  ind,
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: textColor),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../../../shared/widgets/primary_gradient_button.dart';

class BizIndustryStep extends StatefulWidget {
  final Function(Map<String, dynamic> data) onSaveAndContinue;

  const BizIndustryStep({super.key, required this.onSaveAndContinue});

  @override
  State<BizIndustryStep> createState() => _BizIndustryStepState();
}

class _BizIndustryStepState extends State<BizIndustryStep> {
  final TextEditingController brandNameCtrl = TextEditingController();
  String? selectedIndustry;

  // 16 Target Industries matching creative marketplace domains
  final List<Map<String, dynamic>> industryGrid = const [
    {"name": "Fashion", "icon": Icons.checkroom_outlined},
    {"name": "Jewellery", "icon": Icons.diamond_outlined},
    {"name": "Automobiles", "icon": Icons.directions_car_outlined},
    {"name": "Electronics", "icon": Icons.devices_outlined},
    {"name": "Hotels & Resorts", "icon": Icons.hotel_outlined},
    {"name": "Hospitals", "icon": Icons.local_hospital_outlined},
    {"name": "Restaurants", "icon": Icons.restaurant_outlined},
    {"name": "Food Brands", "icon": Icons.lunch_dining_outlined},
    {"name": "Furniture", "icon": Icons.chair_outlined},
    {"name": "Fitness", "icon": Icons.fitness_center_outlined},
    {"name": "Spa", "icon": Icons.spa_outlined},
    {"name": "Tours & Travel", "icon": Icons.explore_outlined},
    {"name": "Interior Design", "icon": Icons.palette_outlined},
    {"name": "Beauty & Cosmetics", "icon": Icons.auto_awesome_outlined},
    {"name": "Corporates", "icon": Icons.business_outlined},
    {"name": "Education Institutes", "icon": Icons.school_outlined},
  ];

  bool get isFormValid =>
      brandNameCtrl.text.trim().isNotEmpty && selectedIndustry != null;

  @override
  void dispose() {
    brandNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color fieldBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color activeBorder = isDark ? AppColors.accentBlue : AppColors.accentNavy;
    final Color activeBg = isDark
        ? AppColors.accentNavy.withValues(alpha: 0.35)
        : const Color(0xffEFF6FF);

    // Responsive columns & aspect ratio to prevent overflows on all screen sizes
    final int crossAxisCount = screenWidth > 540 ? 4 : 3;
    final double cardAspectRatio = screenWidth > 540 ? 1.35 : (screenWidth < 360 ? 1.22 : 1.30);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space5,
        vertical: AppSpacing.space4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Brand / Company Name Input (Unified Pill Radius)
          Text(
            "BRAND / COMPANY NAME *",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.space2),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: AppRadius.radiusFull,
              border: Border.all(
                color: brandNameCtrl.text.isNotEmpty ? activeBorder : borderColor,
                width: brandNameCtrl.text.isNotEmpty ? 1.6 : 1.0,
              ),
            ),
            child: TextField(
              controller: brandNameCtrl,
              onChanged: (_) => setState(() {}),
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeSm,
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: "e.g. Acme Media Works",
                hintStyle: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: textMuted,
                  fontSize: AppTypography.sizeSm,
                ),
                prefixIcon: Icon(Icons.storefront_outlined, size: 20, color: textMuted),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── 2. Primary Industry Domain Grid
          Text(
            "PRIMARY INDUSTRY VERTICAL *",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: textMuted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Select the primary domain your business operates in",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm + 1,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),

          // Responsive Adaptive Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: industryGrid.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: cardAspectRatio,
            ),
            itemBuilder: (context, index) {
              final item = industryGrid[index];
              final String name = item['name'] as String;
              final IconData icon = item['icon'] as IconData;
              final isSel = selectedIndustry == name;

              return GestureDetector(
                onTap: () => setState(() => selectedIndustry = name),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSel ? activeBg : fieldBg,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSel ? activeBorder : borderColor,
                      width: isSel ? 1.6 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: isSel ? activeBorder : textSecondary,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 11,
                          fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                          color: isSel ? activeBorder : textColor,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.space8),

          // ── 3. Action Button (Bluish Gradient for Business)
          PrimaryGradientButton(
            label: "Save & Continue to Locations",
            gradient: AppColors.buttonGradientBusiness,
            onPressed: isFormValid
                ? () {
                    widget.onSaveAndContinue({
                      'brandName': brandNameCtrl.text.trim(),
                      'industry': selectedIndustry,
                    });
                  }
                : null,
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.textOnPrimary,
              size: 18,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
        ],
      ),
    );
  }
}
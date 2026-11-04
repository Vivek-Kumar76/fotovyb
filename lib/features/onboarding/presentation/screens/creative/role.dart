import 'package:flutter/material.dart';
import 'package:p1/core/tokens/tokens.dart'; //[cite: 13]
import 'package:p1/shared/widgets/primary_gradient_button.dart'; //[cite: 13]

class RoleStep extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onSaveAndContinue;

  const RoleStep({
    super.key,
    required this.onSaveAndContinue,
  });

  @override
  State<RoleStep> createState() => _RoleStepState();
}

class _RoleStepState extends State<RoleStep> {
  String? selectedPrimaryRole;
  String? selectedModelCategory; // "Male", "Female", "Kid"
  String? selectedKidGender;     // "Boy", "Girl"
  String? selectedExperience;
  final Set<String> selectedIndustries = {};

  // ── 20 Primary Specialties (Model included)
  final List<Map<String, dynamic>> primaryRoles = const [
    {"name": "Creative Director", "icon": Icons.grid_view_rounded},
    {"name": "Casting Director", "icon": Icons.groups_outlined},
    {"name": "Videographer", "icon": Icons.videocam_outlined},
    {"name": "Bridal Studio", "icon": Icons.storefront_outlined},
    {"name": "Hair Stylist", "icon": Icons.content_cut_outlined},
    {"name": "Model", "icon": Icons.person_outline_rounded},
    {"name": "Photo Assistant", "icon": Icons.add_photo_alternate_outlined},
    {"name": "Video Editors", "icon": Icons.video_library_outlined},
    {"name": "Production Assistant\n(PA)", "icon": Icons.flag_outlined},
    {"name": "Sound Engineer", "icon": Icons.headphones_outlined},
    {"name": "Art Director", "icon": Icons.palette_outlined},
    {"name": "Photographer", "icon": Icons.camera_alt_outlined},
    {"name": "Photo Studio", "icon": Icons.store_outlined},
    {"name": "Makeup Artist", "icon": Icons.face_retouching_natural_outlined},
    {"name": "Fashion Stylist", "icon": Icons.checkroom_outlined},
    {"name": "Lighting Technician", "icon": Icons.wb_sunny_outlined},
    {"name": "Photo Editors", "icon": Icons.crop_rotate_outlined},
    {"name": "Executive Producer", "icon": Icons.business_center_outlined},
    {"name": "Graphics Designer", "icon": Icons.draw_outlined},
    {"name": "Drone Operator", "icon": Icons.flight_takeoff_outlined},
  ];

  final List<Map<String, dynamic>> modelCategories = const [
    {"name": "Male", "icon": Icons.male_rounded},
    {"name": "Female", "icon": Icons.female_rounded},
    {"name": "Kid", "icon": Icons.child_care_rounded},
  ];

  final List<Map<String, dynamic>> kidGenders = const [
    {"name": "Boy", "icon": Icons.boy_rounded},
    {"name": "Girl", "icon": Icons.girl_rounded},
  ];

  // ── Experience Levels
  final List<Map<String, dynamic>> experienceLevels = const [
    {
      "title": "Just Starting",
      "subtitle": "0–1 years",
      "icon": Icons.content_cut_outlined,
    },
    {
      "title": "Intermediate",
      "subtitle": "2–4 years",
      "icon": Icons.tune_outlined,
    },
    {
      "title": "Advanced",
      "subtitle": "5–8 years",
      "icon": Icons.trending_up_rounded,
    },
    {
      "title": "Expert",
      "subtitle": "9+ years",
      "icon": Icons.workspace_premium_outlined,
    },
  ];

  // ── Target Industries
  final List<Map<String, dynamic>> targetIndustries = const [
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

  bool get _isModelValid {
    if (selectedPrimaryRole != "Model") return true;
    if (selectedModelCategory == null) return false;
    if (selectedModelCategory == "Kid" && selectedKidGender == null) return false;
    return true;
  }

  bool get _isFormValid =>
      selectedPrimaryRole != null &&
      _isModelValid &&
      selectedExperience != null &&
      selectedIndustries.isNotEmpty;

  void _handleSubmit() {
    if (!_isFormValid) return;
    widget.onSaveAndContinue({
      'primaryRole': selectedPrimaryRole,
      'modelCategory': selectedModelCategory,
      'kidGender': selectedKidGender,
      'experience': selectedExperience,
      'targetIndustries': selectedIndustries.toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color activeBorder = isDark ? AppColors.selectionCardSelectedBorderDark : AppColors.primary;
    final Color activeBg = isDark ? const Color(0xff064E3B).withValues(alpha: 0.35) : const Color(0xffE6F7EF);

    // Dynamic responsive grid metrics
    final int roleCrossAxisCount = screenWidth > 540 ? 5 : 4;
    final double roleAspectRatio = screenWidth < 360 ? 0.88 : (screenWidth < 400 ? 0.94 : 1.0);

    final int industryCrossAxisCount = screenWidth > 540 ? 4 : 3;
    final double industryAspectRatio = screenWidth < 360 ? 1.20 : 1.32;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space5, vertical: AppSpacing.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section 1: My Primary Roles
          const SizedBox(height: 2),
          Text(
            "MY PRIMARY ROLES",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm + 1,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),

          // Responsive Primary Roles Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: roleCrossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: roleAspectRatio,
            ),
            itemCount: primaryRoles.length,
            itemBuilder: (context, index) {
              final item = primaryRoles[index];
              final name = item['name'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = selectedPrimaryRole == name;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPrimaryRole = name;
                    if (name != "Model") {
                      selectedModelCategory = null;
                      selectedKidGender = null;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? activeBg : surfaceColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected ? activeBorder : borderColor,
                      width: isSelected ? 1.6 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: isSelected ? AppColors.primary : textSecondary,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 10.5,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? AppColors.primary : textColor,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── Conditional Model Gender Section
          if (selectedPrimaryRole == "Model") ...[

            const SizedBox(height: 2),
            Text(
              "Select modeling profile category",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeSm + 1,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: AppSpacing.space3),

            // Male / Female / Kid 3-Column Selector
            Row(
              children: modelCategories.map((cat) {
                final name = cat['name'] as String;
                final icon = cat['icon'] as IconData;
                final isSelected = selectedModelCategory == name;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedModelCategory = name;
                          if (name != "Kid") {
                            selectedKidGender = null;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? activeBg : surfaceColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected ? activeBorder : borderColor,
                            width: isSelected ? 1.6 : 1.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              icon,
                              size: 22,
                              color: isSelected ? AppColors.primary : textSecondary,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              name,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                color: isSelected ? AppColors.primary : textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Conditional Kid's Sub-Gender Selection
            if (selectedModelCategory == "Kid") ...[
              const SizedBox(height: AppSpacing.space3),
              Text(
                "KID'S GENDER *",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: AppSpacing.space2),
              Row(
                children: kidGenders.map((k) {
                  final name = k['name'] as String;
                  final icon = k['icon'] as IconData;
                  final isSelected = selectedKidGender == name;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedKidGender = name),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? activeBg : surfaceColor,
                            borderRadius: AppRadius.radiusFull,
                            border: Border.all(
                              color: isSelected ? activeBorder : borderColor,
                              width: isSelected ? 1.6 : 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon,
                                size: 18,
                                color: isSelected ? AppColors.primary : textSecondary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                name,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                  color: isSelected ? AppColors.primary : textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: AppSpacing.space5),
          ] else ...[
            const SizedBox(height: AppSpacing.space2),
          ],

          // ── Section 2: Years of Experience
          const SizedBox(height: 2),
          Text(
            "YEARS OF EXPERIENCE",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm + 1,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),

          // Experience Cards List
          Column(
            children: experienceLevels.map((exp) {
              final title = exp['title'] as String;
              final subtitle = exp['subtitle'] as String;
              final icon = exp['icon'] as IconData;
              final isSelected = selectedExperience == title;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () => setState(() => selectedExperience = title),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? activeBg : surfaceColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? activeBorder : borderColor,
                        width: isSelected ? 1.6 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          size: 22,
                          color: isSelected ? AppColors.primary : textSecondary,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: AppTypography.sizeSm,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? AppColors.primary : textColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 11.5,
                                  color: textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : borderColor,
                              width: isSelected ? 5.5 : 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── Section 3: Target Industries
          Text(
            "TARGET INDUSTRIES",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Select industries you want to work with",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm + 1,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: AppSpacing.space3),

          // Responsive Target Industries Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: industryCrossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: industryAspectRatio,
            ),
            itemCount: targetIndustries.length,
            itemBuilder: (context, index) {
              final item = targetIndustries[index];
              final name = item['name'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = selectedIndustries.contains(name);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedIndustries.remove(name);
                    } else {
                      selectedIndustries.add(name);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? activeBg : surfaceColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected ? activeBorder : borderColor,
                      width: isSelected ? 1.6 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: isSelected ? AppColors.primary : textSecondary,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? AppColors.primary : textColor,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.space6),

          // ── Save & Continue Button (Pill Rounded)
          PrimaryGradientButton(
            label: "Save & Continue",
            onPressed: _isFormValid ? _handleSubmit : null,
            icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
          ),
          const SizedBox(height: AppSpacing.space4),
        ],
      ),
    );
  }
}
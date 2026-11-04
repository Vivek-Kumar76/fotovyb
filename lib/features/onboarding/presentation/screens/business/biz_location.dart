import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../../../shared/widgets/primary_gradient_button.dart';

class BizLocationStep extends StatefulWidget {
  final Function(Map<String, dynamic> data) onSaveAndContinue;

  const BizLocationStep({super.key, required this.onSaveAndContinue});

  @override
  State<BizLocationStep> createState() => _BizLocationStepState();
}

class _BizLocationStepState extends State<BizLocationStep> {
  String? selectedBudget = "20K - 40K";
  final TextEditingController baseLocationCtrl = TextEditingController();
  final List<String> selectedOperatingRegions = ["Mumbai"];

  final List<String> budgetRanges = const [
    "1K - 20K",
    "20K - 40K",
    "40K - 60K",
    "60K - 80K",
    "Above 80K",
  ];

  final List<String> availableCities = const [
    "Mumbai",
    "Delhi",
    "Bangalore",
    "Chennai",
    "Hyderabad",
    "Kolkata",
    "Pune",
    "Jaipur",
    "Ahmedabad",
    "Surat",
    "Chandigarh",
    "Lucknow",
    "Kochi",
    "Goa",
    "Indore",
    "Noida",
    "Gurugram",
  ];

  bool get isFormValid =>
      selectedBudget != null && baseLocationCtrl.text.trim().isNotEmpty;

  void _openCityPickerBottomSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return _CitySelectionModal(
          allCities: availableCities,
          initialSelected: List.from(selectedOperatingRegions),
          onApply: (updatedList) {
            setState(() {
              selectedOperatingRegions.clear();
              selectedOperatingRegions.addAll(updatedList);
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    baseLocationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color fieldBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color activeBorder = isDark ? AppColors.accentBlue : AppColors.accentNavy;
    final Color activeBg = isDark
        ? AppColors.accentNavy.withValues(alpha: 0.35)
        : const Color(0xffEFF6FF);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space5,
        vertical: AppSpacing.space4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Budget Range Section
          Text(
            "Set the standard budget range for creative projects you commission.",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm + 1,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),

          // Horizontal Budget Selection Cards
          SizedBox(
            height: 94,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: budgetRanges.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, idx) {
                final range = budgetRanges[idx];
                final isSelected = selectedBudget == range;

                return GestureDetector(
                  onTap: () => setState(() => selectedBudget = range),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        width: 86,
                        height: 94,
                        decoration: BoxDecoration(
                          color: isSelected ? activeBg : fieldBg,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? activeBorder : borderColor,
                            width: isSelected ? 1.8 : 1.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.accentNavy
                                    : (isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9)),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "₹",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : textSecondary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              range,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 11.5,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                color: isSelected ? textColor : textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Positioned(
                          top: -3,
                          right: -3,
                          child: CircleAvatar(
                            radius: 9,
                            backgroundColor: AppColors.accentNavy,
                            child: Icon(Icons.check, size: 12, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── 2. Primary Base Location Section
          Text(
            "The primary city where your brand operates.",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm + 1,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: AppRadius.radiusFull,
              border: Border.all(
                color: baseLocationCtrl.text.isNotEmpty ? activeBorder : borderColor,
                width: baseLocationCtrl.text.isNotEmpty ? 1.6 : 1.0,
              ),
            ),
            child: TextField(
              controller: baseLocationCtrl,
              onChanged: (_) => setState(() {}),
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeSm,
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: "e.g. Mumbai",
                hintStyle: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: textMuted,
                  fontSize: AppTypography.sizeSm,
                ),
                prefixIcon: Icon(Icons.location_city_outlined, size: 20, color: textMuted),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── 3. Other Operating Regions Section (Optional)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Other operating regions",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: AppTypography.sizeSm + 1,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9),
                  borderRadius: AppRadius.radiusFull,
                ),
                child: Text(
                  "Optional",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeXs - 1,
                    fontWeight: FontWeight.w700,
                    color: textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Search Pop-up Trigger Input Field
          GestureDetector(
            onTap: _openCityPickerBottomSheet,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: fieldBg,
                borderRadius: AppRadius.radiusFull,
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, size: 20, color: textMuted),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      selectedOperatingRegions.isEmpty
                          ? "Search operating regions..."
                          : "${selectedOperatingRegions.length} regions selected",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        color: selectedOperatingRegions.isEmpty ? textMuted : textColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceSecondaryDark : Colors.white,
                      borderRadius: AppRadius.radiusFull,
                      border: Border.all(color: borderColor),
                    ),
                    child: Text(
                      "Select",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeXs + 1,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space3),

          // Removable Selected Region Chips
          if (selectedOperatingRegions.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedOperatingRegions.map((city) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9),
                    borderRadius: AppRadius.radiusFull,
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        city,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeSm,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOperatingRegions.remove(city);
                          });
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 14,
                          color: textMuted,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: AppSpacing.space8),

          // ── 4. Action Button (Bluish Gradient for Business)
          PrimaryGradientButton(
            label: "Save & Continue",
            gradient: AppColors.buttonGradientBusiness,
            onPressed: isFormValid
                ? () {
                    widget.onSaveAndContinue({
                      'budgetRange': selectedBudget,
                      'baseLocation': baseLocationCtrl.text.trim(),
                      'operatingRegions': selectedOperatingRegions,
                    });
                  }
                : null,
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
        ],
      ),
    );
  }
}

// ── Searchable Multi-Select Bottom Sheet Modal
class _CitySelectionModal extends StatefulWidget {
  final List<String> allCities;
  final List<String> initialSelected;
  final Function(List<String>) onApply;

  const _CitySelectionModal({
    required this.allCities,
    required this.initialSelected,
    required this.onApply,
  });

  @override
  State<_CitySelectionModal> createState() => _CitySelectionModalState();
}

class _CitySelectionModalState extends State<_CitySelectionModal> {
  late List<String> tempSelected;
  String searchQuery = "";
  final TextEditingController customCityCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    tempSelected = List.from(widget.initialSelected);
  }

  @override
  void dispose() {
    customCityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color activeColor = isDark ? AppColors.accentBlue : AppColors.accentNavy;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    final filteredCities = widget.allCities
        .where((c) => c.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        padding: const EdgeInsets.all(AppSpacing.space5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select Operating Regions",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeLg,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space3),
            TextField(
              controller: customCityCtrl,
              onChanged: (val) => setState(() => searchQuery = val),
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeSm,
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: "Search city or add custom...",
                prefixIcon: const Icon(Icons.search_rounded, size: 18),
                suffixIcon: searchQuery.isNotEmpty && !filteredCities.contains(searchQuery)
                    ? TextButton(
                        onPressed: () {
                          if (searchQuery.trim().isNotEmpty) {
                            setState(() {
                              tempSelected.add(searchQuery.trim());
                              customCityCtrl.clear();
                              searchQuery = "";
                            });
                          }
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: activeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
                filled: true,
                fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: AppRadius.radiusFull,
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.radiusFull,
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadius.radiusFull,
                  borderSide: BorderSide(color: activeColor, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space3),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCities.length,
                itemBuilder: (context, idx) {
                  final city = filteredCities[idx];
                  final isChecked = tempSelected.contains(city);
                  return CheckboxListTile(
                    activeColor: activeColor,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      city,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        color: textColor,
                      ),
                    ),
                    value: isChecked,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          tempSelected.add(city);
                        } else {
                          tempSelected.remove(city);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.space3),
            PrimaryGradientButton(
              label: "Done (${tempSelected.length} Selected)",
              gradient: AppColors.buttonGradientBusiness,
              onPressed: () {
                widget.onApply(tempSelected);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
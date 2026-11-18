import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/opportunities_feed_page.dart';

class OpportunitiesFilterDrawer extends StatefulWidget {
  final String initialBudgetRange;
  final Set<String> initialRoles;
  final Set<String> initialIndustries;
  final Set<String> initialLocations;
  final String initialRating;
  final OpportunityFacets facets;
  final void Function({
    required String budgetRange,
    required Set<String> roles,
    required Set<String> industries,
    required Set<String> locations,
    required String rating,
  }) onApply;
  final VoidCallback onClearAll;

  const OpportunitiesFilterDrawer({
    super.key,
    required this.initialBudgetRange,
    required this.initialRoles,
    required this.initialIndustries,
    required this.initialLocations,
    required this.initialRating,
    required this.facets,
    required this.onApply,
    required this.onClearAll,
  });

  @override
  State<OpportunitiesFilterDrawer> createState() =>
      _OpportunitiesFilterDrawerState();
}

class _OpportunitiesFilterDrawerState extends State<OpportunitiesFilterDrawer> {
  late String _selectedBudget;
  late Set<String> _selectedProfTypes;
  late Set<String> _selectedIndustries;
  late Set<String> _selectedLocations;
  late String _selectedRating;

  static const List<String> _budgets = [
    "₹10k – ₹50k",
    "₹50k – ₹1L",
    "₹1L – ₹5L",
    "₹5L+",
  ];

  static const List<String> _profTypes = [
    "Photographer",
    "Videographer",
    "Stylist",
    "Art Director",
    "MUA",
    "Model",
  ];

  static const List<String> _industries = [
    "Fashion & Beauty",
    "Tech & Gadgets",
    "Automotive",
    "Lifestyle",
    "Travel & Tourism",
    "Food & Beverage",
  ];

  static const List<String> _locations = [
    "Mumbai",
    "Delhi",
    "Bangalore",
    "Chennai",
    "Hyderabad",
    "Pune",
  ];

  static const List<String> _ratings = [
    "4.5+",
    "4.0+",
    "3.5+",
    "Any Rating",
  ];

  @override
  void initState() {
    super.initState();
    _selectedBudget = widget.initialBudgetRange;
    _selectedProfTypes = Set<String>.from(widget.initialRoles);
    _selectedIndustries = Set<String>.from(widget.initialIndustries);
    _selectedLocations = Set<String>.from(widget.initialLocations);
    _selectedRating = widget.initialRating;
  }

  void _handleClearAll() {
    setState(() {
      _selectedBudget = '';
      _selectedProfTypes.clear();
      _selectedIndustries.clear();
      _selectedLocations.clear();
      _selectedRating = '';
    });
    widget.onClearAll();
    Navigator.of(context).pop();
  }

  void _handleApply() {
    widget.onApply(
      budgetRange: _selectedBudget,
      roles: _selectedProfTypes,
      industries: _selectedIndustries,
      locations: _selectedLocations,
      rating: _selectedRating,
    );
    Navigator.of(context).pop();
  }

  int? _lookupFacetCount(Map<String, int> facetMap, String key) {
    if (facetMap.isEmpty) return null;
    if (facetMap.containsKey(key)) return facetMap[key];
    final lowerKey = key.toLowerCase();
    for (final entry in facetMap.entries) {
      if (entry.key.toLowerCase() == lowerKey) return entry.value;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final topPadding = MediaQuery.paddingOf(context).top;
    final drawerWidth = screenWidth >= 600 ? screenWidth * 0.45 : screenWidth * 0.82;
    final textColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffF1F5F9);

    return Drawer(
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      width: drawerWidth,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(height: topPadding + drawerWidth * 0.045),

            // ── Drawer Header: "Filters" + "Clear All"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: drawerWidth * 0.065),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: drawerWidth * 0.058,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.close_rounded,
                          size: drawerWidth * 0.065,
                          color: const Color(0xff64748B),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: drawerWidth * 0.038),
                  SizedBox(
                    width: double.infinity,
                    height: drawerWidth * 0.12,
                    child: OutlinedButton(
                      onPressed: _handleClearAll,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xff0D9488),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(drawerWidth * 0.065),
                        ),
                      ),
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: const Color(0xff0D9488),
                          fontSize: drawerWidth * 0.042,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: drawerWidth * 0.045),
            Divider(height: 1, color: borderColor),

            // ── Scrollable Filter Groups
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: drawerWidth * 0.052,
                  vertical: drawerWidth * 0.032,
                ),
                children: [
                  _buildSectionHeader("BUDGET RANGE", drawerWidth),
                  ..._budgets.map(
                    (label) => _buildFilterTile(
                      drawerWidth: drawerWidth,
                      label: label,
                      count: _lookupFacetCount(widget.facets.budgetRange, label),
                      isSelected: _selectedBudget == label,
                      isDark: isDark,
                      onTap: () => setState(() {
                        _selectedBudget = _selectedBudget == label ? '' : label;
                      }),
                    ),
                  ),
                  SizedBox(height: drawerWidth * 0.05),

                  _buildSectionHeader("PROFESSIONAL TYPE", drawerWidth),
                  ..._profTypes.map(
                    (label) => _buildFilterTile(
                      drawerWidth: drawerWidth,
                      label: label,
                      count: _lookupFacetCount(widget.facets.roles, label),
                      isSelected: _selectedProfTypes.contains(label),
                      isDark: isDark,
                      onTap: () {
                        setState(() {
                          if (_selectedProfTypes.contains(label)) {
                            _selectedProfTypes.remove(label);
                          } else {
                            _selectedProfTypes.add(label);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: drawerWidth * 0.05),

                  _buildSectionHeader("INDUSTRY", drawerWidth),
                  ..._industries.map(
                    (label) => _buildFilterTile(
                      drawerWidth: drawerWidth,
                      label: label,
                      count: _lookupFacetCount(widget.facets.categories, label),
                      isSelected: _selectedIndustries.contains(label),
                      isDark: isDark,
                      onTap: () {
                        setState(() {
                          if (_selectedIndustries.contains(label)) {
                            _selectedIndustries.remove(label);
                          } else {
                            _selectedIndustries.add(label);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: drawerWidth * 0.05),

                  _buildSectionHeader("LOCATION", drawerWidth),
                  ..._locations.map(
                    (label) => _buildFilterTile(
                      drawerWidth: drawerWidth,
                      label: label,
                      count: _lookupFacetCount(widget.facets.locations, label),
                      isSelected: _selectedLocations.contains(label),
                      isDark: isDark,
                      onTap: () {
                        setState(() {
                          if (_selectedLocations.contains(label)) {
                            _selectedLocations.remove(label);
                          } else {
                            _selectedLocations.add(label);
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: drawerWidth * 0.05),

                  _buildSectionHeader("RATING", drawerWidth),
                  ..._ratings.map(
                    (label) => _buildFilterTile(
                      drawerWidth: drawerWidth,
                      label: label,
                      count: null,
                      isSelected: _selectedRating == label,
                      isDark: isDark,
                      onTap: () => setState(() {
                        _selectedRating = _selectedRating == label ? '' : label;
                      }),
                    ),
                  ),
                  SizedBox(height: drawerWidth * 0.06),
                ],
              ),
            ),

            // ── Sticky Bottom Apply CTA
            Container(
              padding: EdgeInsets.fromLTRB(
                drawerWidth * 0.065,
                drawerWidth * 0.032,
                drawerWidth * 0.065,
                drawerWidth * 0.045,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(top: BorderSide(color: borderColor)),
              ),
              child: GestureDetector(
                onTap: _handleApply,
                child: Container(
                  width: double.infinity,
                  height: drawerWidth * 0.135,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradientCreative,
                    borderRadius: BorderRadius.circular(drawerWidth * 0.07),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Apply Filters",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: drawerWidth * 0.044,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, double drawerWidth) {
    return Padding(
      padding: EdgeInsets.only(
        top: drawerWidth * 0.025,
        bottom: drawerWidth * 0.025,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: drawerWidth * 0.035,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: const Color(0xff64748B),
        ),
      ),
    );
  }

  Widget _buildFilterTile({
    required double drawerWidth,
    required String label,
    required int? count,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final activeBg = isDark
        ? const Color(0xff0D9488).withValues(alpha: 0.18)
        : const Color(0xffE6F4F1);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: drawerWidth * 0.011),
        padding: EdgeInsets.symmetric(
          horizontal: drawerWidth * 0.032,
          vertical: drawerWidth * 0.026,
        ),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(drawerWidth * 0.075),
        ),
        child: Row(
          children: [
            Container(
              width: drawerWidth * 0.058,
              height: drawerWidth * 0.058,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xff0D9488)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xff0D9488)
                      : const Color(0xffCBD5E1),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: drawerWidth * 0.038,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: drawerWidth * 0.032),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: drawerWidth * 0.04,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xff0D9488)
                      : (isDark
                          ? AppColors.textSecondaryDark
                          : const Color(0xff475569)),
                ),
              ),
            ),
            if (count != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: drawerWidth * 0.026,
                  vertical: drawerWidth * 0.007,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xff0D9488)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : const Color(0xffF1F5F9)),
                  borderRadius: BorderRadius.circular(drawerWidth * 0.04),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: drawerWidth * 0.034,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xff64748B),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
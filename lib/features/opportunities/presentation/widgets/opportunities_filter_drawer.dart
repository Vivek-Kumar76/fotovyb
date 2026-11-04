import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class OpportunitiesFilterDrawer extends StatefulWidget {
  final VoidCallback? onApply;
  final VoidCallback? onClearAll;

  const OpportunitiesFilterDrawer({
    super.key,
    this.onApply,
    this.onClearAll,
  });

  @override
  State<OpportunitiesFilterDrawer> createState() =>
      _OpportunitiesFilterDrawerState();
}

class _OpportunitiesFilterDrawerState extends State<OpportunitiesFilterDrawer> {
  String _selectedBudget = "₹50k – ₹1L";
  final Set<String> _selectedProfTypes = {};
  final Set<String> _selectedIndustries = {"Automotive"};
  final Set<String> _selectedLocations = {"Bangalore"};
  String _selectedRating = "3.5+";

  final List<Map<String, dynamic>> _budgets = const [
    {"label": "₹10k – ₹50k", "count": 45},
    {"label": "₹50k – ₹1L", "count": 32},
    {"label": "₹1L – ₹5L", "count": 28},
    {"label": "₹5L+", "count": 15},
  ];

  final List<Map<String, dynamic>> _profTypes = const [
    {"label": "Photographer", "count": 320},
    {"label": "Videographer", "count": 180},
    {"label": "Stylist", "count": 95},
    {"label": "Art Director", "count": 65},
    {"label": "MUA", "count": 72},
    {"label": "Model", "count": 140},
  ];

  final List<Map<String, dynamic>> _industries = const [
    {"label": "Fashion & Beauty", "count": 145},
    {"label": "Tech & Gadgets", "count": 78},
    {"label": "Automotive", "count": 52},
    {"label": "Lifestyle", "count": 98},
    {"label": "Travel & Tourism", "count": 65},
    {"label": "Food & Beverage", "count": 43},
  ];

  final List<Map<String, dynamic>> _locations = const [
    {"label": "Mumbai", "count": 95},
    {"label": "Delhi", "count": 78},
    {"label": "Bangalore", "count": 102},
    {"label": "Chennai", "count": 42},
    {"label": "Hyderabad", "count": 55},
    {"label": "Pune", "count": 38},
  ];

  final List<Map<String, dynamic>> _ratings = const [
    {"label": "4.5+", "count": 120},
    {"label": "4.0+", "count": 210},
    {"label": "3.5+", "count": 280},
    {"label": "Any Rating", "count": 450},
  ];

  void _clearAll() {
    setState(() {
      _selectedBudget = "";
      _selectedProfTypes.clear();
      _selectedIndustries.clear();
      _selectedLocations.clear();
      _selectedRating = "";
    });
    widget.onClearAll?.call();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final textColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);

    return Drawer(
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      width: MediaQuery.of(context).size.width * 0.82,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(height: topPadding + 14),

            // ── Drawer Header: "Filters" + "Clear All"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: OutlinedButton(
                      onPressed: _clearAll,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xff0D9488),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Clear All",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Color(0xff0D9488),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xffF1F5F9)),

            // ── Scrollable Filter Groups
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                children: [
                  _buildSectionHeader("BUDGET RANGE"),
                  ..._budgets.map(
                    (b) => _buildFilterTile(
                      label: b['label'] as String,
                      count: b['count'] as int,
                      isSelected: _selectedBudget == b['label'],
                      onTap: () => setState(
                        () => _selectedBudget = b['label'] as String,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionHeader("PROFESSIONAL TYPE"),
                  ..._profTypes.map(
                    (p) => _buildFilterTile(
                      label: p['label'] as String,
                      count: p['count'] as int,
                      isSelected: _selectedProfTypes.contains(p['label']),
                      onTap: () {
                        setState(() {
                          if (_selectedProfTypes.contains(p['label'])) {
                            _selectedProfTypes.remove(p['label']);
                          } else {
                            _selectedProfTypes.add(p['label'] as String);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionHeader("INDUSTRY"),
                  ..._industries.map(
                    (i) => _buildFilterTile(
                      label: i['label'] as String,
                      count: i['count'] as int,
                      isSelected: _selectedIndustries.contains(i['label']),
                      onTap: () {
                        setState(() {
                          if (_selectedIndustries.contains(i['label'])) {
                            _selectedIndustries.remove(i['label']);
                          } else {
                            _selectedIndustries.add(i['label'] as String);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionHeader("LOCATION"),
                  ..._locations.map(
                    (l) => _buildFilterTile(
                      label: l['label'] as String,
                      count: l['count'] as int,
                      isSelected: _selectedLocations.contains(l['label']),
                      onTap: () {
                        setState(() {
                          if (_selectedLocations.contains(l['label'])) {
                            _selectedLocations.remove(l['label']);
                          } else {
                            _selectedLocations.add(l['label'] as String);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionHeader("RATING"),
                  ..._ratings.map(
                    (r) => _buildFilterTile(
                      label: r['label'] as String,
                      count: r['count'] as int,
                      isSelected: _selectedRating == r['label'],
                      onTap: () => setState(
                        () => _selectedRating = r['label'] as String,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: Color(0xff1E293B),
        ),
      ),
    );
  }

  Widget _buildFilterTile({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3.5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffE6F4F1) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xff0D9488) : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xff0D9488)
                      : const Color(0xffCBD5E1),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xff0D9488)
                      : const Color(0xff475569),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xff0D9488)
                    : const Color(0xffF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xff64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
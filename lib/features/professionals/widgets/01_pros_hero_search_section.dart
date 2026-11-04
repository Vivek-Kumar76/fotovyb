import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProsHeroSearchSection extends StatefulWidget {
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onCityChanged;
  final ValueChanged<String>? onRoleChanged;

  const ProsHeroSearchSection({
    super.key,
    this.onSearch,
    this.onCityChanged,
    this.onRoleChanged,
  });

  @override
  State<ProsHeroSearchSection> createState() => _ProsHeroSearchSectionState();
}

class _ProsHeroSearchSectionState extends State<ProsHeroSearchSection> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCity = "Mumbai";
  String _selectedRole = "All Roles";

  final List<String> _cities = const [
    "Mumbai",
    "Delhi",
    "Bangalore",
    "Goa",
    "Pune",
    "Hyderabad",
  ];

  final List<String> _roles = const [
    "All Roles",
    "Photographer",
    "Stylist",
    "Model",
    "Videographer",
    "MUA",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < 380;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff091B2B),
            Color(0xff0D2A3F),
            Color(0xff0E2F3D),
            Color(0xff081824),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.fromLTRB(16, topPadding + 20, 16, 26),
      child: Column(
        children: [
          // Tagline
          const Text(
            "DISCOVER • CONNECT • COLLABORATE",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: Color(0xff7E9BB0),
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          // Main Heading
          Text(
            "Find Creative Professionals",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: Colors.white,
              fontSize: isNarrow ? 22 : 26,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            "Search photographers, stylists, models, MUAs and more across India",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 22),

          // ── Search Bar Pill
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                // 1. Text Search Input
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded,
                            size: 18, color: Color(0xff94A3B8)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: widget.onSearch,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 12,
                              color: Color(0xff1E293B),
                            ),
                            decoration: const InputDecoration(
                              hintText: "Name, role, skill...",
                              hintStyle: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Color(0xff94A3B8),
                                fontSize: 11.5,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Vertical Divider
                Container(height: 20, width: 1, color: const Color(0xffE2E8F0)),

                // 2. City Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: PopupMenuButton<String>(
                    initialValue: _selectedCity,
                    onSelected: (val) {
                      setState(() => _selectedCity = val);
                      widget.onCityChanged?.call(val);
                    },
                    color: Colors.white,
                    itemBuilder: (ctx) => _cities
                        .map((c) => PopupMenuItem(value: c, child: Text(c)))
                        .toList(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 15, color: Color(0xff64748B)),
                        const SizedBox(width: 3),
                        Text(
                          _selectedCity,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff334155),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 15, color: Color(0xff64748B)),
                      ],
                    ),
                  ),
                ),

                // Vertical Divider
                Container(height: 20, width: 1, color: const Color(0xffE2E8F0)),

                // 3. Role Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: PopupMenuButton<String>(
                    initialValue: _selectedRole,
                    onSelected: (val) {
                      setState(() => _selectedRole = val);
                      widget.onRoleChanged?.call(val);
                    },
                    color: Colors.white,
                    itemBuilder: (ctx) => _roles
                        .map((r) => PopupMenuItem(value: r, child: Text(r)))
                        .toList(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.work_outline_rounded,
                            size: 15, color: Color(0xff64748B)),
                        const SizedBox(width: 3),
                        Text(
                          _selectedRole,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff334155),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 15, color: Color(0xff64748B)),
                      ],
                    ),
                  ),
                ),

                // 4. Creative Gradient Search Action Button
                GestureDetector(
                  onTap: () => widget.onSearch?.call(_searchController.text),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonGradientCreative,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_rounded,
                            size: 14, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          "Search",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── 3 Stat Badges Row
          Row(
            children: [
              Expanded(
                child: _buildStatCapsule(
                  icon: Icons.groups_rounded,
                  iconBg: const Color(0xff1D4ED8),
                  value: "12,400+",
                  label: "Creative Professionals",
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCapsule(
                  icon: Icons.cases_rounded,
                  iconBg: const Color(0xff0D9488),
                  value: "3,200+",
                  label: "Active Opportunities",
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCapsule(
                  icon: Icons.location_on_rounded,
                  iconBg: const Color(0xff7C3AED),
                  value: "28 Cities",
                  label: "Across India",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCapsule({
    required IconData icon,
    required Color iconBg,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, size: 13, color: Colors.white),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
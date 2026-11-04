import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigsHeaderSection extends StatefulWidget {
  final VoidCallback? onPostGigTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onCityTap;
  final ValueChanged<String>? onCategorySelected;
  final VoidCallback? onSortTap;

  const GigsHeaderSection({
    super.key,
    this.onPostGigTap,
    this.onNotificationsTap,
    this.onProfileTap,
    this.onSearch,
    this.onCityTap,
    this.onCategorySelected,
    this.onSortTap,
  });

  @override
  State<GigsHeaderSection> createState() => _GigsHeaderSectionState();
}

class _GigsHeaderSectionState extends State<GigsHeaderSection> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = "All GIGs";
  String _selectedCity = "Bangalore";
  String _selectedSort = "Best Match";

  final List<String> _quickTrends = const [
    "Fashion Photography",
    "Bridal MUA",
    "Brand Film",
    "Editorial Styling",
  ];

  final List<Map<String, dynamic>> _categories = const [
    {"label": "All GIGs", "icon": Icons.grid_view_rounded},
    {"label": "Photography", "icon": Icons.camera_alt_outlined},
    {"label": "Styling", "icon": Icons.interests_outlined},
    {"label": "Videography", "icon": Icons.videocam_outlined},
    {"label": "Makeup", "icon": Icons.brush_outlined},
    {"label": "Art Direction", "icon": Icons.auto_awesome_mosaic_outlined},
    {"label": "Modelling", "icon": Icons.person_outline_rounded},
    {"label": "Editing", "icon": Icons.tune_rounded},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 380;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color chipBg = isDark ? AppColors.surfaceDark : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Top Navigation Bar
        Container(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          padding: EdgeInsets.fromLTRB(14, topPadding + 6, 14, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.2,
                      ),
                      children: const [
                        TextSpan(text: "FOTO", style: TextStyle(color: Color(0xff1E293B))),
                        TextSpan(text: "VYB", style: TextStyle(color: Color(0xff0D9488))),
                      ],
                    ),
                  ),
                  const Text(
                    "A PREMIUM PHOTOGRAPHY MARKETPLACE",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 5.2,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: Color(0xff64748B),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: widget.onPostGigTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xffE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.view_in_ar_rounded, size: 15, color: Color(0xff10B981)),
                          const SizedBox(width: 4),
                          Text(
                            isSmallScreen ? "Post GIG" : "Post a GIG",
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: widget.onNotificationsTap,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xffE2E8F0)),
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xff1E293B),
                            size: 19,
                          ),
                        ),
                        Positioned(
                          top: 7,
                          right: 7,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xffEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: widget.onProfileTap,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xff0D9488), width: 1.8),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Hero Dark Gradient Banner
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff081927),
                Color(0xff0B2436),
                Color(0xff0E2F3D),
                Color(0xff0A1E29),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.fromLTRB(18, isSmallScreen ? 18 : 24, 18, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CREATIVE EXPERTISE. ON DEMAND.",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: Color(0xff7E9BB0),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.9,
                ),
              ),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: isSmallScreen ? 25 : 29,
                    fontWeight: FontWeight.w900,
                    height: 1.15,
                    letterSpacing: -0.4,
                  ),
                  children: const [
                    TextSpan(text: "Find the Perfect\n", style: TextStyle(color: Colors.white)),
                    TextSpan(text: "Creative GIG", style: TextStyle(color: Color(0xff34D399))),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Fixed pricing, fast delivery — across 28 cities",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildStatItem("4,800+", "GIGs")),
                  Expanded(child: _buildStatItem("1,200+", "Sellers")),
                  Expanded(child: _buildStatItem("4.8", "Avg Rating")),
                  Expanded(child: _buildStatItem("98%", "Satisfaction")),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // ── Search Bar with Embedded City Selector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, size: 20, color: Color(0xff94A3B8)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: widget.onSearch,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 12.5,
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "Photographer, Stylist, Art Director...",
                      hintStyle: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: textSecondary,
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Container(height: 22, width: 1, color: borderColor),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => widget.onCityTap?.call(_selectedCity),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 15, color: Color(0xff2E7D6E)),
                      const SizedBox(width: 4),
                      Text(
                        _selectedCity,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Color(0xff2E7D6E),
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ── Quick Trending Search Tags
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _quickTrends.map((trend) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = trend;
                  widget.onSearch?.call(trend);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: chipBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: borderColor),
                  ),
                  child: Text(
                    trend,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 14),

        // ── Category Filter Pills
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, idx) {
              final cat = _categories[idx];
              final isSelected = _selectedCategory == cat['label'];

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedCategory = cat['label'] as String);
                  widget.onCategorySelected?.call(cat['label'] as String);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.buttonGradientCreative : null,
                    color: isSelected ? null : chipBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : borderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        cat['icon'] as IconData,
                        size: 15,
                        color: isSelected ? Colors.white : const Color(0xff64748B),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        cat['label'] as String,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : const Color(0xff475569),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 18),

        // ── Result Count & Sort Dropdown Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 13,
                    color: textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: "4,836 ",
                      style: TextStyle(color: textColor, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(text: "GIGs in $_selectedCity"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: widget.onSortTap ?? () => _showSortModal(context, isDark),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: chipBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedSort,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: textColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.65),
          ),
        ),
      ],
    );
  }

  void _showSortModal(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final sortOptions = [
          "Best Match",
          "Price: Low to High",
          "Price: High to Low",
          "Fastest Delivery",
          "Top Rated",
        ];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: sortOptions.map((opt) {
                return ListTile(
                  title: Text(
                    opt,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 14,
                      fontWeight: _selectedSort == opt ? FontWeight.w800 : FontWeight.w500,
                      color: _selectedSort == opt ? const Color(0xff2E7D6E) : null,
                    ),
                  ),
                  trailing: _selectedSort == opt
                      ? const Icon(Icons.check, color: Color(0xff2E7D6E), size: 18)
                      : null,
                  onTap: () {
                    setState(() => _selectedSort = opt);
                    Navigator.pop(ctx);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
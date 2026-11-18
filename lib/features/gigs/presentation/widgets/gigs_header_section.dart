import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigsHeaderSection extends StatefulWidget {
  final String selectedCity;
  final String selectedCategory;
  final String selectedSort;
  final String searchQuery;
  final int totalGigsCount;
  final VoidCallback? onPostGigTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onCityChanged;
  final ValueChanged<String>? onCategorySelected;
  final ValueChanged<String>? onSortChanged;

  const GigsHeaderSection({
    super.key,
    required this.selectedCity,
    required this.selectedCategory,
    required this.selectedSort,
    required this.searchQuery,
    required this.totalGigsCount,
    this.onPostGigTap,
    this.onNotificationsTap,
    this.onProfileTap,
    this.onSearch,
    this.onCityChanged,
    this.onCategorySelected,
    this.onSortChanged,
  });

  @override
  State<GigsHeaderSection> createState() => _GigsHeaderSectionState();
}

class _GigsHeaderSectionState extends State<GigsHeaderSection> {
  late final TextEditingController _searchController;

  static const List<String> _quickTrends = [
    "Fashion Photography",
    "Bridal MUA",
    "Brand Film",
    "Editorial Styling",
  ];

  static const List<String> _cities = [
    "All Cities",
    "Bangalore",
    "Mumbai",
    "Delhi",
    "Hyderabad",
    "Chennai",
    "Pune",
  ];

  static const List<_GigCategoryOption> _categories = [
    _GigCategoryOption(label: "All GIGs", icon: Icons.grid_view_rounded),
    _GigCategoryOption(label: "Photography", icon: Icons.camera_alt_outlined),
    _GigCategoryOption(label: "Styling", icon: Icons.interests_outlined),
    _GigCategoryOption(label: "Videography", icon: Icons.videocam_outlined),
    _GigCategoryOption(label: "Makeup", icon: Icons.brush_outlined),
    _GigCategoryOption(
      label: "Art Direction",
      icon: Icons.auto_awesome_mosaic_outlined,
    ),
    _GigCategoryOption(label: "Modelling", icon: Icons.person_outline_rounded),
    _GigCategoryOption(label: "Editing", icon: Icons.tune_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(covariant GigsHeaderSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery &&
        _searchController.text != widget.searchQuery) {
      _searchController.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.paddingOf(context).top;

    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final chipBg = isDark ? AppColors.surfaceDark : Colors.white;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final hPad = screenW * 0.04;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Navigation Bar
            Container(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              padding: EdgeInsets.fromLTRB(
                hPad,
                topPadding + screenW * 0.015,
                hPad,
                screenW * 0.025,
              ),
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
                            fontSize: screenW * 0.046,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.2,
                          ),
                          children: [
                            TextSpan(
                              text: "FOTO",
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xff1E293B),
                              ),
                            ),
                            const TextSpan(
                              text: "VYB",
                              style: TextStyle(color: Color(0xff0D9488)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "A PREMIUM PHOTOGRAPHY MARKETPLACE",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: screenW * 0.014,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xff64748B),
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
                            horizontal: screenW * 0.03,
                            vertical: screenW * 0.016,
                          ),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.surfaceDark : Colors.white,
                            borderRadius:
                                BorderRadius.circular(screenW * 0.05),
                            border: Border.all(color: borderColor),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: screenW * 0.01,
                                offset: Offset(0, screenW * 0.005),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.view_in_ar_rounded,
                                size: screenW * 0.038,
                                color: const Color(0xff10B981),
                              ),
                              SizedBox(width: screenW * 0.011),
                              Text(
                                screenW < 380 ? "Post GIG" : "Post a GIG",
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: screenW * 0.03,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: screenW * 0.02),
                      GestureDetector(
                        onTap: widget.onNotificationsTap,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: screenW * 0.092,
                              height: screenW * 0.092,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.surfaceDark
                                    : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor),
                              ),
                              child: Icon(
                                Icons.notifications_none_rounded,
                                color: textColor,
                                size: screenW * 0.048,
                              ),
                            ),
                            Positioned(
                              top: screenW * 0.018,
                              right: screenW * 0.018,
                              child: Container(
                                width: screenW * 0.018,
                                height: screenW * 0.018,
                                decoration: const BoxDecoration(
                                  color: Color(0xffEF4444),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenW * 0.02),
                      GestureDetector(
                        onTap: widget.onProfileTap,
                        child: Container(
                          width: screenW * 0.092,
                          height: screenW * 0.092,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff0D9488),
                              width: 1.8,
                            ),
                            color: const Color(0xff0F766E),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: screenW * 0.048,
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
              padding: EdgeInsets.fromLTRB(
                screenW * 0.046,
                screenW * 0.055,
                screenW * 0.046,
                screenW * 0.055,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CREATIVE EXPERTISE. ON DEMAND.",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: const Color(0xff7E9BB0),
                      fontSize: screenW * 0.026,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.9,
                    ),
                  ),
                  SizedBox(height: screenW * 0.016),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: screenW * 0.072,
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                        letterSpacing: -0.4,
                      ),
                      children: const [
                        TextSpan(
                          text: "Find the Perfect\n",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "Creative GIG",
                          style: TextStyle(color: Color(0xff34D399)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenW * 0.02),
                  Text(
                    "Fixed pricing, fast delivery — across 28 cities",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: screenW * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenW * 0.05),
                  Row(
                    children: [
                      Expanded(child: _buildStatItem(screenW, "4,800+", "GIGs")),
                      Expanded(
                        child: _buildStatItem(screenW, "1,200+", "Sellers"),
                      ),
                      Expanded(
                        child: _buildStatItem(screenW, "4.8", "Avg Rating"),
                      ),
                      Expanded(
                        child: _buildStatItem(screenW, "98%", "Satisfaction"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: screenW * 0.036),

            // ── Search Bar with Embedded City Selector
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenW * 0.036,
                  vertical: screenW * 0.01,
                ),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(screenW * 0.072),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: screenW * 0.02,
                      offset: Offset(0, screenW * 0.008),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      size: screenW * 0.05,
                      color: const Color(0xff94A3B8),
                    ),
                    SizedBox(width: screenW * 0.02),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: widget.onSearch,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: screenW * 0.033,
                          color: textColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Photographer, Stylist, Art Director...",
                          hintStyle: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: textSecondary,
                            fontSize: screenW * 0.031,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: screenW * 0.028),
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          widget.onSearch?.call('');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: screenW * 0.02),
                          child: Icon(
                            Icons.close_rounded,
                            size: screenW * 0.042,
                            color: textSecondary,
                          ),
                        ),
                      ),
                    Container(
                      height: screenW * 0.055,
                      width: 1,
                      color: borderColor,
                    ),
                    SizedBox(width: screenW * 0.025),
                    GestureDetector(
                      onTap: () => _showCityModal(context, isDark, screenW),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: screenW * 0.038,
                            color: const Color(0xff2E7D6E),
                          ),
                          SizedBox(width: screenW * 0.01),
                          Text(
                            widget.selectedCity,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: const Color(0xff2E7D6E),
                              fontWeight: FontWeight.w700,
                              fontSize: screenW * 0.031,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: screenW * 0.03),

            // ── Quick Trending Search Tags
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Wrap(
                spacing: screenW * 0.02,
                runSpacing: screenW * 0.02,
                children: _quickTrends.map((trend) {
                  final isSelected = widget.searchQuery.toLowerCase() ==
                      trend.toLowerCase();
                  return GestureDetector(
                    onTap: () {
                      _searchController.text = trend;
                      widget.onSearch?.call(trend);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenW * 0.035,
                        vertical: screenW * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xff0D9488).withValues(alpha: 0.12)
                            : chipBg,
                        borderRadius: BorderRadius.circular(screenW * 0.06),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xff0D9488)
                              : borderColor,
                        ),
                      ),
                      child: Text(
                        trend,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: screenW * 0.03,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? const Color(0xff0D9488)
                              : textColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: screenW * 0.035),

            // ── Category Filter Pills
            SizedBox(
              height: screenW * 0.102,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: hPad),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => SizedBox(width: screenW * 0.02),
                itemBuilder: (ctx, idx) {
                  final cat = _categories[idx];
                  final isSelected = widget.selectedCategory == cat.label;

                  return GestureDetector(
                    onTap: () => widget.onCategorySelected?.call(cat.label),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenW * 0.035,
                        vertical: screenW * 0.02,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? AppColors.buttonGradientCreative
                            : null,
                        color: isSelected ? null : chipBg,
                        borderRadius: BorderRadius.circular(screenW * 0.06),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : borderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            cat.icon,
                            size: screenW * 0.038,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xff64748B),
                          ),
                          SizedBox(width: screenW * 0.015),
                          Text(
                            cat.label,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: screenW * 0.031,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xff475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: screenW * 0.042),

            // ── Result Count & Sort Dropdown Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: screenW * 0.033,
                          color: textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: "${widget.totalGigsCount} ",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: widget.selectedCity == 'All Cities'
                                ? "GIGs available"
                                : "GIGs in ${widget.selectedCity}",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenW * 0.025),
                  GestureDetector(
                    onTap: () => _showSortModal(context, isDark, screenW),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenW * 0.03,
                        vertical: screenW * 0.016,
                      ),
                      decoration: BoxDecoration(
                        color: chipBg,
                        borderRadius: BorderRadius.circular(screenW * 0.05),
                        border: Border.all(color: borderColor),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.selectedSort,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: screenW * 0.031,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          SizedBox(width: screenW * 0.01),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: screenW * 0.042,
                            color: textColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatItem(double screenW, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: screenW * 0.038,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: screenW * 0.005),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: screenW * 0.025,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.65),
          ),
        ),
      ],
    );
  }

  void _showCityModal(BuildContext context, bool isDark, double screenW) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenW * 0.05),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenW * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _cities.map((city) {
                final isSelected = widget.selectedCity == city;
                return ListTile(
                  title: Text(
                    city,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: screenW * 0.036,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w500,
                      color: isSelected ? const Color(0xff2E7D6E) : null,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check,
                          color: const Color(0xff2E7D6E),
                          size: screenW * 0.046,
                        )
                      : null,
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.onCityChanged?.call(city);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showSortModal(BuildContext context, bool isDark, double screenW) {
    const sortOptions = [
      "Best Match",
      "Price: Low to High",
      "Price: High to Low",
      "Fastest Delivery",
      "Top Rated",
      "Newest",
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenW * 0.05),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenW * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: sortOptions.map((opt) {
                final isSelected = widget.selectedSort == opt;
                return ListTile(
                  title: Text(
                    opt,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: screenW * 0.036,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w500,
                      color: isSelected ? const Color(0xff2E7D6E) : null,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check,
                          color: const Color(0xff2E7D6E),
                          size: screenW * 0.046,
                        )
                      : null,
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.onSortChanged?.call(opt);
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

class _GigCategoryOption {
  final String label;
  final IconData icon;

  const _GigCategoryOption({
    required this.label,
    required this.icon,
  });
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class TopBarSection extends StatefulWidget {
  final VoidCallback? onPostGigTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onCityChanged;
  final ValueChanged<String>? onCategoryChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final VoidCallback? onSortTap;

  const TopBarSection({
    super.key,
    this.onPostGigTap,
    this.onNotificationsTap,
    this.onProfileTap,
    this.onCityChanged,
    this.onCategoryChanged,
    this.onSearchSubmitted,
    this.onSortTap,
  });

  @override
  State<TopBarSection> createState() => _TopBarSectionState();
}

class _TopBarSectionState extends State<TopBarSection> {
  String selectedCity = "Mumbai";
  String selectedCategory = "All";
  final TextEditingController searchController = TextEditingController();

  final List<String> cities = const [
    "Mumbai",
    "Bangalore",
    "Delhi NCR",
    "Hyderabad",
    "Goa",
    "Pune",
  ];

  final List<String> categories = const [
    "All",
    "Photographer",
    "Stylist",
    "Model",
    "Videographer",
    "Makeup Artist",
    "Art Director",
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 380;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Responsive Top Navigation Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 6, 14, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flexible Brand Logo
              Flexible(
                child: Column(
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
                          TextSpan(
                            text: "FOTO",
                            style: TextStyle(color: Color(0xff1E293B)),
                          ),
                          TextSpan(
                            text: "VYB",
                            style: TextStyle(color: Color(0xff0D9488)),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "A PREMIUM PHOTOGRAPHY MARKETPLACE",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
              ),
              const SizedBox(width: 8),

              // Action Buttons Row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // "Post a GIG" Compact Pill Button
                  GestureDetector(
                    onTap: widget.onPostGigTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 11,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.view_in_ar_rounded,
                            size: 15,
                            color: Color(0xff10B981),
                          ),
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
                  const SizedBox(width: 6),

                  // Notification Icon with Unread Indicator
                  GestureDetector(
                    onTap: widget.onNotificationsTap,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xffE2E8F0)),
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xff1E293B),
                            size: 18,
                          ),
                        ),
                        Positioned(
                          top: 7,
                          right: 7,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xffEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),

                  // User Avatar
                  GestureDetector(
                    onTap: widget.onProfileTap,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xff0D9488), width: 1.5),
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

        // ── 2. Hero Dark Gradient Banner
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff0C2033),
                Color(0xff0F2B3E),
                Color(0xff133544),
                Color(0xff0E2734),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.fromLTRB(16, isSmallScreen ? 16 : 20, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tagline
              const Text(
                "INDIA'S CREATIVE TALENT NETWORK",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: Color(0xff7E9BB0),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.9,
                ),
              ),
              const SizedBox(height: 5),

              // Main Headline
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: isSmallScreen ? 22 : 25,
                    fontWeight: FontWeight.w900,
                    height: 1.15,
                    letterSpacing: -0.3,
                  ),
                  children: const [
                    TextSpan(text: "Discover. Connect.\n", style: TextStyle(color: Colors.white)),
                    TextSpan(
                      text: "Collaborate.",
                      style: TextStyle(color: Color(0xff34D399)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),

              // Subtitle
              Text(
                "Fixed pricing, fast delivery — across 28 cities",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),

              // Responsive Stats Grid Row (Equal Distribution)
              Row(
                children: [
                  Expanded(child: _buildStatItem("4,800+", "GIGs")),
                  Expanded(child: _buildStatItem("1,200+", "Sellers")),
                  Expanded(child: _buildStatItem("4.8", "Avg Rating")),
                  Expanded(child: _buildStatItem("98%", "Satisfaction")),
                ],
              ),
              const SizedBox(height: 18),

              // Integrated Search Box
              Container(
                padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, size: 20, color: Color(0xff64748B)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: widget.onSearchSubmitted,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 12,
                          color: Color(0xff0F172A),
                        ),
                        decoration: const InputDecoration(
                          hintText: "Search stylists, photographers...",
                          hintStyle: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Color(0xff64748B),
                            fontSize: 11.5,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1C4A57),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                          vertical: 9,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => widget.onSearchSubmitted?.call(searchController.text),
                      child: const Text(
                        "Search",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // City Browsing Header
              Row(
                children: const [
                  Icon(Icons.location_on_outlined, size: 13, color: Color(0xff94A3B8)),
                  SizedBox(width: 4),
                  Text(
                    "Browse by city",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // City Filter Chips
              SizedBox(
                height: 34,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cities.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (ctx, idx) {
                    final city = cities[idx];
                    final isSelected = selectedCity == city;

                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedCity = city);
                        widget.onCityChanged?.call(city);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xff223A4E).withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          city,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? const Color(0xff0F172A) : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // ── 3. Category Filter Chips
        const SizedBox(height: 12),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, idx) {
              final cat = categories[idx];
              final isSelected = selectedCategory == cat;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedCategory = cat);
                  widget.onCategoryChanged?.call(cat);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xff1C4A57)
                        : (isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cat,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : textSecondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // ── 4. Search Summary & Sort Trigger
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "284 professionals found in $selectedCity",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),
              GestureDetector(
                onTap: widget.onSortTap,
                child: Row(
                  children: [
                    Icon(Icons.swap_vert_rounded, size: 17, color: textColor),
                    const SizedBox(width: 3),
                    Text(
                      "Sort",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                  ],
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
        const SizedBox(height: 1),
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
}
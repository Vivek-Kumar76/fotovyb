import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedCategory = "All";
  String selectedCity = "All Cities";
  String searchQuery = "";
  final TextEditingController searchCtrl = TextEditingController();

  final List<String> categories = const [
    "All",
    "Photographers",
    "Fashion Stylists",
    "Makeup Artists",
    "Videographers",
    "Models",
    "Art Directors",
    "Retouchers",
  ];

  final List<String> cities = const [
    "All Cities",
    "Mumbai",
    "Delhi NCR",
    "Bangalore",
    "Hyderabad",
    "Goa",
    "Pune",
  ];

  final List<Map<String, dynamic>> allTalents = const [
    {
      "id": "t1",
      "name": "Mei Lin",
      "role": "Fashion Stylist",
      "category": "Fashion Stylists",
      "city": "Mumbai",
      "rating": 4.9,
      "reviews": 47,
      "dayRate": "₹12,000",
      "badge": "Top Rated",
      "verified": true,
      "cover": "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=600",
      "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
      "tags": ["Editorial", "Runway", "Lookbook"],
    },
    {
      "id": "t2",
      "name": "Kofi Mensah",
      "role": "Commercial Photographer",
      "category": "Photographers",
      "city": "Bangalore",
      "rating": 4.8,
      "reviews": 83,
      "dayRate": "₹18,000",
      "badge": "Featured",
      "verified": true,
      "cover": "https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=600",
      "avatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100",
      "tags": ["Automotive", "Luxury", "Campaign"],
    },
    {
      "id": "t3",
      "name": "Priya Nair",
      "role": "Bridal & Luxury MUA",
      "category": "Makeup Artists",
      "city": "Delhi NCR",
      "rating": 4.7,
      "reviews": 39,
      "dayRate": "₹8,500",
      "badge": "Rising Star",
      "verified": true,
      "cover": "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=600",
      "avatar": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100",
      "tags": ["Bridal", "HD Makeup", "Editorial"],
    },
    {
      "id": "t4",
      "name": "Arjun Kapoor",
      "role": "Automotive & Brand Filmmaker",
      "category": "Videographers",
      "city": "Hyderabad",
      "rating": 4.9,
      "reviews": 61,
      "dayRate": "₹22,000",
      "badge": "Top Rated",
      "verified": true,
      "cover": "https://images.unsplash.com/photo-1536240478700-b869070f9279?w=600",
      "avatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
      "tags": ["Reels", "Commercials", "Grading"],
    },
    {
      "id": "t5",
      "name": "Zara Okonkwo",
      "role": "High-End Photo Retoucher",
      "category": "Retouchers",
      "city": "Bangalore",
      "rating": 4.8,
      "reviews": 26,
      "dayRate": "₹6,000",
      "badge": "New",
      "verified": false,
      "cover": "https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=600",
      "avatar": "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=100",
      "tags": ["E-Commerce", "Skin Retouch", "Color"],
    },
    {
      "id": "t6",
      "name": "Marco Bianchi",
      "role": "Fashion Model",
      "category": "Models",
      "city": "Mumbai",
      "rating": 4.9,
      "reviews": 113,
      "dayRate": "₹15,000",
      "badge": "Pro Seller",
      "verified": true,
      "cover": "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=600",
      "avatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100",
      "tags": ["Runway", "Commercial", "Catalog"],
    },
  ];

  List<Map<String, dynamic>> get filteredTalents {
    return allTalents.where((t) {
      final matchesCategory = selectedCategory == "All" || t['category'] == selectedCategory;
      final matchesCity = selectedCity == "All Cities" || t['city'] == selectedCity;
      final matchesQuery = searchQuery.isEmpty ||
          (t['name'] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (t['role'] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (t['tags'] as List<String>).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesCity && matchesQuery;
    }).toList();
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.surfaceDark
          : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

            return Padding(
              padding: const EdgeInsets.all(AppSpacing.space5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter by City",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeLg,
                          fontWeight: AppTypography.bold,
                          color: textColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => selectedCity = "All Cities");
                          Navigator.pop(ctx);
                        },
                        child: const Text("Reset"),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space3),
                  Wrap(
                    spacing: AppSpacing.space2,
                    runSpacing: AppSpacing.space2,
                    children: cities.map((city) {
                      final isSelected = selectedCity == city;
                      return ChoiceChip(
                        label: Text(city),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => selectedCity = city);
                          Navigator.pop(ctx);
                        },
                        selectedColor: AppColors.primary,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : textColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header & Search Input
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space4,
                AppSpacing.space3,
                AppSpacing.space4,
                AppSpacing.space2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discover Talent",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.size2Xl,
                              fontWeight: AppTypography.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Find vetted creative professionals across India",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.sizeXs,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: _showFilterModal,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: selectedCity == "All Cities"
                                ? surfaceColor
                                : activeColor.withValues(alpha: 0.15),
                            borderRadius: AppRadius.radiusFull,
                            border: Border.all(
                              color: selectedCity == "All Cities" ? borderColor : activeColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                size: 14,
                                color: selectedCity == "All Cities" ? textSecondary : activeColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                selectedCity,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: AppTypography.sizeXs,
                                  fontWeight: AppTypography.bold,
                                  color: selectedCity == "All Cities" ? textColor : activeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space3),

                  // Search Bar
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: AppRadius.radiusFull,
                      border: Border.all(color: borderColor),
                      boxShadow: isDark ? null : AppShadows.sm,
                    ),
                    child: TextField(
                      controller: searchCtrl,
                      onChanged: (val) => setState(() => searchQuery = val.trim()),
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        color: textColor,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search stylists, photographers, MUAs...",
                        hintStyle: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeSm,
                          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                        ),
                        prefixIcon: Icon(Icons.search_rounded, color: textSecondary, size: 20),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close_rounded, size: 16),
                                onPressed: () {
                                  searchCtrl.clear();
                                  setState(() => searchQuery = "");
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Categories Horizontal Filter Bar
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
                itemCount: categories.length,
                itemBuilder: (ctx, idx) {
                  final cat = categories[idx];
                  final isSelected = selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.space2),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? activeColor
                              : (isDark ? AppColors.surfaceSecondaryDark : surfaceColor),
                          borderRadius: AppRadius.radiusFull,
                          border: Border.all(
                            color: isSelected ? activeColor : borderColor,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: AppTypography.sizeXs + 0.5,
                            fontWeight: isSelected ? AppTypography.bold : AppTypography.medium,
                            color: isSelected ? Colors.white : textColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.space3),

            // ── Discovery Talent Grid
            Expanded(
              child: filteredTalents.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_search_rounded, size: 48, color: textSecondary),
                          const SizedBox(height: AppSpacing.space2),
                          Text(
                            "No professionals found",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.sizeMd,
                              fontWeight: AppTypography.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Try altering your search keywords or city filter",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.sizeXs,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space4),
                      itemCount: filteredTalents.length,
                      itemBuilder: (ctx, idx) {
                        return _buildDiscoverCard(context, filteredTalents[idx], isDark);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscoverCard(BuildContext context, Map<String, dynamic> pro, bool isDark) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color tagBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.space4),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: AppRadius.radiusLg,
        border: Border.all(color: borderColor),
        boxShadow: isDark ? null : AppShadows.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cover Image with Overlay Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                child: Image.network(
                  pro['cover'] as String,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 150,
                    color: tagBg,
                    child: Center(
                      child: Icon(Icons.image_outlined, color: textMuted, size: 32),
                    ),
                  ),
                ),
              ),

              // Gradient Shade at Bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Badge
              Positioned(
                top: AppSpacing.space2,
                left: AppSpacing.space2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: AppRadius.radiusSm,
                  ),
                  child: Text(
                    pro['badge'] as String,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: AppTypography.sizeXs - 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Day Rate on Bottom Right
              Positioned(
                bottom: AppSpacing.space2,
                right: AppSpacing.space3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      pro['dayRate'] as String,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: AppTypography.sizeMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "/ day",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: AppTypography.sizeXs - 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ── Pro Profile Info & Action Row
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(pro['avatar'] as String),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                pro['name'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontWeight: AppTypography.bold,
                                  fontSize: AppTypography.sizeSm + 0.5,
                                  color: textColor,
                                ),
                              ),
                              if (pro['verified'] == true) ...[
                                const SizedBox(width: 4),
                                const Icon(Icons.verified_rounded, size: 14, color: AppColors.primary),
                              ],
                            ],
                          ),
                          Text(
                            "${pro['role']} · 📍 ${pro['city']}",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.sizeXs,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xff451A03) : const Color(0xffFEF3C7),
                        borderRadius: AppRadius.radiusSm,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 13, color: Color(0xffD97706)),
                          const SizedBox(width: 2),
                          Text(
                            "${pro['rating']}",
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontWeight: FontWeight.bold,
                              fontSize: AppTypography.sizeXs,
                              color: Color(0xffD97706),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space2),

                // Tags
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: (pro['tags'] as List<String>).map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: tagBg,
                        borderRadius: AppRadius.radiusSm,
                        border: Border.all(color: borderColor),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeXs - 2,
                          color: textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.space3),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: activeColor,
                          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 0,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Connecting with ${pro['name']}..."),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                        icon: const Icon(Icons.person_add_alt_1_rounded, size: 14, color: Colors.white),
                        label: const Text(
                          "Connect",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: AppTypography.sizeXs,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Expanded(
                      flex: 2,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: borderColor),
                          shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Portfolio",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: textColor,
                            fontSize: AppTypography.sizeXs,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
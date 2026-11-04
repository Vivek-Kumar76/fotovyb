import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../widgets/co_01_gig_media_gallery.dart';
import '../widgets/co_02_gig_header_seller.dart';
import '../widgets/co_03_gig_pricing_tabs.dart';
import '../widgets/co_04_gig_about_specs.dart';
import '../widgets/co_05_gig_reviews_section.dart';
import '../widgets/co_06_complementary_gigs.dart';
import '../widgets/gig_sticky_bottom_bar.dart';

class GigDetailsPage extends StatefulWidget {
  final Map<String, dynamic>? gigData;

  const GigDetailsPage({super.key, this.gigData});

  @override
  State<GigDetailsPage> createState() => _GigDetailsPageState();
}

class _GigDetailsPageState extends State<GigDetailsPage> {
  int _selectedTierIndex = 1; // 0: Basic, 1: Standard (Popular), 2: Premium

  final List<Map<String, dynamic>> _tiers = const [
    {
      "name": "Basic",
      "price": "₹8,000",
      "subtitle": "Half day, 50 shots, edited",
      "delivery": "2-3 days",
      "revisions": "1 revision",
      "features": [
        "4 hour session",
        "50 edited images",
        "Basic color grade",
        "1 revision",
      ],
    },
    {
      "name": "Standard",
      "price": "₹15,000",
      "subtitle": "Full day, 150 shots, edited",
      "delivery": "2-3 days",
      "revisions": "2 revisions",
      "isPopular": true,
      "features": [
        "8 hour session",
        "150 edited images",
        "Advanced color grade",
        "2 revisions",
        "Behind-the-scenes",
      ],
    },
    {
      "name": "Premium",
      "price": "₹40,000",
      "subtitle": "Campaign week, 500 shots + film",
      "delivery": "4-5 days",
      "revisions": "Unlimited",
      "features": [
        "3 day campaign",
        "500+ edited images",
        "Professional color grade",
        "Unlimited revisions",
        "2 min brand film",
        "On-set director",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeTier = _tiers[_selectedTierIndex];

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text(
          "GIG Details",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Block 01: Media Gallery Carousel
            const GigMediaGallery(),

            // ── Block 02: Header, Title & Seller Profile
            const GigHeaderSeller(),

            const SizedBox(height: AppSpacing.space3),

            // ── Block 03: Segmented 3-Tier Pricing Packages
            GigPricingTabs(
              tiers: _tiers,
              selectedIndex: _selectedTierIndex,
              onTierSelected: (idx) => setState(() => _selectedTierIndex = idx),
            ),

            const SizedBox(height: AppSpacing.space4),

            // ── Block 04: About Description & Tags (Specialties & Industries)
            const GigAboutSpecs(),

            const SizedBox(height: AppSpacing.space4),

            // ── Block 05: Ratings & Customer Reviews
            const GigReviewsSection(),

            const SizedBox(height: AppSpacing.space4),

            // ── Block 06: Complementary Services Horizontal List
            const ComplementaryGigs(),

            const SizedBox(height: 100), // Spacing for Sticky Action Bar
          ],
        ),
      ),

      // ── Fixed Sticky Bottom Bar
      bottomNavigationBar: GigStickyBottomBar(
        packageName: activeTier['name'] as String,
        packagePrice: activeTier['price'] as String,
        onChoosePackageTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Selected ${activeTier['name']} Package (${activeTier['price']})"),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        onContactSellerTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Opening direct chat with Kofi Mensah..."),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }
}
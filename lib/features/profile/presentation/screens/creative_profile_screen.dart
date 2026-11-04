import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../widgets/profile_hero_section.dart';
import '../widgets/profile_portfolio_skills_section.dart';
import '../widgets/profile_commercials_trust_section.dart';
import '../widgets/profile_similar_pros_section.dart';
import '../widgets/profile_sticky_bottom_bar.dart';

class CreativeProfileScreen extends StatefulWidget {
  const CreativeProfileScreen({super.key});

  @override
  State<CreativeProfileScreen> createState() => _CreativeProfileScreenState();
}

class _CreativeProfileScreenState extends State<CreativeProfileScreen> {
  int _selectedPricingIndex = 1; // Default to 'Full Day' (Most popular)

  // ── Global Keys for in-page smooth scroll anchoring
  final GlobalKey _overviewKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _packagesKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();

  void _scrollToSection(int index) {
    GlobalKey? targetKey;
    switch (index) {
      case 0:
        targetKey = _overviewKey;
        break;
      case 1:
        targetKey = _portfolioKey;
        break;
      case 2:
        targetKey = _packagesKey;
        break;
      case 3:
        targetKey = _reviewsKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
        alignment: 0.06, // Leaves breathing room at the top
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Hero Cover, Avatar, Identity, Stats & Booking Box
            ProfileHeroSection(
              onBack: () => Navigator.of(context).maybePop(),
              onBookSession: () {
                // Open booking flow or bottom sheet
              },
            ),

            const SizedBox(height: 20),

            // ── 2. Tabs + Overview (About & Stats) + Portfolio (Grid) + Skills
            ProfilePortfolioSkillsSection(
              overviewKey: _overviewKey,
              portfolioKey: _portfolioKey,
              onTabTap: _scrollToSection,
            ),

            const SizedBox(height: 20),

            // ── 3. Packages (Pricing Tiers) + Client Reviews + Certifications
            ProfileCommercialsTrustSection(
              packagesKey: _packagesKey,
              reviewsKey: _reviewsKey,
              selectedPricingIndex: _selectedPricingIndex,
              onSelectPricing: (index) {
                setState(() => _selectedPricingIndex = index);
              },
            ),

            const SizedBox(height: 20),

            // ── 4. Similar Professionals List
            const ProfileSimilarProsSection(),

            // Bottom clearance so content scrolls above sticky bottom bar
            const SizedBox(height: 100),
          ],
        ),
      ),

      // ── Pinned Bottom Bar (From ₹11,000 + Book CTA + Chat)
      bottomNavigationBar: ProfileStickyBottomBar(
        priceText: "₹11,000",
        onBookSession: () {
          // Trigger booking modal / flow
        },
        onChatTap: () {
          // Open direct messaging
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/subscription_plan_model.dart';
import '../widgets/01_subscription_hero_section.dart';
import '../widgets/02_subscription_active_card.dart';
import '../widgets/03_subscription_tiers_section.dart';
import '../widgets/04_subscription_addons_section.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selectedDuration = "30 Days";
  String _selectedPlanId = "pro"; // Default focused plan

  // ── Plan Definitions directly from your spreadsheet
  final List<SubscriptionPlan> _allPlans = const [
    SubscriptionPlan(
      id: "free",
      name: "Free Tier",
      price: 0,
      duration: "7 DAYS",
      tag: "NEW",
      tagColor: Color(0xff10B981),
      description: "Trial entry for testing marketplace features",
      includedFeatures: [
        "Post profile: 2 Photos & 0 Videos",
        "Follow Creative Professionals & Brands",
        "Basic Profile listing",
        "Inbox Messaging (1 Connection)",
        "Chat (1 Connection)",
        "Opportunity to Apply (5 jobs)",
      ],
      excludedFeatures: [
        "Social media, phone & email reveal (0)",
        "GIG Postings (0 gigs)",
        "Search Booster & Homepage visibility",
      ],
      support: "NA",
      gigAddonQuota: "More GIGS (10)",
    ),
    SubscriptionPlan(
      id: "standard",
      name: "Standard Tier",
      price: 500,
      duration: "30 DAYS",
      description: "For active freelance creators growing client orders",
      includedFeatures: [
        "Post profile: 5 Photos (1MB/each) & 1 Video (50MB)",
        "Following Unlimited Creative Pros & Brands",
        "Enhanced Profile Visibility in city",
        "Inbox Messaging (5 Connections)",
        "Chat (10 Connections — Unlimited messages)",
        "Social Media, Mobile & Email On Request",
        "Gig Postings: 2 Active GIGs",
        "Opportunity to Apply (10 briefs)",
      ],
      support: "Chat Support",
      gigAddonQuota: "More GIGS (15)",
    ),
    SubscriptionPlan(
      id: "pro",
      name: "Pro Tier",
      price: 800,
      duration: "30 DAYS",
      tag: "MOST POPULAR",
      tagColor: Color(0xffD97706),
      description: "For established professionals seeking regular briefs",
      includedFeatures: [
        "Post profile: 10 Photos & 3 Videos",
        "Following Unlimited Pros & Brands",
        "Search Booster high-placement badge",
        "Inbox Messaging (10 Connections)",
        "Chat (25 Connections — Unlimited messages)",
        "Social Media, Mobile & Email On Request",
        "Gig Postings: 4 Active GIGs",
        "Opportunity to Apply (20 briefs)",
      ],
      support: "Chat & Email",
      gigAddonQuota: "More GIGS (20)",
    ),
    SubscriptionPlan(
      id: "elite",
      name: "Elite Tier",
      price: 1000,
      duration: "30 DAYS",
      tag: "FEATURED",
      tagColor: Color(0xff7C3AED),
      description: "Top-tier creative dominance with priority support",
      includedFeatures: [
        "Post profile: 20 Photos & 5 Videos",
        "Following Unlimited Pros & Brands",
        "Homepage & Search Priority Top Visibility",
        "Inbox Messaging (20 Connections)",
        "Chat (50 Connections — Unlimited messages)",
        "Social Media, Mobile & Email On Request",
        "Gig Postings: 8 Active GIGs",
        "Opportunity to Apply (30 briefs)",
      ],
      support: "Priority Chat, Email & Call",
      gigAddonQuota: "More GIGS (25)",
    ),
  ];

  // ── Addon Definitions with Prices
  final List<SubscriptionAddon> _addons = [
    SubscriptionAddon(
      id: "addon_gigs_10",
      title: "More GIGs (+10 Pack)",
      subtitle: "Add 10 extra active gig listings to your profile",
      price: 199,
      icon: Icons.view_in_ar_rounded,
      iconBg: const Color(0xffE6F4F1),
      iconColor: const Color(0xff0D9488),
    ),
    SubscriptionAddon(
      id: "addon_search_boost",
      title: "Search Booster (7 Days)",
      subtitle: "Top placement in photographer & stylist searches",
      price: 249,
      icon: Icons.rocket_launch_rounded,
      iconBg: const Color(0xffFEF3C7),
      iconColor: const Color(0xffD97706),
    ),
    SubscriptionAddon(
      id: "addon_spotlight",
      title: "Homepage Spotlight (3 Days)",
      subtitle: "Featured in the top hero discovery banner",
      price: 399,
      icon: Icons.auto_awesome_rounded,
      iconBg: const Color(0xffEDE9FE),
      iconColor: const Color(0xff7C3AED),
    ),
    SubscriptionAddon(
      id: "addon_video_slot",
      title: "Extra Video Slot (+1)",
      subtitle: "Upload 1 additional 100MB portfolio showreel",
      price: 149,
      icon: Icons.videocam_rounded,
      iconBg: const Color(0xffDBEAFE),
      iconColor: const Color(0xff2563EB),
    ),
  ];

  int get _addonsTotal {
    return _addons
        .where((a) => a.isSelected)
        .fold(0, (sum, item) => sum + item.price);
  }

  SubscriptionPlan get _selectedPlan {
    return _allPlans.firstWhere(
      (p) => p.id == _selectedPlanId,
      orElse: () => _allPlans[1],
    );
  }

  int get _grandTotal => _selectedPlan.price + _addonsTotal;

  void _toggleAddon(String id) {
    setState(() {
      final addon = _addons.firstWhere((a) => a.id == id);
      addon.isSelected = !addon.isSelected;
    });
  }

  void _showCheckoutSummary() {
    final selectedAddonsList = _addons.where((a) => a.isSelected).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.surfaceDark
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.textPrimaryDark
                      : const Color(0xff1E293B),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${_selectedPlan.name} (${_selectedPlan.duration})",
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text("₹${_selectedPlan.price}",
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
              if (selectedAddonsList.isNotEmpty) ...[
                const SizedBox(height: 10),
                const Text("Add-ons:",
                    style: TextStyle(fontSize: 12, color: Color(0xff64748B))),
                ...selectedAddonsList.map((a) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("• ${a.title}",
                              style: const TextStyle(fontSize: 12)),
                          Text("+ ₹${a.price}",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
              ],
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Payable:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text("₹$_grandTotal",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff0D9488))),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Activating ${_selectedPlan.name} (₹$_grandTotal)...",
                      ),
                      backgroundColor: const Color(0xff2E7D6E),
                    ),
                  );
                },
                child: Container(
                  height: 46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradientCreative,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Confirm & Pay",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── 1. Hero Banner with Duration Toggle
                SubscriptionHeroSection(
                  selectedDuration: _selectedDuration,
                  onDurationChanged: (dur) =>
                      setState(() => _selectedDuration = dur),
                ),

                // ── 2. Current Status Indicator
                const SubscriptionActiveCard(activePlanName: "Free Tier"),

                const SizedBox(height: 12),

                // ── 3. Zoomable/Highlighted Tiers List
                SubscriptionTiersSection(
                  plans: _allPlans,
                  selectedPlanId: _selectedPlanId,
                  addonsTotal: _addonsTotal,
                  onPlanSelected: (id) =>
                      setState(() => _selectedPlanId = id),
                  onProceed: _showCheckoutSummary,
                ),

                const SizedBox(height: 20),

                // ── 4. Add-ons Section (Dynamic Total Increments)
                SubscriptionAddonsSection(
                  addons: _addons,
                  onToggleAddon: _toggleAddon,
                ),
              ],
            ),
          ),

          // ── Sticky Floating Bottom Checkout Bar (Active when Add-ons or Paid Plan Chosen)
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff0F172A) : const Color(0xff1E293B),
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
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_selectedPlan.name} ${(_addonsTotal > 0) ? '+ Add-ons' : ''}",
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          "Total: ₹$_grandTotal",
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Color(0xff34D399),
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _showCheckoutSummary,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: AppColors.buttonGradientCreative,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "Proceed",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded,
                              size: 14, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
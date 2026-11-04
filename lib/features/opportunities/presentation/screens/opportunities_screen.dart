import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../widgets/opportunities_filter_drawer.dart';

class OpportunitiesScreen extends StatelessWidget {
  const OpportunitiesScreen({super.key});

  void _showNotice(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xff2E7D6E),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
      // ── End Drawer: Filter panel opens from right
      endDrawer: OpportunitiesFilterDrawer(
        onClearAll: () => _showNotice(context, "Filters reset"),
        onApply: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Top Navigation Bar (Logo + Notification + Filter Funnel)
            Container(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              padding: EdgeInsets.fromLTRB(16, topPadding + 6, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
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
                        style: TextStyle(
                          fontSize: 5.2,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: Color(0xff64748B),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildCircleBtn(
                        icon: Icons.notifications_none_rounded,
                        onTap: () => _showNotice(context, "Notifications"),
                      ),
                      const SizedBox(width: 8),
                      // Builder scope triggers endDrawer correctly
                      Builder(
                        builder: (drawerCtx) {
                          return _buildCircleBtn(
                            icon: Icons.filter_alt_outlined,
                            onTap: () => Scaffold.of(drawerCtx).openEndDrawer(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── 2. Dark Hero Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff081927),
                    Color(0xff0B2436),
                    Color(0xff0E2F3D),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Service Opportunities",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Connect with top brands",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── 3. High Priority Section (Image 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 3.5,
                    backgroundColor: Color(0xffEF4444),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "High Priority",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _buildCountBadge("2", const Color(0xffEF4444)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            _buildHighPriorityCard(
              imageUrl:
                  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=800&auto=format&fit=crop",
              title: "Campaign Photographer & Stylist for EV Launch",
              location: "Bangalore",
              duration: "3 days",
              tags: ["Photographer", "Stylist"],
              price: "₹85,000",
              onApply: () => _showNotice(context, "Applied to EV Launch"),
            ),
            const SizedBox(height: 14),

            _buildHighPriorityCard(
              imageUrl:
                  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=800&auto=format&fit=crop",
              title: "Luxury Hotel Brand Film — Goa Property Launch",
              location: "Goa",
              duration: "7 days",
              tags: ["Videographer", "Director"],
              price: "₹1,20,000",
              onApply: () => _showNotice(context, "Applied to Goa Launch"),
            ),

            const SizedBox(height: 26),

            // ── 4. Boosted Section (Image 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 3.5,
                    backgroundColor: Color(0xffD97706),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Boosted",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _buildCountBadge("3", const Color(0xffD97706)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            _buildBoostedCard(
              imageUrl:
                  "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=400&auto=format&fit=crop",
              brand: "VOGUE INDIA",
              title: "Editorial Cover Shoot — February Issue",
              desc: "Senior editorial photographer for...",
              tags: ["Photographer", "MUA"],
              price: "₹60,000",
              isDark: isDark,
              borderColor: borderColor,
              cardBg: cardBg,
              textColor: textColor,
              onApply: () => _showNotice(context, "Applied to Vogue India"),
            ),
            const SizedBox(height: 10),

            _buildBoostedCard(
              imageUrl:
                  "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=400&auto=format&fit=crop",
              brand: "ONEPLUS INDIA",
              title: "Tech Product Launch — Multi-Platform Campaign",
              desc: "Comprehensive tech launch campaign...",
              tags: ["Photographer", "Videographer"],
              price: "₹1,80,000",
              isDark: isDark,
              borderColor: borderColor,
              cardBg: cardBg,
              textColor: textColor,
              onApply: () => _showNotice(context, "Applied to OnePlus India"),
            ),
            const SizedBox(height: 10),

            _buildBoostedCard(
              imageUrl:
                  "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=400&auto=format&fit=crop",
              brand: "NYKAA",
              title: "Beauty Brand Content Series — 15 Videos",
              desc: "Beauty brand social content with...",
              tags: ["Videographer", "MUA"],
              price: "₹50,000",
              isDark: isDark,
              borderColor: borderColor,
              cardBg: cardBg,
              textColor: textColor,
              onApply: () => _showNotice(context, "Applied to Nykaa"),
            ),

            const SizedBox(height: 24),

            // ── 5. Bundle Discount Promo Card (Image 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff0F2430)
                      : const Color(0xffF0FDFA),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xff0D9488).withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Need Multiple Services? Get 20% Off",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Bundle photography, videography & styling services for discounts",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _showNotice(context, "Opening Packages..."),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff0D9488),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "View Packages",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── 6. Featured 2x2 Grid (Image 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 3.5,
                    backgroundColor: Color(0xff0D9488),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Featured",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _buildCountBadge("4", const Color(0xff0D9488)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeaturedGridCard(
                          icon: Icons.diamond_outlined,
                          iconBg: const Color(0xffFEF3C7),
                          iconColor: const Color(0xffD97706),
                          title: "Jewellery Campaign — Bridal",
                          subtitle: "Premium jewellery bridal...",
                          location: "Delhi",
                          tags: ["Photographer", "Stylist"],
                          price: "₹95,000",
                          cardBg: cardBg,
                          borderColor: borderColor,
                          textColor: textColor,
                          textSecondary: textSecondary,
                          onView: () => _showNotice(context, "Jewellery"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeaturedGridCard(
                          icon: Icons.show_chart_rounded,
                          iconBg: const Color(0xffCCFBF1),
                          iconColor: const Color(0xff0D9488),
                          title: "Sports Campaign — Outdoor Shoot",
                          subtitle: "Athleisure brand campaign",
                          location: "Pune",
                          tags: ["Photographer", "Model"],
                          price: "₹65,000",
                          cardBg: cardBg,
                          borderColor: borderColor,
                          textColor: textColor,
                          textSecondary: textSecondary,
                          onView: () => _showNotice(context, "Sports"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeaturedGridCard(
                          icon: Icons.coffee_outlined,
                          iconBg: const Color(0xffFEF3C7),
                          iconColor: const Color(0xffB45309),
                          title: "Social Media Reels — Monthly Content",
                          subtitle: "D2C health brand social...",
                          location: "Remote",
                          tags: ["Videographer", "Editor"],
                          price: "₹32,000",
                          cardBg: cardBg,
                          borderColor: borderColor,
                          textColor: textColor,
                          textSecondary: textSecondary,
                          onView: () => _showNotice(context, "Social Reels"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeaturedGridCard(
                          icon: Icons.location_on_outlined,
                          iconBg: const Color(0xffDBEAFE),
                          iconColor: const Color(0xff2563EB),
                          title: "Travel Photography — Destination...",
                          subtitle: "Destination photography...",
                          location: "Multiple",
                          tags: ["Photographer", "Videographer"],
                          price: "₹75,000",
                          cardBg: cardBg,
                          borderColor: borderColor,
                          textColor: textColor,
                          textSecondary: textSecondary,
                          onView: () => _showNotice(context, "Travel"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ── Modular Sub-Widgets
  Widget _buildCircleBtn({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xffE2E8F0)),
        ),
        child: Icon(icon, color: const Color(0xff1E293B), size: 19),
      ),
    );
  }

  Widget _buildCountBadge(String count, Color color) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        count,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHighPriorityCard({
    required String imageUrl,
    required String title,
    required String location,
    required String duration,
    required List<String> tags,
    required String price,
    required VoidCallback onApply,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 310,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.4),
                    Colors.black.withValues(alpha: 0.92),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xffEF4444),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.flash_on_rounded, size: 12, color: Colors.white),
                    SizedBox(width: 3),
                    Text(
                      "URGENT",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          size: 13, color: Colors.white70),
                      const SizedBox(width: 3),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time_rounded,
                          size: 13, color: Colors.white70),
                      const SizedBox(width: 3),
                      Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: tags.map((t) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          t,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      GestureDetector(
                        onTap: onApply,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                          child: const Text(
                            "Apply Now",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
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
      ),
    );
  }

  Widget _buildBoostedCard({
    required String imageUrl,
    required String brand,
    required String title,
    required String desc,
    required List<String> tags,
    required String price,
    required bool isDark,
    required Color borderColor,
    required Color cardBg,
    required Color textColor,
    required VoidCallback onApply,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 105,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(imageUrl, fit: BoxFit.cover),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2.5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffD97706),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "BOOSTED",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: Color(0xff64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        desc,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.5,
                          color: Color(0xff94A3B8),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 4,
                        children: tags.map((t) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffF1F5F9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              t,
                              style: const TextStyle(
                                fontSize: 9.5,
                                color: Color(0xff475569),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: onApply,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonGradientCreative,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Text(
                                "Apply",
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  color: Colors.white,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedGridCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String location,
    required List<String> tags,
    required String price,
    required Color cardBg,
    required Color borderColor,
    required Color textColor,
    required Color textSecondary,
    required VoidCallback onView,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10.5, color: textSecondary),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.location_on_rounded, size: 12, color: textSecondary),
              const SizedBox(width: 2),
              Text(
                location,
                style: TextStyle(fontSize: 10.5, color: textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: tags.map((t) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xffF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  t,
                  style:
                      const TextStyle(fontSize: 9, color: Color(0xff475569)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              ),
              GestureDetector(
                onTap: onView,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradientCreative,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "View",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
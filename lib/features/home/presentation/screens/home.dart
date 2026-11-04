import 'package:flutter/material.dart';
import 'package:p1/features/messaging/presentation/screens/inbox_screen.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../../core/widgets/app_profile_drawer.dart';
import '../../../profile/presentation/screens/creative_profile_screen.dart';
import './../../../gigs/presentation/screens/gigs_screen.dart';
import './../../../opportunities/presentation/screens/opportunities_screen.dart';
import './../../../professionals/presentation/screens/professionals_screen.dart';
// ── 12 Section Imports from the `sections/` subfolder
import '../sections/01_top_bar_section.dart';
import '../sections/02_creative_professionals_section.dart';
import '../sections/03_top_rated_profiles_section.dart';
import '../sections/04_rising_stars_section.dart';
import '../sections/05_featured_professionals_section.dart';
import '../sections/06_brand_opportunities_section.dart';
import '../sections/07_business_opportunities_section.dart';
import '../sections/08_trending_work_styles_section.dart';
import '../sections/09_featured_gigs_section.dart';
import '../sections/10_pro_seller_gigs_section.dart';
import '../sections/11_new_gigs_section.dart';
import '../sections/12_skilled_gigs_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  String currentCity = "Mumbai";
  String currentCategory = "All";
  String searchQuery = "";

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 650));
    if (mounted) {
      setState(() {});
      _showToast("Home feed updated");
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeSm,
            fontWeight: AppTypography.medium,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      ),
    );
  }

  void _onPostGig() {
    _showToast("Opening Post a GIG flow...");
  }

  void _onNotifications() {
    _showToast("Opening notifications...");
  }

  void _onProfile() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) return;
    setState(() => searchQuery = query);
    _showToast("Searching for \"$query\" in $currentCity...");
  }

  void _onCityChanged(String city) {
    setState(() => currentCity = city);
    _showToast("Location switched to $city");
  }

  void _onCategoryChanged(String category) {
    setState(() => currentCategory = category);
  }

  void _onConnect(Map<String, dynamic> pro) {
    _showToast("Connection request sent to ${pro['name']}");
  }

  void _onBookmark(Map<String, dynamic> item) {
    _showToast("Saved ${item['name'] ?? item['title']} to bookmarks");
  }

  void _onApplyBrief(Map<String, dynamic> opp) {
    _showToast("Applying to ${opp['brand']} brief...");
  }

  void _onViewGig(Map<String, dynamic> gig) {
    _showToast("Loading \"${gig['title']}\" details...");
  }

  void _onChat(Map<String, dynamic> gig) {
    _showToast("Starting chat with ${gig['author']}...");
  }

  void _onSort() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.surfaceDark
          : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sort Results By",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeLg,
                    fontWeight: AppTypography.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.space2),
                ListTile(
                  leading: const Icon(Icons.star_rounded, color: Color(0xffD97706)),
                  title: const Text("Top Rated & Verified"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showToast("Sorted by Top Rated");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.trending_up_rounded, color: AppColors.primary),
                  title: const Text("Most Popular & Booked"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showToast("Sorted by Popularity");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bolt_rounded, color: AppColors.success),
                  title: const Text("Fastest Delivery Turnaround"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showToast("Sorted by Delivery Speed");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color inactiveColor = isDark ? AppColors.textMutedDark : const Color(0xff64748B);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppProfileDrawer(),
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // ── Tab 0: Home Page Feed
          SafeArea(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBarSection(
                      onPostGigTap: _onPostGig,
                      onNotificationsTap: _onNotifications,
                      onProfileTap: _onProfile,
                      onCityChanged: _onCityChanged,
                      onCategoryChanged: _onCategoryChanged,
                      onSearchSubmitted: _onSearch,
                      onSortTap: _onSort,
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    CreativeProfessionalsSection(
                      onViewAllTap: () => _showToast("Viewing all creative professionals"),
                      onConnectTap: _onConnect,
                      onProfileTap: (pro) => _showToast("Opening ${pro['name']}'s profile"),
                      onBookmarkTap: _onBookmark,
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    TopRatedProfilesSection(
                      onViewAllTap: () => _showToast("Viewing all top-rated profiles"),
                      onConnectTap: _onConnect,
                      onProfileTap: (p) => _showToast("Opening ${p['name']}'s profile"),
                      onFavoriteTap: _onBookmark,
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    RisingStarsSection(
                      onSeeAllTap: () => _showToast("Viewing all rising stars"),
                      onStarTap: (star) => _showToast("Selected rising star ${star['name']}"),
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    FeaturedProfessionalsSection(
                      onSeeAllTap: () => _showToast("Viewing all featured professionals"),
                      onProTap: (pro) => _showToast("Opening ${pro['name']}'s portfolio"),
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    BrandOpportunitiesSection(
                      onBrowseAllTap: () => _showToast("Browsing all brand opportunities"),
                      onApplyTap: _onApplyBrief,
                      onSaveTap: _onBookmark,
                      onCardTap: (opp) => _showToast("Opening ${opp['title']}"),
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    BusinessOpportunitiesSection(
                      onSeeAllTap: () => _showToast("Viewing all business opportunities"),
                      onPostServiceOfferTap: () => _showToast("Opening service offer composer..."),
                      onItemTap: (item) => _showToast("Selected ${item['title']}"),
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    TrendingWorkStylesSection(
                      onExploreTap: () => _showToast("Exploring all shoot categories"),
                      onStyleTap: (style) => _showToast("Filtered by ${style['title']}"),
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    FeaturedGigsSection(
                      onSeeAllTap: () => _showToast("Viewing all featured GIGs"),
                      onGigTap: _onViewGig,
                      onFavoriteTap: _onBookmark,
                      onViewTap: _onViewGig,
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    ProSellerGigsSection(
                      onSeeAllTap: () => _showToast("Viewing all Pro Seller GIGs"),
                      onGigTap: _onViewGig,
                      onViewGigTap: _onViewGig,
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    NewGigsSection(
                      onViewGigTap: _onViewGig,
                      onChatTap: _onChat,
                      onFavoriteTap: _onBookmark,
                      onTierTap: (gig, tier) => _showToast(
                        "Selected ${tier['label']} tier (${tier['price']}) for ${gig['author']}",
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space6),
                    SkilledGigsSection(
                      onExploreTap: () => _showToast("Exploring all skilled categories"),
                      onCategoryTap: (cat) => _showToast("Browsing ${cat['title']} opportunities"),
                    ),
                    const SizedBox(height: AppSpacing.space10),
                  ],
                ),
              ),
            ),
          ),

          // ── Tab 1: Professionals
          const ProfessionalsScreen(),

          // ── Tab 2: Opportunities
          const OpportunitiesScreen(),

          // ── Tab 3: GIGs Screen
          const GigsScreen(),

          // ── Tab 4: Messaging
          const InboxScreen(),
        ],
      ),

      // ── Fixed Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          border: Border(top: BorderSide(color: borderColor, width: 1.0)),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, "Home", Icons.home_outlined, Icons.home_rounded, activeColor, inactiveColor),
                _buildNavItem(1, "Professionals", Icons.groups_outlined, Icons.groups_rounded, activeColor, inactiveColor),
                _buildNavItem(2, "Opportunities", Icons.work_outline_rounded, Icons.work_rounded, activeColor, inactiveColor),
                _buildNavItem(3, "GIGs", Icons.view_in_ar_outlined, Icons.view_in_ar_rounded, activeColor, inactiveColor),
                _buildNavItem(4, "Messaging", Icons.chat_bubble_outline_rounded, Icons.chat_bubble_rounded, activeColor, inactiveColor, badgeCount: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String label,
    IconData outlinedIcon,
    IconData filledIcon,
    Color activeColor,
    Color inactiveColor, {
    int? badgeCount,
  }) {
    final bool isSelected = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? filledIcon : outlinedIcon,
                  color: isSelected ? activeColor : inactiveColor,
                  size: 22,
                ),
                if (badgeCount != null && badgeCount > 0)
                  Positioned(
                    top: -2,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: const BoxDecoration(
                        color: Color(0xffEF4444),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: Text(
                        '$badgeCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Placeholder Screen for Non-Home Tabs
class _PlaceholderTab extends StatelessWidget {
  final String title;
  final IconData icon;

  const _PlaceholderTab({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: AppColors.primary),
          ),
          const SizedBox(height: 14),
          Text(
            "$title Screen",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Coming soon in this section",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 12.5,
              color: textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
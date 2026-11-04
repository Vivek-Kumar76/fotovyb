import 'package:flutter/material.dart';
import '../tokens/tokens.dart';
import '../../features/profile/presentation/screens/creative_profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/subscription/presentation/screens/subscription_screen.dart';

class AppProfileDrawer extends StatelessWidget {
  const AppProfileDrawer({super.key});

  void _navigateTo(BuildContext context, Widget screen) {
    // Pushes directly without popping the drawer, keeping the drawer active underneath
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              "$feature is coming soon!",
              style: const TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff1C3A5E),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Log Out",
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
        content: const Text(
          "Are you sure you want to log out of FotoVyb?",
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: 13,
            color: Color(0xff64748B),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Color(0xff64748B)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context); // Closes the drawer on confirmed logout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out successfully"),
                  backgroundColor: Color(0xffEF4444),
                ),
              );
            },
            child: const Text(
              "Log Out",
              style: TextStyle(
                color: Color(0xffEF4444),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final textColor = isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);
    final textSecondary = isDark ? AppColors.textSecondaryDark : const Color(0xff64748B);
    final surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final dividerColor = isDark ? AppColors.borderDark : const Color(0xffF1F5F9);

    return Drawer(
      backgroundColor: surfaceColor,
      width: MediaQuery.of(context).size.width * 0.82,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            // ── 1. User Profile Header & Status
            Container(
              padding: EdgeInsets.fromLTRB(20, topPadding + 16, 20, 18),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff091B2B) : const Color(0xffF8FAFC),
                border: Border(bottom: BorderSide(color: dividerColor)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      GestureDetector(
                        onTap: () => _navigateTo(context, const CreativeProfileScreen()),
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff0D9488), width: 2),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300&auto=format&fit=crop",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Close Icon
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xff1E293B) : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: dividerColor),
                          ),
                          child: Icon(Icons.close_rounded, size: 16, color: textColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _navigateTo(context, const CreativeProfileScreen()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mei Lin",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const CircleAvatar(radius: 3, backgroundColor: Color(0xff10B981)),
                            const SizedBox(width: 4),
                            Text(
                              "Fashion Stylist • Verified",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Active Subscription Banner / Quick Upgrade Pill
                  GestureDetector(
                    onTap: () => _navigateTo(context, const SubscriptionScreen()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xffD97706).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xffD97706).withValues(alpha: 0.25)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.workspace_premium_rounded, size: 16, color: Color(0xffD97706)),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "Free Tier • Upgrade",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Color(0xffB45309),
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded, size: 16, color: Color(0xffB45309)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── 2. Scrollable Menu Items
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  // Action CTA: "Post a GIG"
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    child: GestureDetector(
                      onTap: () => _showComingSoon(context, "Post a GIG Composer"),
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGradientCreative,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff0D9488).withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline_rounded, size: 16, color: Colors.white),
                            SizedBox(width: 6),
                            Text(
                              "Post a GIG",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  _buildCategoryHeading("ACCOUNT & PORTFOLIO"),
                  _buildDrawerItem(
                    icon: Icons.person_outline_rounded,
                    title: "Creative Profile",
                    onTap: () => _navigateTo(context, const CreativeProfileScreen()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.edit_outlined,
                    title: "Edit Profile",
                    onTap: () => _showComingSoon(context, "Edit Profile"),
                  ),
                  _buildDrawerItem(
                    icon: Icons.rocket_launch_outlined,
                    title: "Subscription Plans",
                    badge: "PRO",
                    badgeColor: const Color(0xff0D9488),
                    onTap: () => _navigateTo(context, const SubscriptionScreen()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.view_in_ar_outlined,
                    title: "My Posted GIGs",
                    onTap: () => _showComingSoon(context, "My GIGs Dashboard"),
                  ),

                  const SizedBox(height: 10),
                  Divider(height: 1, color: dividerColor),
                  const SizedBox(height: 10),

                  _buildCategoryHeading("PREFERENCES & SECURITY"),
                  _buildDrawerItem(
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    onTap: () => _navigateTo(context, const SettingsScreen()),
                  ),
                  _buildDrawerItem(
                    icon: Icons.visibility_outlined,
                    title: "Recent Visitors",
                    onTap: () => _showComingSoon(context, "Visitors Insight"),
                  ),
                  _buildDrawerItem(
                    icon: Icons.receipt_long_outlined,
                    title: "Billing & Invoices",
                    onTap: () => _navigateTo(context, const SubscriptionScreen()),
                  ),

                  const SizedBox(height: 10),
                  Divider(height: 1, color: dividerColor),
                  const SizedBox(height: 10),

                  _buildCategoryHeading("HELP & LEGAL"),
                  _buildDrawerItem(
                    icon: Icons.headset_mic_outlined,
                    title: "Customer Support",
                    onTap: () => _showComingSoon(context, "Support Desk"),
                  ),
                  _buildDrawerItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: "Contact Us",
                    onTap: () => _showComingSoon(context, "Contact Us"),
                  ),
                  _buildDrawerItem(
                    icon: Icons.policy_outlined,
                    title: "Terms & Privacy Policy",
                    onTap: () => _showComingSoon(context, "Terms & Privacy"),
                  ),
                ],
              ),
            ),

            // ── 3. Footer: Version & Logout
            Container(
              padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding + 14),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff091B2B) : const Color(0xffF8FAFC),
                border: Border(top: BorderSide(color: dividerColor)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "FotoVyb v1.0.0",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff94A3B8),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showLogoutDialog(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xffEF4444).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.logout_rounded, size: 14, color: Color(0xffEF4444)),
                          SizedBox(width: 4),
                          Text(
                            "Log Out",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xffEF4444),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeading(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: Color(0xff94A3B8),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
    Color? badgeColor,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, size: 20, color: const Color(0xff0D9488)),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge != null)
            Container(
              margin: const EdgeInsets.only(right: 6),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badgeColor ?? const Color(0xff0D9488),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xffCBD5E1)),
        ],
      ),
      onTap: onTap,
    );
  }
}
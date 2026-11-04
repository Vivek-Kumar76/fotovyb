import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import 'settings_menu_tittle.dart';

class SettingsProfileAndAccountSection extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onEditProfile;
  final ValueChanged<String>? onTileTap;

  const SettingsProfileAndAccountSection({
    super.key,
    this.onBack,
    this.onNotificationTap,
    this.onEditProfile,
    this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;
    final Color textColor = isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : const Color(0xff64748B);
    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color sectionHeaderBg = isDark ? const Color(0xff0F172A) : const Color(0xffF8FAFC);
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Top Navigation Bar
        Container(
          color: surfaceColor,
          padding: EdgeInsets.fromLTRB(16, topPadding + 6, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onNotificationTap,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Color(0xff1E293B),
                        size: 20,
                      ),
                    ),
                    Positioned(
                      top: 7,
                      right: 8,
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
            ],
          ),
        ),

        const Divider(height: 1, color: Color(0xffF1F5F9)),

        // ── Profile Summary Card
        Container(
          color: surfaceColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300&auto=format&fit=crop",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mei Lin",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Fashion Stylist",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 12.5,
                            color: textSecondary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xff10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Verified",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff10B981),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // "Edit Profile" Button with Camera Icon
              GestureDetector(
                onTap: onEditProfile,
                child: Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradientCreative,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff1C3A5E).withValues(alpha: 0.16),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined, size: 16, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Section Header: ACCOUNT & SECURITY
        Container(
          width: double.infinity,
          color: sectionHeaderBg,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: const Text(
            "ACCOUNT & SECURITY",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: Color(0xff64748B),
            ),
          ),
        ),

        // ── Account & Security Menu Tiles
        Container(
          color: surfaceColor,
          child: Column(
            children: [
              SettingsMenuTile(
                icon: Icons.person_outline_rounded,
                title: "Account Profile",
                subtitle: "Name, email, profile picture",
                onTap: () => onTileTap?.call("Account Profile"),
              ),
              SettingsMenuTile(
                icon: Icons.lock_outline_rounded,
                title: "Change Password",
                subtitle: "Update your password",
                onTap: () => onTileTap?.call("Change Password"),
              ),
              SettingsMenuTile(
                icon: Icons.notifications_none_rounded,
                title: "Notifications",
                subtitle: "Email, push & SMS preferences",
                onTap: () => onTileTap?.call("Notifications"),
              ),
              SettingsMenuTile(
                icon: Icons.visibility_off_outlined,
                title: "Privacy & Visibility",
                subtitle: "Hide activities, profile visibility",
                onTap: () => onTileTap?.call("Privacy & Visibility"),
              ),
              SettingsMenuTile(
                icon: Icons.groups_outlined,
                title: "Connections",
                subtitle: "Manage followers & connections",
                showDivider: false,
                onTap: () => onTileTap?.call("Connections"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
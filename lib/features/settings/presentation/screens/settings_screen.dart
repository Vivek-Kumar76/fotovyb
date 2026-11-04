import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../widgets/01_settings_profile_and_account_section.dart';
import '../../widgets/02_settings_preferences_and_data_section.dart';
import '../../widgets/03_settings_support_and_visitors_section.dart';
import '../../widgets/04_settings_activity_and_danger_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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

  void _showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String actionLabel,
    required Color actionColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: 13,
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
              onConfirm();
            },
            child: Text(
              actionLabel,
              style: TextStyle(
                color: actionColor,
                fontWeight: FontWeight.w700,
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

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Segment 1: Profile & Account Security
            SettingsProfileAndAccountSection(
              onBack: () => Navigator.of(context).maybePop(),
              onNotificationTap: () =>
                  _showNotice(context, "Opening Notifications..."),
              onEditProfile: () => _showNotice(context, "Opening Edit Profile..."),
              onTileTap: (item) => _showNotice(context, 'Navigating to "$item"'),
            ),

            // ── Segment 2: Preferences & Data Security
            SettingsPreferencesAndDataSection(
              onTileTap: (item) => _showNotice(context, 'Navigating to "$item"'),
            ),

            // ── Segment 3: Support & Recent Visitors Preview
            SettingsSupportAndVisitorsSection(
              onTileTap: (item) => _showNotice(context, 'Navigating to "$item"'),
              onViewAllVisitors: () =>
                  _showNotice(context, "Viewing all recent visitors"),
              onViewVisitor: (visitor) =>
                  _showNotice(context, 'Viewing ${visitor['name']} profile'),
            ),

            // ── Segment 4: Activity Log & Danger Zone
            SettingsActivityAndDangerSection(
              onViewAllActivity: () =>
                  _showNotice(context, "Viewing full activity log"),
              onDeactivateAccount: () {
                _showConfirmDialog(
                  context,
                  title: "Deactivate Account",
                  message:
                      "Your profile and gigs will be hidden until you reactivate. Are you sure?",
                  actionLabel: "Deactivate",
                  actionColor: const Color(0xff1E293B),
                  onConfirm: () => _showNotice(context, "Account deactivated"),
                );
              },
              onDeleteAccount: () {
                _showConfirmDialog(
                  context,
                  title: "Delete Account Permanently",
                  message:
                      "This action cannot be undone. All your portfolio, gigs, and messages will be permanently deleted.",
                  actionLabel: "Delete Permanently",
                  actionColor: const Color(0xffEF4444),
                  onConfirm: () => _showNotice(context, "Account scheduled for deletion"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
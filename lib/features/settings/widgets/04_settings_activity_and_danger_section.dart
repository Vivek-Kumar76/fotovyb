import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class SettingsActivityAndDangerSection extends StatelessWidget {
  final VoidCallback? onViewAllActivity;
  final VoidCallback? onDeactivateAccount;
  final VoidCallback? onDeleteAccount;

  const SettingsActivityAndDangerSection({
    super.key,
    this.onViewAllActivity,
    this.onDeactivateAccount,
    this.onDeleteAccount,
  });

  final List<Map<String, dynamic>> _activities = const [
    {
      "title": "Logged in",
      "subtitle": "From Mumbai, India (Chrome, macOS)",
      "time": "Today at 9:34 AM",
      "icon": Icons.login_rounded,
      "iconBg": Color(0xffE6F4F1),
      "iconColor": Color(0xff0D9488),
    },
    {
      "title": "Updated profile",
      "subtitle": "Changed profile picture and bio",
      "time": "Yesterday at 2:15 PM",
      "icon": Icons.edit_note_rounded,
      "iconBg": Color(0xffE2E8F0),
      "iconColor": Color(0xff1E293B),
    },
    {
      "title": "Completed GIG",
      "subtitle": "Styling Project for Vogue India",
      "time": "2 days ago",
      "icon": Icons.check_circle_outline_rounded,
      "iconBg": Color(0xffDCFCE7),
      "iconColor": Color(0xff16A34A),
    },
    {
      "title": "Received message",
      "subtitle": "From Divya Khanna at Vogue India",
      "time": "3 days ago",
      "icon": Icons.chat_bubble_outline_rounded,
      "iconBg": Color(0xffFEF3C7),
      "iconColor": Color(0xffD97706),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color sectionHeaderBg =
        isDark ? const Color(0xff0F172A) : const Color(0xffF8FAFC);
    final Color textColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xff1E293B);
    final Color textSecondary =
        isDark ? AppColors.textSecondaryDark : const Color(0xff94A3B8);
    final Color dividerColor =
        isDark ? AppColors.borderDark : const Color(0xffF1F5F9);
    final Color cardBorderColor =
        isDark ? AppColors.borderDark : const Color(0xffF1F5F9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. ACTIVITY LOG Header
        Container(
          width: double.infinity,
          color: sectionHeaderBg,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "ACTIVITY LOG",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: Color(0xff64748B),
                ),
              ),
              GestureDetector(
                onTap: onViewAllActivity,
                child: const Text(
                  "View all",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0D9488),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Activity Log Items
        Container(
          color: surfaceColor,
          child: Column(
            children: List.generate(_activities.length, (index) {
              final act = _activities[index];
              final isLast = index == _activities.length - 1;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: act['iconBg'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            act['icon'] as IconData,
                            size: 18,
                            color: act['iconColor'] as Color,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                act['title'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                act['subtitle'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 11.5,
                                  color: textSecondary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                act['time'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 10.5,
                                  color: textSecondary.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 18,
                      color: dividerColor,
                    ),
                ],
              );
            }),
          ),
        ),

        const SizedBox(height: 20),

        // ── 2. Danger Zone: Account Deactivation Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: cardBorderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Color(0xffFEE2E2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.error_outline_rounded,
                        color: Color(0xffEF4444),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Account Deactivation",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Button 1: Deactivate Account
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    onPressed: onDeactivateAccount,
                    style: TextButton.styleFrom(
                      backgroundColor: isDark
                          ? const Color(0xff1E293B)
                          : const Color(0xffF1F5F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      "Deactivate Account",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Button 2: Delete Permanently
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    onPressed: onDeleteAccount,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffEF4444),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Delete Permanently",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 13,
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

        const SizedBox(height: 40),
      ],
    );
  }
}
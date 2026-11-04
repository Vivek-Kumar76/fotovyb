import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import 'settings_menu_tittle.dart';

class SettingsPreferencesAndDataSection extends StatelessWidget {
  final ValueChanged<String>? onTileTap;

  const SettingsPreferencesAndDataSection({
    super.key,
    this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final Color sectionHeaderBg =
        isDark ? const Color(0xff0F172A) : const Color(0xffF8FAFC);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. PREFERENCES Header
        Container(
          width: double.infinity,
          color: sectionHeaderBg,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: const Text(
            "PREFERENCES",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: Color(0xff64748B),
            ),
          ),
        ),

        // ── Preferences Menu List
        Container(
          color: surfaceColor,
          child: Column(
            children: [
              SettingsMenuTile(
                icon: Icons.business_center_outlined,
                title: "Work Preferences",
                subtitle: "Industries, skills, availability",
                onTap: () => onTileTap?.call("Work Preferences"),
              ),
              SettingsMenuTile(
                icon: Icons.location_on_outlined,
                title: "Location Settings",
                subtitle: "City, shoot locations, remote work",
                onTap: () => onTileTap?.call("Location Settings"),
              ),
              SettingsMenuTile(
                icon: Icons.credit_card_outlined,
                title: "Billing & Payments",
                subtitle: "Payment methods, invoices, receipts",
                onTap: () => onTileTap?.call("Billing & Payments"),
              ),
              SettingsMenuTile(
                icon: Icons.receipt_long_outlined,
                title: "Contract & Legal",
                subtitle: "GST, PAN, banking details",
                showDivider: false,
                onTap: () => onTileTap?.call("Contract & Legal"),
              ),
            ],
          ),
        ),

        // ── 2. ACTIVITY & SECURITY Header
        Container(
          width: double.infinity,
          color: sectionHeaderBg,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: const Text(
            "ACTIVITY & SECURITY",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: Color(0xff64748B),
            ),
          ),
        ),

        // ── Activity & Security Menu List
        Container(
          color: surfaceColor,
          child: Column(
            children: [
              SettingsMenuTile(
                icon: Icons.visibility_outlined,
                title: "Recent Visitors",
                subtitle: "Who viewed your profile",
                onTap: () => onTileTap?.call("Recent Visitors"),
              ),
              SettingsMenuTile(
                icon: Icons.show_chart_rounded,
                title: "Activity Log",
                subtitle: "Login history & platform activity",
                onTap: () => onTileTap?.call("Activity Log"),
              ),
              SettingsMenuTile(
                icon: Icons.link_rounded,
                title: "Connected Apps",
                subtitle: "Third-party integrations",
                onTap: () => onTileTap?.call("Connected Apps"),
              ),
              SettingsMenuTile(
                icon: Icons.file_download_outlined,
                title: "Download Data",
                subtitle: "GDPR — export your data",
                showDivider: false,
                onTap: () => onTileTap?.call("Download Data"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
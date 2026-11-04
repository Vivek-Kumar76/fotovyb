import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import 'settings_menu_tittle.dart';

class SettingsSupportAndVisitorsSection extends StatelessWidget {
  final ValueChanged<String>? onTileTap;
  final VoidCallback? onViewAllVisitors;
  final ValueChanged<Map<String, dynamic>>? onViewVisitor;

  const SettingsSupportAndVisitorsSection({
    super.key,
    this.onTileTap,
    this.onViewAllVisitors,
    this.onViewVisitor,
  });

  final List<Map<String, dynamic>> _visitors = const [
    {
      "name": "Arjun Kapoor",
      "role": "Hiring Manager",
      "time": "2 hours ago",
      "avatar":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Divya Khanna",
      "role": "Producer",
      "time": "5 hours ago",
      "avatar":
          "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Reza Tehrani",
      "role": "Marketing Manager",
      "time": "1 day ago",
      "avatar":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. SUPPORT & COMMUNITY Header
        Container(
          width: double.infinity,
          color: sectionHeaderBg,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: const Text(
            "SUPPORT & COMMUNITY",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: Color(0xff64748B),
            ),
          ),
        ),

        // ── Support Menu List
        Container(
          color: surfaceColor,
          child: Column(
            children: [
              SettingsMenuTile(
                icon: Icons.help_outline_rounded,
                title: "Help & Support",
                subtitle: "FAQs, guides, contact support",
                onTap: () => onTileTap?.call("Help & Support"),
              ),
              SettingsMenuTile(
                icon: Icons.chat_bubble_outline_rounded,
                title: "Feedback",
                subtitle: "Send us your feature requests",
                onTap: () => onTileTap?.call("Feedback"),
              ),
              SettingsMenuTile(
                icon: Icons.bookmark_border_rounded,
                title: "Saved Resources",
                subtitle: "Bookmarked articles & guides",
                onTap: () => onTileTap?.call("Saved Resources"),
              ),
              SettingsMenuTile(
                icon: Icons.shield_outlined,
                title: "Report a Problem",
                subtitle: "Report harassment or abuse",
                showDivider: false,
                onTap: () => onTileTap?.call("Report a Problem"),
              ),
            ],
          ),
        ),

        // ── 2. RECENT VISITORS Header
        Container(
          width: double.infinity,
          color: sectionHeaderBg,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "RECENT VISITORS",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: Color(0xff64748B),
                ),
              ),
              GestureDetector(
                onTap: onViewAllVisitors,
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

        // ── Recent Visitors List Preview
        Container(
          color: surfaceColor,
          child: Column(
            children: List.generate(_visitors.length, (index) {
              final visitor = _visitors[index];
              final isLast = index == _visitors.length - 1;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              NetworkImage(visitor['avatar'] as String),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                visitor['name'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                visitor['role'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 11.5,
                                  color: textSecondary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                visitor['time'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 11,
                                  color: textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => onViewVisitor?.call(visitor),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xff0D9488),
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(68, 34),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text(
                            "View",
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
      ],
    );
  }
}
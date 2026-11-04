import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../profile/presentation/screens/creative_profile_screen.dart';
import '../../widgets/01_pros_hero_search_section.dart';
import '../../widgets/02_pros_featured_and_priority_section.dart';
import '../../widgets/03_pros_featured_gigs_section.dart';
import '../../widgets/04_pros_services_rising_stars_section.dart';

class ProfessionalsScreen extends StatelessWidget {
  const ProfessionalsScreen({super.key});

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

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section 1: Hero Search & Stats (Image 1)
            ProsHeroSearchSection(
              onSearch: (q) => _showNotice(context, 'Searching "$q"'),
              onCityChanged: (city) => _showNotice(context, 'Location: $city'),
              onRoleChanged: (role) => _showNotice(context, 'Role: $role'),
            ),

            // ── Section 2: Filters, Featured Pros & Top Priority (Image 2)
            ProsFeaturedAndPrioritySection(
              onViewAllPros: () => _showNotice(context, "Viewing all featured pros"),
              onConnectPro: (p) => _showNotice(context, "Connecting with ${p['name']}"),
              onViewPro: (p) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreativeProfileScreen()),
                );
              },
              onAllJobsTap: () => _showNotice(context, "Viewing all jobs"),
              onPriorityJobTap: (j) => _showNotice(context, 'Opening "${j['title']}"'),
            ),

            const SizedBox(height: 24),

            // ── Section 3: Featured GIGs 2x2 Grid (Image 3)
            ProsFeaturedGigsSection(
              onAllGigsTap: () => _showNotice(context, "Viewing all GIGs"),
              onOrderGig: (g) => _showNotice(context, 'Ordering from ${g['name']}'),
            ),

            // ── Section 4: Featured Services & Rising Stars (Image 4)
            ProsServicesRisingStarsSection(
              onAllServicesTap: () => _showNotice(context, "Viewing all services"),
              onApplyService: (s) => _showNotice(context, 'Applied to "${s['title']}"'),
              onAllRisingStarsTap: () => _showNotice(context, "Viewing all rising stars"),
              onConnectStar: (s) => _showNotice(context, "Connecting with ${s['name']}"),
              onViewStar: (s) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreativeProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../profile/presentation/screens/creative_profile_screen.dart';
import '../widgets/gigs_header_section.dart';
import '../widgets/gigs_featured_section.dart';
import '../widgets/gigs_top_rated_section.dart';
import '../widgets/gigs_new_section.dart';

class GigsScreen extends StatelessWidget {
  const GigsScreen({super.key});

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
            // ── 1. Header, Hero Banner, Search & Filters (Image 1)
            GigsHeaderSection(
              onProfileTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreativeProfileScreen()),
                );
              },
              onPostGigTap: () => _showNotice(context, "Opening Post a GIG composer..."),
              onNotificationsTap: () => _showNotice(context, "Opening notifications..."),
              onSearch: (q) => _showNotice(context, 'Searching: "$q"'),
              onCategorySelected: (cat) => _showNotice(context, 'Category: $cat'),
            ),

            const SizedBox(height: 24),

            // ── 2. Featured GIGs (Image 2)
            GigsFeaturedSection(
              onViewGig: (gig) => _showNotice(context, 'Opening "${gig['title']}"'),
              onChat: (gig) => _showNotice(context, 'Chatting with ${gig['sellerName']}'),
              onBookmark: (gig) => _showNotice(context, 'Saved "${gig['title']}"'),
            ),

            const SizedBox(height: 28),

            // ── 3. Top Rated GIGs (Image 3)
            GigsTopRatedSection(
              onSeeAllTap: () => _showNotice(context, "Viewing all Top Rated GIGs"),
              onViewGig: (gig) => _showNotice(context, 'Opening "${gig['title']}"'),
            ),

            const SizedBox(height: 28),

            // ── 4. New GIGs (Image 4)
            GigsNewSection(
              onViewGig: (gig) => _showNotice(context, 'Opening "${gig['title']}"'),
              onChat: (gig) => _showNotice(context, 'Chatting with ${gig['sellerName']}'),
              onBookmark: (gig) => _showNotice(context, 'Saved "${gig['title']}"'),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
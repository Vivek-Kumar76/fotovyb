import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProfileHeroSection extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onBookSession;

  const ProfileHeroSection({
    super.key,
    required this.onBack,
    required this.onBookSession,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.of(context).padding.top;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color surfaceBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Top Cover with Badges and Actions (Save/Bookmark removed)
        Stack(
          children: [
            // Cover Image
            Container(
              height: 290,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=1000&auto=format&fit=crop",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.65),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Top Bar: Available Tag + Back & Share (No save button)
            Positioned(
              top: topPadding + 8,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  // "● Available" Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xff064E3B).withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xff10B981).withValues(alpha: 0.6)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(radius: 3.5, backgroundColor: Color(0xff10B981)),
                        SizedBox(width: 6),
                        Text(
                          "Available",
                          style: TextStyle(
                            color: Color(0xffD1FAE5),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Back Button
                  _buildCircleBtn(icon: Icons.arrow_back_rounded, onTap: onBack),
                  const SizedBox(width: 10),
                  // Share Button
                  _buildCircleBtn(icon: Icons.share_outlined, onTap: () {}),
                ],
              ),
            ),

            // Floating Bottom Chips on Cover (Connect, Message, GIG)
            Positioned(
              bottom: 14,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  _buildHeroChip(Icons.verified_outlined, "Connect"),
                  const SizedBox(width: 8),
                  _buildHeroChip(Icons.chat_bubble_outline_rounded, "Message"),
                  const SizedBox(width: 8),
                  _buildHeroChip(Icons.work_outline_rounded, "GIG"),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // ── 2. Profile Avatar & Name Side-by-Side Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Avatar
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark ? AppColors.borderDark : const Color(0xffE2E8F0),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=400&auto=format&fit=crop",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Name, Specialization & City Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Kofi Mensah",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.check_circle, color: Color(0xff2E7D6E), size: 18),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Commercial & Editorial Photographer",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2E7D6E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: 13, color: textSecondary),
                        const SizedBox(width: 3),
                        Text(
                          "Bangalore, India",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 12,
                            color: textSecondary,
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

        const SizedBox(height: 18),

        // ── 3. 4 Stats Row Capsules
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildStatCapsule("83", "Projects", isDark, surfaceBg, borderColor),
              const SizedBox(width: 8),
              _buildStatCapsule("4.8", "Rating", isDark, surfaceBg, borderColor),
              const SizedBox(width: 8),
              _buildStatCapsule("1.2K", "Followers", isDark, surfaceBg, borderColor),
              const SizedBox(width: 8),
              _buildStatCapsule("5 yrs", "Exp.", isDark, surfaceBg, borderColor),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // ── 4. Hero Action Card (Starting from ₹11,000 + CTA buttons)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceBg,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Starting from",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 11,
                            color: textSecondary,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "₹11,000",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "/ half day",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 11,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // "Book a Session" Creative Gradient Button
                    GestureDetector(
                      onTap: onBookSession,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGradientCreative,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.calendar_month_outlined, size: 16, color: Colors.white),
                            SizedBox(width: 6),
                            Text(
                              "Book a Session",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildSecondaryPillButton(
                        icon: Icons.person_add_outlined,
                        label: "Connect",
                        borderColor: borderColor,
                        textColor: textColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildSecondaryPillButton(
                        icon: Icons.chat_bubble_outline_rounded,
                        label: "Message",
                        borderColor: borderColor,
                        textColor: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircleBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildHeroChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xff1C3A5E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCapsule(String value, String label, bool isDark, Color surfaceBg, Color borderColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: surfaceBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 10.5,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryPillButton({
    required IconData icon,
    required String label,
    required Color borderColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
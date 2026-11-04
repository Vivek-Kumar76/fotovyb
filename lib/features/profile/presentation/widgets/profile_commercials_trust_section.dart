import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProfileCommercialsTrustSection extends StatelessWidget {
  final GlobalKey? packagesKey;
  final GlobalKey? reviewsKey;
  final int selectedPricingIndex;
  final ValueChanged<int> onSelectPricing;

  const ProfileCommercialsTrustSection({
    super.key,
    this.packagesKey,
    this.reviewsKey,
    required this.selectedPricingIndex,
    required this.onSelectPricing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color surfaceBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Anchor: PACKAGES (Pricing Card)
          Container(
            key: packagesKey,
            padding: const EdgeInsets.all(18),
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
                    const Row(
                      children: [
                        Icon(Icons.currency_rupee_rounded, size: 17, color: Color(0xff2E7D6E)),
                        SizedBox(width: 4),
                        Text(
                          "PRICING",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: Color(0xff2E7D6E),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Excl. travel",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 11,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Tier 1: Half Day
                _buildPricingOption(
                  index: 0,
                  title: "Half Day",
                  subtitle: "4 hrs",
                  price: "₹11,000",
                  isSelected: selectedPricingIndex == 0,
                  isDark: isDark,
                  borderColor: borderColor,
                ),
                const SizedBox(height: 10),

                // Tier 2: Full Day
                _buildPricingOption(
                  index: 1,
                  title: "Full Day",
                  subtitle: "8 hrs",
                  tag: "Most popular",
                  price: "₹18,000",
                  isSelected: selectedPricingIndex == 1,
                  isDark: isDark,
                  borderColor: borderColor,
                ),
                const SizedBox(height: 10),

                // Tier 3: Campaign Week
                _buildPricingOption(
                  index: 2,
                  title: "Campaign Week",
                  subtitle: "5 days",
                  price: "₹80,000",
                  isSelected: selectedPricingIndex == 2,
                  isDark: isDark,
                  borderColor: borderColor,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Anchor: REVIEWS (Client Reviews Header)
          Row(
            key: reviewsKey,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Color(0xffF59E0B), size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "CLIENT REVIEWS",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "(96)",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 13,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star_rounded, color: Color(0xffF59E0B), size: 13),
                    SizedBox(width: 3),
                    Text(
                      "4.8",
                      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _buildReviewCard(
            avatarUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop",
            name: "Priya Sharma",
            company: "Lumière Hotels",
            date: "Mar 2024",
            comment: '"Kofi brought an extraordinary cinematic quality to our brand shoot. His ability to work with natural light is unmatched."',
            isDark: isDark,
            surfaceBg: surfaceBg,
            borderColor: borderColor,
          ),
          const SizedBox(height: 10),

          _buildReviewCard(
            avatarUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
            name: "James Whitfield",
            company: "Volta Motors",
            date: "Jan 2024",
            comment: '"We hired Kofi for our product launch campaign and the results exceeded expectations. Professional, creative."',
            isDark: isDark,
            surfaceBg: surfaceBg,
            borderColor: borderColor,
          ),
          const SizedBox(height: 8),

          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "View all 96 reviews",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  color: Color(0xff2E7D6E),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── CERTIFICATIONS
          const Row(
            children: [
              Icon(Icons.workspace_premium_outlined, color: Color(0xff2E7D6E), size: 18),
              SizedBox(width: 8),
              Text(
                "CERTIFICATIONS",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  color: Color(0xff2E7D6E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          _buildCertItem(
            icon: Icons.military_tech_outlined,
            iconBg: const Color(0xffFEF3C7),
            iconColor: const Color(0xffD97706),
            title: "Certified Professional Photographer",
            org: "PPI",
            year: "2021",
            isDark: isDark,
            surfaceBg: surfaceBg,
            borderColor: borderColor,
          ),
          const SizedBox(height: 8),
          _buildCertItem(
            icon: Icons.verified_outlined,
            iconBg: const Color(0xffD1FAE5),
            iconColor: const Color(0xff059669),
            title: "Adobe Lightroom Expert",
            org: "Adobe",
            year: "2020",
            isDark: isDark,
            surfaceBg: surfaceBg,
            borderColor: borderColor,
          ),
          const SizedBox(height: 8),
          _buildCertItem(
            icon: Icons.school_outlined,
            iconBg: const Color(0xffD1FAE5),
            iconColor: const Color(0xff059669),
            title: "Fashion Styling Diploma",
            org: "NIFT Mumbai",
            year: "2019",
            isDark: isDark,
            surfaceBg: surfaceBg,
            borderColor: borderColor,
          ),
        ],
      ),
    );
  }

  Widget _buildPricingOption({
    required int index,
    required String title,
    required String subtitle,
    required String price,
    required bool isSelected,
    required bool isDark,
    required Color borderColor,
    String? tag,
  }) {
    final Color unselectedBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC);

    return GestureDetector(
      onTap: () => onSelectPricing(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.buttonGradientCreative : null,
          color: isSelected ? null : unselectedBg,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: isSelected ? Colors.transparent : borderColor,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                    color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black87),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 11,
                    color: isSelected ? Colors.white70 : Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (tag != null)
              Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            Text(
              price,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required String avatarUrl,
    required String name,
    required String company,
    required String date,
    required String comment,
    required bool isDark,
    required Color surfaceBg,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surfaceBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 18, backgroundImage: NetworkImage(avatarUrl)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  Text(
                    company,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star, color: Color(0xffF59E0B), size: 12),
                      Icon(Icons.star, color: Color(0xffF59E0B), size: 12),
                      Icon(Icons.star, color: Color(0xffF59E0B), size: 12),
                      Icon(Icons.star, color: Color(0xffF59E0B), size: 12),
                      Icon(Icons.star, color: Color(0xffF59E0B), size: 12),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(date, style: const TextStyle(fontSize: 10.5, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 12,
              height: 1.35,
              color: isDark ? AppColors.textSecondaryDark : const Color(0xff334155),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String org,
    required String year,
    required bool isDark,
    required Color surfaceBg,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: surfaceBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                Text(org, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Text(
            year,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
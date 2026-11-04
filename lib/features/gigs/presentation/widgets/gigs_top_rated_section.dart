import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigsTopRatedSection extends StatelessWidget {
  final VoidCallback? onSeeAllTap;
  final ValueChanged<Map<String, dynamic>>? onViewGig;

  const GigsTopRatedSection({
    super.key,
    this.onSeeAllTap,
    this.onViewGig,
  });

  final List<Map<String, dynamic>> _topRatedGigs = const [
    {
      "cover": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=400&auto=format&fit=crop",
      "badge": "Top Rated",
      "badgeColor": Color(0xff1C3A5E),
      "title": "High Fashion Editorial Styling & Mood Boarding",
      "sellerAvatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=160&auto=format&fit=crop",
      "sellerName": "Mei Lin",
      "rating": "4.9",
      "tags": ["Fashion", "Luxury", "Editorial"],
      "delivery": "1-2 days",
      "orders": "204",
      "price": "₹12,000",
      "plan": "Standard",
    },
    {
      "cover": "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=400&auto=format&fit=crop",
      "badge": "Pro Seller",
      "badgeColor": Color(0xff7C3AED),
      "title": "Creative Art Direction & Campaign Concepts",
      "sellerAvatar": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=160&auto=format&fit=crop",
      "sellerName": "Sofia Reyes",
      "rating": "4.7",
      "tags": ["Tech", "D2C", "Campaign"],
      "delivery": "2-4 days",
      "orders": "57",
      "price": "₹14,000",
      "plan": "Standard",
    },
    {
      "cover": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=400&auto=format&fit=crop",
      "badge": "Top Rated",
      "badgeColor": Color(0xff1C3A5E),
      "title": "Fashion & Commercial Modelling",
      "sellerAvatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=160&auto=format&fit=crop",
      "sellerName": "Marco Bianchi",
      "rating": "4.9",
      "tags": ["Fashion", "FMCG", "Commercial"],
      "delivery": "On-site",
      "orders": "113",
      "price": "₹10,000",
      "plan": "Standard",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Header
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xff1C3A5E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 19),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Rated GIGs",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    Text(
                      "Consistently 4.8★ and above",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 11.5,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onSeeAllTap,
                child: const Row(
                  children: [
                    Text(
                      "See all",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2E7D6E),
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 16, color: Color(0xff2E7D6E)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Horizontal Split Cards
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _topRatedGigs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (ctx, idx) {
              final gig = _topRatedGigs[idx];

              return Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left: Thumbnail with Badge
                      SizedBox(
                        width: 120,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              gig['cover'] as String,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  color: gig['badgeColor'] as Color,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  gig['badge'] as String,
                                  style: const TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    color: Colors.white,
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right: Details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                gig['title'] as String,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 11,
                                    backgroundImage: NetworkImage(gig['sellerAvatar'] as String),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      gig['sellerName'] as String,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: AppTypography.fontFamilySans,
                                        fontSize: 11.5,
                                        color: textSecondary,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.star_rounded, size: 14, color: Color(0xffF59E0B)),
                                  const SizedBox(width: 2),
                                  Text(
                                    gig['rating'] as String,
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: (gig['tags'] as List<String>).map((t) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF1F5F9),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      t,
                                      style: const TextStyle(fontSize: 9.5, color: Color(0xff475569)),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.access_time_rounded, size: 12, color: textSecondary),
                                  const SizedBox(width: 3),
                                  Text(
                                    gig['delivery'] as String,
                                    style: TextStyle(fontSize: 10.5, color: textSecondary),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.inventory_2_outlined, size: 12, color: textSecondary),
                                  const SizedBox(width: 3),
                                  Text(
                                    gig['orders'] as String,
                                    style: TextStyle(fontSize: 10.5, color: textSecondary),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        gig['price'] as String,
                                        style: TextStyle(
                                          fontFamily: AppTypography.fontFamilySans,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        gig['plan'] as String,
                                        style: TextStyle(fontSize: 9.5, color: textSecondary),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => onViewGig?.call(gig),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.buttonGradientCreative,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        "View GIG",
                                        style: TextStyle(
                                          fontFamily: AppTypography.fontFamilySans,
                                          color: Colors.white,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
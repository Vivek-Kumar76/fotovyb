import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProsFeaturedGigsSection extends StatelessWidget {
  final VoidCallback? onAllGigsTap;
  final ValueChanged<Map<String, dynamic>>? onOrderGig;

  const ProsFeaturedGigsSection({
    super.key,
    this.onAllGigsTap,
    this.onOrderGig,
  });

  final List<Map<String, dynamic>> _featuredGigs = const [
    {
      "name": "Mei Lin",
      "package": "Styling\nPackage",
      "price": "₹8,000",
      "rating": "4.9",
      "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop",
      "cover": "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=500&auto=format&fit=crop",
    },
    {
      "name": "Kofi Mensah",
      "package": "Product\nPhotography",
      "price": "₹12,000",
      "rating": "4.9",
      "avatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop",
      "cover": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=500&auto=format&fit=crop",
    },
    {
      "name": "Arjun Kapoor",
      "package": "Brand Reel\nPack",
      "price": "₹9,500",
      "rating": "4.9",
      "avatar": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop",
      "cover": "https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?q=80&w=500&auto=format&fit=crop",
    },
    {
      "name": "Sofia Reyes",
      "package": "Art\nDirection",
      "price": "₹7,000",
      "rating": "4.8",
      "avatar": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop",
      "cover": "https://images.unsplash.com/photo-1560769629-975ec94e6a86?q=80&w=500&auto=format&fit=crop",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xff8B5CF6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.token_rounded, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Featured GIGs",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onAllGigsTap,
                child: const Text(
                  "All",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0D9488),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 2x2 Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _featuredGigs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (ctx, idx) {
              final gig = _featuredGigs[idx];
              return Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image with gold Featured tag & Price
                    Expanded(
                      flex: 6,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(gig['cover'] as String, fit: BoxFit.cover),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xffD97706),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.star_rounded,
                                      size: 10, color: Colors.white),
                                  SizedBox(width: 2),
                                  Text(
                                    "FEATURED",
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      color: Colors.white,
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            right: 8,
                            child: Text(
                              gig['price'] as String,
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Colors.white,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 4)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Info Row
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(gig['avatar'] as String),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  gig['name'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w800,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                gig['package'] as String,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff0D9488),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded,
                                      size: 13, color: Color(0xffF59E0B)),
                                  const SizedBox(width: 2),
                                  Text(
                                    gig['rating'] as String,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => onOrderGig?.call(gig),
                            child: Container(
                              height: 32,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonGradientCreative,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Order",
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  color: Colors.white,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
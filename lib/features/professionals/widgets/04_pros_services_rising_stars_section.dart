import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProsServicesRisingStarsSection extends StatelessWidget {
  final VoidCallback? onAllServicesTap;
  final ValueChanged<Map<String, dynamic>>? onApplyService;
  final VoidCallback? onAllRisingStarsTap;
  final ValueChanged<Map<String, dynamic>>? onConnectStar;
  final ValueChanged<Map<String, dynamic>>? onViewStar;

  const ProsServicesRisingStarsSection({
    super.key,
    this.onAllServicesTap,
    this.onApplyService,
    this.onAllRisingStarsTap,
    this.onConnectStar,
    this.onViewStar,
  });

  final List<Map<String, dynamic>> _services = const [
    {
      "icon": Icons.diamond_outlined,
      "iconBg": Color(0xffFEF3C7),
      "iconColor": Color(0xffD97706),
      "title": "Jewellery Campaign — Bridal 2025",
      "location": "Delhi",
      "price": "₹95,000",
    },
    {
      "icon": Icons.storefront_outlined,
      "iconBg": Color(0xffD1FAE5),
      "iconColor": Color(0xff059669),
      "title": "Property Brand Film — 3 Hotels",
      "location": "Goa",
      "price": "₹2,40,000",
    },
    {
      "icon": Icons.phone_iphone_rounded,
      "iconBg": Color(0xffFEE2E2),
      "iconColor": Color(0xffDC2626),
      "title": "Tech Launch Campaign",
      "location": "Bangalore",
      "price": "₹1,80,000",
    },
    {
      "icon": Icons.coffee_outlined,
      "iconBg": Color(0xffE0E7FF),
      "iconColor": Color(0xff4F46E5),
      "title": "Social Media Content (12 Reels)",
      "location": "Remote",
      "price": "₹45,000",
    },
  ];

  final List<Map<String, dynamic>> _risingStars = const [
    {
      "name": "Arjun Kapoor",
      "location": "Hyderabad",
      "role": "Videographer",
      "projects": "28 projects",
      "rating": "4.9",
      "price": "₹14,000",
      "cover":
          "https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?q=80&w=600&auto=format&fit=crop",
      "avatar":
          "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Sofia Reyes",
      "location": "Bangalore",
      "role": "Art Director",
      "projects": "34 projects",
      "rating": "4.8",
      "price": "₹11,000",
      "cover":
          "https://images.unsplash.com/photo-1560769629-975ec94e6a86?q=80&w=600&auto=format&fit=crop",
      "avatar":
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 26),

        // ── 1. "Featured Services" Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xff0D9488),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.store_mall_directory_rounded,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Featured Services",
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
                onTap: onAllServicesTap,
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
        ),

        const SizedBox(height: 14),

        // List of Vertical Service Cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _services.map((svc) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: svc['iconBg'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            svc['icon'] as IconData,
                            size: 16,
                            color: svc['iconColor'] as Color,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                svc['title'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: textColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_rounded,
                                      size: 12, color: textSecondary),
                                  const SizedBox(width: 2),
                                  Text(
                                    svc['location'] as String,
                                    style: TextStyle(
                                        fontSize: 11, color: textSecondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          svc['price'] as String,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => onApplyService?.call(svc),
                      child: Container(
                        height: 36,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGradientCreative,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Apply",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 24),

        // ── 2. "Rising Stars" Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xff7C3AED),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.trending_up_rounded,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Rising Stars",
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
                onTap: onAllRisingStarsTap,
                child: const Text(
                  "View all",
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
        ),

        const SizedBox(height: 14),

        // ── Rising Stars Horizontal Carousel (Height: 350 for 70/30 split)
        SizedBox(
          height: 350,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _risingStars.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (ctx, idx) {
              final star = _risingStars[idx];
              return Container(
                width: 250,
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── EXACT 70% PORTION: Cover Image with Rising Star Badge & Details Overlay
                    Expanded(
                      flex: 7,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            star['cover'] as String,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.2),
                                  Colors.black.withValues(alpha: 0.85),
                                ],
                                stops: const [0.5, 0.7, 1.0],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3.5),
                              decoration: BoxDecoration(
                                color: const Color(0xff7C3AED),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Text(
                                "Rising Star",
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  color: Colors.white,
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 12,
                            right: 12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      star['name'] as String,
                                      style: const TextStyle(
                                        fontFamily: AppTypography.fontFamilySans,
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_rounded,
                                            size: 11, color: Colors.white70),
                                        const SizedBox(width: 2),
                                        Text(
                                          star['location'] as String,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      star['price'] as String,
                                      style: const TextStyle(
                                        fontFamily: AppTypography.fontFamilySans,
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const Text(
                                      "/ day",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
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

                    // ── EXACT 30% PORTION: Avatar, Role, Rating & Action Buttons
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage:
                                      NetworkImage(star['avatar'] as String),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        star['role'] as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily:
                                              AppTypography.fontFamilySans,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        star['projects'] as String,
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          color: textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFEF3C7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star_rounded,
                                          size: 13, color: Color(0xffD97706)),
                                      const SizedBox(width: 2),
                                      Text(
                                        star['rating'] as String,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff92400E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => onConnectStar?.call(star),
                                    child: Container(
                                      height: 34,
                                      decoration: BoxDecoration(
                                        gradient:
                                            AppColors.buttonGradientCreative,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                              Icons.person_add_alt_1_rounded,
                                              size: 13,
                                              color: Colors.white),
                                          SizedBox(width: 4),
                                          Text(
                                            "Connect",
                                            style: TextStyle(
                                              fontFamily:
                                                  AppTypography.fontFamilySans,
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => onViewStar?.call(star),
                                    child: Container(
                                      height: 34,
                                      decoration: BoxDecoration(
                                        color: cardBg,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(color: borderColor),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.remove_red_eye_outlined,
                                              size: 13, color: textColor),
                                          const SizedBox(width: 4),
                                          Text(
                                            "View",
                                            style: TextStyle(
                                              fontFamily:
                                                  AppTypography.fontFamilySans,
                                              color: textColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
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
              );
            },
          ),
        ),

        const SizedBox(height: 50),
      ],
    );
  }
}
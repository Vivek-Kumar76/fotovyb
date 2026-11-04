import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigsFeaturedSection extends StatelessWidget {
  final ValueChanged<Map<String, dynamic>>? onViewGig;
  final ValueChanged<Map<String, dynamic>>? onChat;
  final ValueChanged<Map<String, dynamic>>? onBookmark;

  const GigsFeaturedSection({
    super.key,
    this.onViewGig,
    this.onChat,
    this.onBookmark,
  });

  final List<Map<String, dynamic>> _featuredGigs = const [
    {
      "cover": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=800&auto=format&fit=crop",
      "category": "Photography",
      "sellerAvatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop",
      "sellerName": "Kofi Mensah",
      "sellerBadge": "Pro Seller",
      "sellerLocation": "Bangalore",
      "rating": "4.9",
      "title": "Cinematic Fashion & Editorial Photography",
      "tags": ["Fashion", "Automotive", "Editorial", "Cinematic"],
      "delivery": "2-3 days",
      "orders": "142 orders",
      "tiers": [
        {"label": "Basic", "price": "₹8,000"},
        {"label": "Standard", "price": "₹15,000"},
        {"label": "Premium", "price": "₹40,000"},
      ],
      "defaultTier": 1,
    },
    {
      "cover": "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=800&auto=format&fit=crop",
      "category": "Makeup & Beauty",
      "sellerAvatar": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop",
      "sellerName": "Priya Nair",
      "sellerBadge": "Pro Seller",
      "sellerLocation": "Delhi",
      "rating": "4.8",
      "title": "Luxury & Editorial Makeup Artistry",
      "tags": ["Film", "Bridal", "Luxury", "Bridal"],
      "delivery": "On-site",
      "orders": "89 orders",
      "tiers": [
        {"label": "Basic", "price": "₹3,500"},
        {"label": "Standard", "price": "₹8,000"},
        {"label": "Premium", "price": "₹22,000"},
      ],
      "defaultTier": 1,
    },
    {
      "cover": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=800&auto=format&fit=crop",
      "category": "Styling",
      "sellerAvatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
      "sellerName": "Reza Tehrani",
      "sellerBadge": "Top Rated",
      "sellerLocation": "Delhi",
      "rating": "4.9",
      "title": "High Fashion Styling & Celebrity Wardrobe",
      "tags": ["Film", "Fashion", "High Fashion", "Celebrity"],
      "delivery": "On-site",
      "orders": "77 orders",
      "tiers": [
        {"label": "Basic", "price": "₹8,000"},
        {"label": "Standard", "price": "₹18,000"},
        {"label": "Premium", "price": "₹50,000"},
      ],
      "defaultTier": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section Title
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xffD97706),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star_rounded, color: Colors.white, size: 19),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Featured GIGs",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  Text(
                    "Hand-picked for quality",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 11.5,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Vertical Cards
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _featuredGigs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (ctx, idx) {
              return _VerticalGigCard(
                gig: _featuredGigs[idx],
                isDark: isDark,
                onViewGig: () => onViewGig?.call(_featuredGigs[idx]),
                onChat: () => onChat?.call(_featuredGigs[idx]),
                onBookmark: () => onBookmark?.call(_featuredGigs[idx]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VerticalGigCard extends StatefulWidget {
  final Map<String, dynamic> gig;
  final bool isDark;
  final VoidCallback onViewGig;
  final VoidCallback onChat;
  final VoidCallback onBookmark;

  const _VerticalGigCard({
    required this.gig,
    required this.isDark,
    required this.onViewGig,
    required this.onChat,
    required this.onBookmark,
  });

  @override
  State<_VerticalGigCard> createState() => _VerticalGigCardState();
}

class _VerticalGigCardState extends State<_VerticalGigCard> {
  late int _selectedTierIndex;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _selectedTierIndex = widget.gig['defaultTier'] as int? ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = widget.isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final cardBg = widget.isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = widget.isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    final tiers = widget.gig['tiers'] as List<Map<String, dynamic>>;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cover Image with Badges
          Stack(
            children: [
              Image.network(
                widget.gig['cover'] as String,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Top-left "★ Featured" Gold Badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xffD97706),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star_rounded, size: 13, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "Featured",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom-left Category Indicator
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 3, backgroundColor: Color(0xff10B981)),
                      const SizedBox(width: 5),
                      Text(
                        widget.gig['category'] as String,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Top-right Bookmark Button
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _isSaved = !_isSaved);
                    widget.onBookmark();
                  },
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: _isSaved ? const Color(0xffEF4444) : const Color(0xff1E293B),
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Card Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Seller Row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: NetworkImage(widget.gig['sellerAvatar'] as String),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.gig['sellerName'] as String,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "${widget.gig['sellerBadge']} · ${widget.gig['sellerLocation']}",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 16, color: Color(0xffF59E0B)),
                        const SizedBox(width: 2),
                        Text(
                          widget.gig['rating'] as String,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // GIG Title
                Text(
                  widget.gig['title'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 10),

                // Tags Row
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (widget.gig['tags'] as List<String>).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.isDark ? const Color(0xff1E293B) : const Color(0xffF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xff0D9488).withValues(alpha: 0.18),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0F766E),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                // Metadata: Delivery & Orders
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 14, color: textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      widget.gig['delivery'] as String,
                      style: TextStyle(fontSize: 11.5, color: textSecondary),
                    ),
                    const SizedBox(width: 14),
                    Icon(Icons.inventory_2_outlined, size: 14, color: textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      widget.gig['orders'] as String,
                      style: TextStyle(fontSize: 11.5, color: textSecondary),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Tier Selector Capsules
                Row(
                  children: List.generate(tiers.length, (idx) {
                    final t = tiers[idx];
                    final isSelected = _selectedTierIndex == idx;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTierIndex = idx),
                        child: Container(
                          margin: EdgeInsets.only(right: idx < tiers.length - 1 ? 8 : 0),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xffF0FDFA)
                                : (widget.isDark ? const Color(0xff1E293B) : const Color(0xffF8FAFC)),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected ? const Color(0xff0D9488) : borderColor,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                t['label'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: textSecondary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                t['price'] as String,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected ? const Color(0xff0D9488) : textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 14),

                // Action Buttons: "View GIG" + Chat Icon
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.onViewGig,
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: AppColors.buttonGradientCreative,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "View GIG",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: widget.onChat,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.isDark ? const Color(0xff1E293B) : const Color(0xffF1F5F9),
                          border: Border.all(color: borderColor),
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: textColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
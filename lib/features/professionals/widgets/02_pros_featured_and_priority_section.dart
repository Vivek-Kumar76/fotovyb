import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProsFeaturedAndPrioritySection extends StatefulWidget {
  final VoidCallback? onViewAllPros;
  final ValueChanged<Map<String, dynamic>>? onConnectPro;
  final ValueChanged<Map<String, dynamic>>? onViewPro;
  final VoidCallback? onAllJobsTap;
  final ValueChanged<Map<String, dynamic>>? onPriorityJobTap;

  const ProsFeaturedAndPrioritySection({
    super.key,
    this.onViewAllPros,
    this.onConnectPro,
    this.onViewPro,
    this.onAllJobsTap,
    this.onPriorityJobTap,
  });

  @override
  State<ProsFeaturedAndPrioritySection> createState() =>
      _ProsFeaturedAndPrioritySectionState();
}

class _ProsFeaturedAndPrioritySectionState
    extends State<ProsFeaturedAndPrioritySection> {
  String _selectedRoleFilter = "All";
  String _selectedSortFilter = "Featured (48)";

  final List<Map<String, dynamic>> _roleFilters = const [
    {"label": "All", "icon": Icons.groups_rounded},
    {"label": "Photographer", "icon": Icons.camera_alt_outlined},
    {"label": "Stylist", "icon": Icons.interests_outlined},
    {"label": "Model", "icon": Icons.person_outline_rounded},
  ];

  final List<Map<String, dynamic>> _statusFilters = const [
    {
      "label": "Top Rated (240)",
      "icon": Icons.star_border_rounded,
      "color": Color(0xffD97706)
    },
    {
      "label": "Featured (48)",
      "icon": Icons.trending_up_rounded,
      "color": Color(0xff0D9488)
    },
    {
      "label": "Rising Stars",
      "icon": Icons.bolt_rounded,
      "color": Color(0xff7C3AED)
    },
  ];

  final List<Map<String, dynamic>> _featuredPros = const [
    {
      "name": "Mei Lin",
      "location": "Mumbai",
      "role": "Fashion Stylist",
      "projects": "47 projects",
      "rating": "4.9",
      "price": "₹12,000",
      "cover":
          "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=600&auto=format&fit=crop",
      "avatar":
          "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Kofi Mensah",
      "location": "Bangalore",
      "role": "Editorial Photographer",
      "projects": "86 projects",
      "rating": "4.9",
      "price": "₹18,000",
      "cover":
          "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=600&auto=format&fit=crop",
      "avatar":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Arjun Kapoor",
      "location": "Hyderabad",
      "role": "Cinematographer",
      "projects": "38 projects",
      "rating": "4.8",
      "price": "₹14,000",
      "cover":
          "https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?q=80&w=600&auto=format&fit=crop",
      "avatar":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop",
    },
  ];

  final List<Map<String, dynamic>> _priorityJobs = const [
    {
      "title": "Automotive Photographer",
      "location": "Bangalore",
      "budget": "₹85,000",
      "deadline": "3d left",
      "icon": Icons.directions_car_rounded,
      "bgGradient": [Color(0xff1D4ED8), Color(0xff1E3A8A)],
    },
    {
      "title": "Editorial Cover Shoot",
      "location": "Mumbai",
      "budget": "₹60,000",
      "deadline": "5d left",
      "icon": Icons.camera_indoor_rounded,
      "bgGradient": [Color(0xff1E293B), Color(0xff0F172A)],
    },
    {
      "title": "Brand Film — Goa Launch",
      "location": "Goa",
      "budget": "₹1,20,000",
      "deadline": "7d left",
      "icon": Icons.videocam_rounded,
      "bgGradient": [Color(0xff0D9488), Color(0xff115E59)],
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
        const SizedBox(height: 16),

        // ── Row 1: Role Pills
        SizedBox(
          height: 38,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _roleFilters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, idx) {
              final item = _roleFilters[idx];
              final isSelected = _selectedRoleFilter == item['label'];

              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedRoleFilter = item['label'] as String),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    gradient:
                        isSelected ? AppColors.buttonGradientCreative : null,
                    color: isSelected ? null : cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : borderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        size: 14,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xff64748B),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xff475569),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // ── Row 2: Status Badges
        SizedBox(
          height: 36,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _statusFilters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, idx) {
              final item = _statusFilters[idx];
              final isSelected = _selectedSortFilter == item['label'];
              final color = item['color'] as Color;

              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedSortFilter = item['label'] as String),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? color.withValues(alpha: 0.12) : cardBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? color : borderColor,
                      width: isSelected ? 1.4 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(item['icon'] as IconData, size: 14, color: color),
                      const SizedBox(width: 5),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // ── "Featured Pros" Header
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
                      color: Color(0xffD97706),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.star_rounded,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Featured Pros",
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
                onTap: widget.onViewAllPros,
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

        // ── Featured Pros Horizontal Carousel (Height: 350 for 70/30 balance)
        SizedBox(
          height: 350,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _featuredPros.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (ctx, idx) {
              final pro = _featuredPros[idx];
              return _buildProCard(
                  pro, cardBg, borderColor, textColor, textSecondary);
            },
          ),
        ),

        const SizedBox(height: 26),

        // ── "Top Priority" Header
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
                      color: Color(0xffEF4444),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.flash_on_rounded,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Top Priority",
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
                onTap: widget.onAllJobsTap,
                child: const Text(
                  "All jobs",
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

        const SizedBox(height: 12),

        // ── 3 Colored Priority Cards Stack
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _priorityJobs.map((job) {
              return GestureDetector(
                onTap: () => widget.onPriorityJobTap?.call(job),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: job['bgGradient'] as List<Color>,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          job['icon'] as IconData,
                          size: 18,
                          color: (job['bgGradient'] as List<Color>).first,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job['title'] as String,
                              style: const TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded,
                                    size: 12, color: Colors.white70),
                                const SizedBox(width: 2),
                                Text(
                                  job['location'] as String,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            job['budget'] as String,
                            style: const TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            job['deadline'] as String,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 10.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProCard(
    Map<String, dynamic> pro,
    Color cardBg,
    Color borderColor,
    Color textColor,
    Color textSecondary,
  ) {
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
          // ── EXACT 70% PORTION: Cover Image with Badges & Name Overlay
          Expanded(
            flex: 7,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  pro['cover'] as String,
                  fit: BoxFit.cover,
                ),
                // Gradient vignette over the bottom of the photo
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
                // Top-Left: "★ FEATURED"
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xffD97706),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_rounded, size: 11, color: Colors.white),
                        SizedBox(width: 3),
                        Text(
                          "FEATURED",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Top-Right: "Top Rated"
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xffB45309),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      "Top Rated",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                // Bottom of Image: Name, Location & Day Rate
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
                            pro['name'] as String,
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
                                pro['location'] as String,
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
                            pro['price'] as String,
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
                        backgroundImage: NetworkImage(pro['avatar'] as String),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pro['role'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                            Text(
                              pro['projects'] as String,
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
                              pro['rating'] as String,
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
                          onTap: () => widget.onConnectPro?.call(pro),
                          child: Container(
                            height: 34,
                            decoration: BoxDecoration(
                              gradient: AppColors.buttonGradientCreative,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add_alt_1_rounded,
                                    size: 13, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  "Connect",
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
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => widget.onViewPro?.call(pro),
                          child: Container(
                            height: 34,
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: borderColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.remove_red_eye_outlined,
                                    size: 13, color: textColor),
                                const SizedBox(width: 4),
                                Text(
                                  "View",
                                  style: TextStyle(
                                    fontFamily: AppTypography.fontFamilySans,
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
  }
}
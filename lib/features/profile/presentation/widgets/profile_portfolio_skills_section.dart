import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProfilePortfolioSkillsSection extends StatefulWidget {
  final GlobalKey? overviewKey;
  final GlobalKey? portfolioKey;
  final ValueChanged<int>? onTabTap;

  const ProfilePortfolioSkillsSection({
    super.key,
    this.overviewKey,
    this.portfolioKey,
    this.onTabTap,
  });

  @override
  State<ProfilePortfolioSkillsSection> createState() =>
      _ProfilePortfolioSkillsSectionState();
}

class _ProfilePortfolioSkillsSectionState
    extends State<ProfilePortfolioSkillsSection> {
  int _selectedTabIndex = 0;
  bool _isExpanded = false;

  final List<String> _tabs = const [
    "Overview",
    "Portfolio",
    "Packages",
    "Reviews",
  ];

  final List<Map<String, dynamic>> mediaItems = const [
    {
      "url": "https://images.unsplash.com/photo-1617814076367-b759c7d7e738?q=80&w=500&auto=format&fit=crop",
      "isVideo": false,
    },
    {
      "url": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=500&auto=format&fit=crop",
      "isVideo": false,
    },
    {
      "url": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=500&auto=format&fit=crop",
      "isVideo": false,
    },
    {
      "url": "https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?q=80&w=500&auto=format&fit=crop",
      "isVideo": true,
    },
    {
      "url": "https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=500&auto=format&fit=crop",
      "isVideo": false,
    },
    {
      "url": "https://images.unsplash.com/photo-1560769629-975ec94e6a86?q=80&w=500&auto=format&fit=crop",
      "isVideo": false,
    },
  ];

  final List<String> skills = const [
    "Fashion Photography",
    "Editorial Styling",
    "Cinematic Lighting",
    "On-location Shoots",
    "Post Production",
    "Color Grading",
    "Mood Boarding",
    "Brand Identity",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color chipBg = isDark ? AppColors.surfaceDark : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Sticky Navigation Tab Bar
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: borderColor, width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (index) {
              final isSelected = _selectedTabIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedTabIndex = index);
                  widget.onTabTap?.call(index);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: isSelected
                        ? const Border(
                            bottom: BorderSide(
                              color: AppColors.primary,
                              width: 2.5,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 13.5,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? AppColors.primary : textSecondary,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 18),

        // ── 2. Content Body
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Anchor: OVERVIEW (About Section)
              Container(
                key: widget.overviewKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ABOUT",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Bangalore-based commercial & editorial photographer. 5+ years crafting visual stories for luxury brands, automotive and fashion labels — cinematic light, real emotion.",
                      maxLines: _isExpanded ? null : 3,
                      overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 13,
                        height: 1.45,
                        color: isDark ? AppColors.textSecondaryDark : const Color(0xff334155),
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      child: Text(
                        _isExpanded ? "Show less" : "Read more",
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ── 2x2 Metric Capsules
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCapsule(
                      icon: Icons.access_time_rounded,
                      label: "Response",
                      value: "< 2 hrs",
                      borderColor: borderColor,
                      cardBg: chipBg,
                      textColor: textColor,
                      textSecondary: textSecondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMetricCapsule(
                      icon: Icons.check_circle_outline_rounded,
                      label: "Completion",
                      value: "98%",
                      borderColor: borderColor,
                      cardBg: chipBg,
                      textColor: textColor,
                      textSecondary: textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCapsule(
                      icon: Icons.sync_rounded,
                      label: "Repeat",
                      value: "74%",
                      borderColor: borderColor,
                      cardBg: chipBg,
                      textColor: textColor,
                      textSecondary: textSecondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildMetricCapsule(
                      icon: Icons.translate_rounded,
                      label: "Languages",
                      value: "EN·HI·KN",
                      borderColor: borderColor,
                      cardBg: chipBg,
                      textColor: textColor,
                      textSecondary: textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Anchor: PORTFOLIO (Photos & Videos)
              Row(
                key: widget.portfolioKey,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.collections_outlined, color: AppColors.primary, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "PHOTOS & VIDEOS",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      children: [
                        Text(
                          "View all 124",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 16, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 2x3 Squircle Portfolio Media Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mediaItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final item = mediaItems[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      image: DecorationImage(
                        image: NetworkImage(item['url'] as String),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: item['isVideo'] == true
                              ? Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 16),
                                )
                              : const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 14,
                                  shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // ── Header: Skilled In
              const Row(
                children: [
                  Icon(Icons.bolt_rounded, color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "SKILLED IN",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: chipBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: borderColor),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // ── Header: Specialist In
              const Row(
                children: [
                  Icon(Icons.auto_awesome, color: AppColors.primary, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "SPECIALIST IN",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildSpecialistPill("Luxury Brands")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildSpecialistPill("Automotive")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildSpecialistPill("High Fashion Editorial")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildSpecialistPill("Portraiture")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCapsule({
    required IconData icon,
    required String label,
    required String value,
    required Color borderColor,
    required Color cardBg,
    required Color textColor,
    required Color textSecondary,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 11,
                    color: textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialistPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradientCreative,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star_border_rounded, size: 15, color: Colors.white),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class OpportunitiesHeaderAndHero extends StatelessWidget {
  final int activeFilterCount;
  final VoidCallback onNotificationsTap;
  final VoidCallback onFilterTap;

  const OpportunitiesHeaderAndHero({
    super.key,
    required this.activeFilterCount,
    required this.onNotificationsTap,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final topPadding = MediaQuery.paddingOf(context).top;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final hPad = screenW * 0.04;

        return Column(
          children: [
            // ── Top Navigation Bar
            Container(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              padding: EdgeInsets.fromLTRB(
                hPad,
                topPadding + screenW * 0.015,
                hPad,
                screenW * 0.025,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontSize: screenW * 0.046,
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
                            TextSpan(
                              text: "FOTO",
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xff1E293B),
                              ),
                            ),
                            const TextSpan(
                              text: "VYB",
                              style: TextStyle(color: Color(0xff0D9488)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "A PREMIUM PHOTOGRAPHY MARKETPLACE",
                        style: TextStyle(
                          fontSize: screenW * 0.014,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: const Color(0xff64748B),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildCircleBtn(
                        screenW: screenW,
                        isDark: isDark,
                        icon: Icons.notifications_none_rounded,
                        onTap: onNotificationsTap,
                      ),
                      SizedBox(width: screenW * 0.02),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _buildCircleBtn(
                            screenW: screenW,
                            isDark: isDark,
                            icon: Icons.filter_alt_outlined,
                            onTap: onFilterTap,
                          ),
                          if (activeFilterCount > 0)
                            Positioned(
                              top: -screenW * 0.008,
                              right: -screenW * 0.008,
                              child: Container(
                                padding: EdgeInsets.all(screenW * 0.011),
                                decoration: const BoxDecoration(
                                  color: Color(0xff0D9488),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$activeFilterCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenW * 0.023,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Dark Hero Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: screenW * 0.055,
                horizontal: screenW * 0.05,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff081927),
                    Color(0xff0B2436),
                    Color(0xff0E2F3D),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Service Opportunities",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white,
                      fontSize: screenW * 0.056,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: screenW * 0.01),
                  Text(
                    "Connect with top brands",
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: screenW * 0.032,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCircleBtn({
    required double screenW,
    required bool isDark,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final btnSize = screenW * 0.092;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnSize,
        height: btnSize,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark ? AppColors.borderDark : const Color(0xffE2E8F0),
          ),
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white : const Color(0xff1E293B),
          size: btnSize * 0.52,
        ),
      ),
    );
  }
}
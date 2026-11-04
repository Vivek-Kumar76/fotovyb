import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart'; //[cite: 2]
import '../../../home/presentation/screens/home.dart'; //[cite: 16]

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    HomePage(), //[cite: 16]
    _TabPlaceholderScreen(title: "Professionals", icon: Icons.groups_outlined),
    _TabPlaceholderScreen(title: "Opportunities", icon: Icons.work_outline_rounded),
    _TabPlaceholderScreen(title: "GIGs", icon: Icons.view_in_ar_rounded),
    _TabPlaceholderScreen(title: "Messaging", icon: Icons.chat_bubble_outline_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color surfaceColor = isDark ? AppColors.surfaceDark : Colors.white; //[cite: 1]
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0); //[cite: 1]
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary; //[cite: 1]
    final Color inactiveColor = isDark ? AppColors.textMutedDark : const Color(0xff64748B); //[cite: 1]

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          border: Border(top: BorderSide(color: borderColor, width: 1.0)),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 62,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, "Home", Icons.home_outlined, Icons.home_rounded, activeColor, inactiveColor),
                _buildNavItem(1, "Professionals", Icons.groups_outlined, Icons.groups_rounded, activeColor, inactiveColor),
                _buildNavItem(2, "Opportunities", Icons.work_outline_rounded, Icons.work_rounded, activeColor, inactiveColor),
                _buildNavItem(3, "GIGs", Icons.view_in_ar_outlined, Icons.view_in_ar_rounded, activeColor, inactiveColor),
                _buildNavItem(4, "Messaging", Icons.chat_bubble_outline_rounded, Icons.chat_bubble_rounded, activeColor, inactiveColor, badgeCount: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String label,
    IconData outlinedIcon,
    IconData filledIcon,
    Color activeColor,
    Color inactiveColor, {
    int? badgeCount,
  }) {
    final bool isSelected = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isSelected ? filledIcon : outlinedIcon,
                  color: isSelected ? activeColor : inactiveColor,
                  size: 22,
                ),
                if (badgeCount != null && badgeCount > 0)
                  Positioned(
                    top: -2,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: const BoxDecoration(
                        color: Color(0xffEF4444),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: Text(
                        '$badgeCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Generic Placeholder Screen for Secondary Navigation Tabs
class _TabPlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const _TabPlaceholderScreen({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight; //[cite: 1]
    final textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight; //[cite: 1]

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans, //[cite: 6]
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: textColor,
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9), //[cite: 1]
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: AppColors.primary), //[cite: 1]
            ),
            const SizedBox(height: 16),
            Text(
              "$title Screen",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Coming soon in this section",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                fontSize: 13,
                color: textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
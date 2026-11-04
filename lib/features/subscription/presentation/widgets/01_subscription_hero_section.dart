import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class SubscriptionHeroSection extends StatelessWidget {
  final VoidCallback? onBack;
  final String selectedDuration;
  final ValueChanged<String> onDurationChanged;

  const SubscriptionHeroSection({
    super.key,
    this.onBack,
    required this.selectedDuration,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff081927),
            Color(0xff0B2436),
            Color(0xff0E2F3D),
            Color(0xff0A1E29),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 26),
      child: Column(
        children: [
          // ── Top Navigation Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(text: "FOTO", style: TextStyle(color: Colors.white)),
                    TextSpan(text: "VYB", style: TextStyle(color: Color(0xff34D399))),
                  ],
                ),
              ),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xff0D9488), width: 1.8),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Small Gold Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xffD97706).withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xffF59E0B).withValues(alpha: 0.5),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium_rounded,
                    size: 12, color: Color(0xffFBBF24)),
                SizedBox(width: 4),
                Text(
                  "CREATIVE PRO SUBSCRIPTIONS",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Color(0xffFBBF24),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ── Headline
          const Text(
            "Grow Faster with the\nRight Subscription",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1.2,
              letterSpacing: -0.4,
            ),
          ),

          const SizedBox(height: 8),

          // ── Subtitle
          Text(
            "Flexible creative tiers, guaranteed visibility — cancel or upgrade anytime",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 11.5,
            ),
          ),

          const SizedBox(height: 20),

          // ── Interactive Billing Toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTogglePill("30 Days Standard", selectedDuration == "30 Days"),
                _buildTogglePill("7 Days Trial", selectedDuration == "7 Days"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTogglePill(String title, bool isSelected) {
    return GestureDetector(
      onTap: () => onDurationChanged(title.contains("7") ? "7 Days" : "30 Days"),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.buttonGradientCreative : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}
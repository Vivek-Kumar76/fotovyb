import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class GigReviewsSection extends StatelessWidget {
  const GigReviewsSection({super.key});

  final List<Map<String, dynamic>> reviews = const [
    {
      "name": "Riya Patel",
      "brand": "Vogue India",
      "time": "1 week ago",
      "rating": 5,
      "title": "Outstanding editorial work!",
      "comment": "Kofi delivered exceptional cinematic photography for our spring lookbook. His attention to detail, lighting expertise, and post-production work exceeded our expectations. Highly recommended!",
      "helpful": 12,
      "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80",
    },
    {
      "name": "Vikram Singh",
      "brand": "Volta Motors",
      "time": "2 weeks ago",
      "rating": 5,
      "title": "Perfect automotive campaign",
      "comment": "Exactly what we needed for our EV launch campaign. Kofi understood our vision instantly and delivered stunning images that truly capture the essence of our brand.",
      "helpful": 8,
      "avatar": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80",
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Customer Reviews",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              Text(
                "96 reviews",
                style: TextStyle(fontSize: 12, color: textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Rating Breakdown Summary Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "4.9",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: textColor,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (_) => const Icon(Icons.star_rounded, size: 14, color: Color(0xffF59E0B)),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "overall rating",
                      style: TextStyle(fontSize: 10, color: textSecondary),
                    ),
                  ],
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    children: [
                      _buildRatingBar("5★", 0.90, "89"),
                      _buildRatingBar("4★", 0.08, "6"),
                      _buildRatingBar("3★", 0.02, "1"),
                      _buildRatingBar("2★", 0.0, "0"),
                      _buildRatingBar("1★", 0.0, "0"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Customer Review Cards
          ...reviews.map((rev) => _buildReviewCard(rev, cardBg, borderColor, textColor, textSecondary)),

          // View All Button
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 42),
              shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
              side: BorderSide(color: borderColor),
            ),
            onPressed: () {},
            child: Text(
              "View All 96 Reviews",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String star, double fill, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        children: [
          Text(star, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600)),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fill,
                minHeight: 5,
                backgroundColor: const Color(0xffE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffD97706)),
              ),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 16,
            child: Text(count, style: const TextStyle(fontSize: 9.5, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    Map<String, dynamic> r,
    Color bg,
    Color border,
    Color textPrimary,
    Color textMuted,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(r['avatar'] as String),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r['name'] as String,
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: textPrimary),
                    ),
                    Text(
                      "${r['brand']} · ${r['time']}",
                      style: TextStyle(fontSize: 10.5, color: textMuted),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  r['rating'] as int,
                  (_) => const Icon(Icons.star_rounded, size: 14, color: Color(0xffF59E0B)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            r['title'] as String,
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: textPrimary),
          ),
          const SizedBox(height: 3),
          Text(
            r['comment'] as String,
            style: TextStyle(fontSize: 11.5, color: textMuted, height: 1.35),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ComplementaryGigs extends StatelessWidget {
  const ComplementaryGigs({super.key});

  final List<Map<String, dynamic>> complementaryList = const [
    {
      "title": "High Fashion Editorial Styling & Mood Boarding",
      "price": "₹12,000",
      "rating": "4.9 (126)",
      "author": "Mei Lin · Mumbai",
      "badge": "Top Rated",
      "badgeColor": Color(0xff2563EB),
      "image": "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=400&q=80",
    },
    {
      "title": "Brand Film & Social Reels Production",
      "price": "₹18,000",
      "rating": "4.8 (53)",
      "author": "Arjun Kapoor · Hyderabad",
      "badge": "New",
      "badgeColor": Color(0xff059669),
      "image": "https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?auto=format&fit=crop&w=400&q=80",
    },
    {
      "title": "Luxury & Editorial Makeup Artistry",
      "price": "₹8,000",
      "rating": "4.9 (74)",
      "author": "Priya Nair · Delhi",
      "badge": "Featured",
      "badgeColor": Color(0xffD97706),
      "image": "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=400&q=80",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space5),
          child: Text(
            "Complementary Services",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space5),
            scrollDirection: Axis.horizontal,
            itemCount: complementaryList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final gig = complementaryList[index];
              return Container(
                width: 200,
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network(
                            gig['image'] as String,
                            height: 105,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: gig['badgeColor'] as Color,
                              borderRadius: AppRadius.radiusFull,
                            ),
                            child: Text(
                              gig['badge'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gig['title'] as String,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            gig['author'] as String,
                            style: TextStyle(fontSize: 10, color: textSecondary),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            gig['price'] as String,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: 13,
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
            },
          ),
        ),
      ],
    );
  }
}
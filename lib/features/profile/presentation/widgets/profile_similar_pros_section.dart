import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class ProfileSimilarProsSection extends StatelessWidget {
  const ProfileSimilarProsSection({super.key});

  final List<Map<String, dynamic>> similarPros = const [
    {
      "name": "Priya Nair",
      "role": "Photographer",
      "location": "Chennai",
      "rating": "4.7",
      "avatar": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Arjun Kapoor",
      "role": "Videographer",
      "location": "Hyderabad",
      "rating": "4.9",
      "avatar": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop",
    },
    {
      "name": "Mei Lin",
      "role": "Fashion Stylist",
      "location": "Mumbai",
      "rating": "4.9",
      "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop",
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
          Text(
            "SIMILAR PROFESSIONALS",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: similarPros.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final pro = similarPros[index];
              return Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(pro['avatar'] as String),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pro['name'] as String,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          pro['role'] as String,
                          style: const TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xff2E7D6E),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 12, color: textSecondary),
                            const SizedBox(width: 3),
                            Text(
                              pro['location'] as String,
                              style: TextStyle(fontSize: 11, color: textSecondary),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.star_rounded, size: 13, color: Color(0xffF59E0B)),
                            const SizedBox(width: 2),
                            Text(
                              pro['rating'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      side: const BorderSide(color: Color(0xff2E7D6E), width: 1.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "View",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Color(0xff2E7D6E),
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
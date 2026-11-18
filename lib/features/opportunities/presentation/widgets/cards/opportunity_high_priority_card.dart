import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/opportunity_item_model.dart';

class OpportunityHighPriorityCard extends StatelessWidget {
  final OpportunityItemModel opportunity;
  final bool isApplying;
  final VoidCallback? onApply;
  final VoidCallback? onTap;

  const OpportunityHighPriorityCard({
    super.key,
    required this.opportunity,
    this.isApplying = false,
    this.onApply,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;
        final cardH = cardW * 0.86;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: cardW,
            height: cardH,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardW * 0.062),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: cardW * 0.035,
                  offset: Offset(0, cardH * 0.015),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ── Cover Image with Safe Fallback
                if (opportunity.hasValidImage)
                  Image.network(
                    opportunity.imageUrl.trim(),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildFallbackCover(cardW),
                  )
                else
                  _buildFallbackCover(cardW),

                // ── Bottom Gradient Scrim
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.12),
                        Colors.black.withValues(alpha: 0.38),
                        Colors.black.withValues(alpha: 0.92),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),

                // ── Top-Right URGENT Badge
                Positioned(
                  top: cardH * 0.045,
                  right: cardW * 0.04,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: cardW * 0.026,
                      vertical: cardH * 0.014,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffEF4444),
                      borderRadius: BorderRadius.circular(cardW * 0.045),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flash_on_rounded,
                          size: cardW * 0.034,
                          color: Colors.white,
                        ),
                        SizedBox(width: cardW * 0.008),
                        Text(
                          "URGENT",
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamilySans,
                            color: Colors.white,
                            fontSize: cardW * 0.028,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Bottom Content Overlay
                Positioned(
                  left: cardW * 0.045,
                  right: cardW * 0.045,
                  bottom: cardH * 0.052,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        opportunity.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: Colors.white,
                          fontSize: cardW * 0.045,
                          fontWeight: FontWeight.w800,
                          height: 1.24,
                        ),
                      ),
                      SizedBox(height: cardH * 0.02),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: cardW * 0.036,
                            color: Colors.white70,
                          ),
                          SizedBox(width: cardW * 0.008),
                          Flexible(
                            child: Text(
                              opportunity.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: cardW * 0.032,
                              ),
                            ),
                          ),
                          SizedBox(width: cardW * 0.028),
                          Icon(
                            Icons.access_time_rounded,
                            size: cardW * 0.036,
                            color: Colors.white70,
                          ),
                          SizedBox(width: cardW * 0.008),
                          Text(
                            opportunity.duration,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: cardW * 0.032,
                            ),
                          ),
                        ],
                      ),
                      if (opportunity.roles.isNotEmpty) ...[
                        SizedBox(height: cardH * 0.026),
                        Wrap(
                          spacing: cardW * 0.018,
                          runSpacing: cardH * 0.014,
                          children: opportunity.roles.take(3).map((role) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: cardW * 0.026,
                                vertical: cardH * 0.011,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.22),
                                borderRadius:
                                    BorderRadius.circular(cardW * 0.04),
                              ),
                              child: Text(
                                role,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: cardW * 0.03,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                      SizedBox(height: cardH * 0.038),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              opportunity.budgetDisplay,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Colors.white,
                                fontSize: cardW * 0.054,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(width: cardW * 0.03),
                          GestureDetector(
                            onTap: (opportunity.isApplied || isApplying)
                                ? null
                                : onApply,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: cardW * 0.052,
                                vertical: cardH * 0.026,
                              ),
                              decoration: BoxDecoration(
                                color: opportunity.isApplied
                                    ? const Color(0xff0D9488)
                                    : Colors.white.withValues(alpha: 0.25),
                                borderRadius:
                                    BorderRadius.circular(cardW * 0.056),
                                border: Border.all(
                                  color: opportunity.isApplied
                                      ? Colors.transparent
                                      : Colors.white.withValues(alpha: 0.42),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (opportunity.isApplied) ...[
                                    Icon(
                                      Icons.check_rounded,
                                      size: cardW * 0.038,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: cardW * 0.012),
                                  ],
                                  Text(
                                    opportunity.isApplied
                                        ? "Applied"
                                        : (isApplying
                                            ? "Applying..."
                                            : "Apply Now"),
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      color: Colors.white,
                                      fontSize: cardW * 0.034,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
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
          ),
        );
      },
    );
  }

  Widget _buildFallbackCover(double cardW) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff081927), Color(0xff134E4A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.camera_alt_outlined,
          size: cardW * 0.14,
          color: Colors.white.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
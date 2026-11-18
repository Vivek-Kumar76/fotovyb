import 'package:flutter/material.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../data/models/opportunity_item_model.dart';

class OpportunityBoostedCard extends StatelessWidget {
  final OpportunityItemModel opportunity;
  final bool isApplying;
  final VoidCallback? onApply;
  final VoidCallback? onTap;

  const OpportunityBoostedCard({
    super.key,
    required this.opportunity,
    this.isApplying = false,
    this.onApply,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor =
        isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final pillBg = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xffF1F5F9);
    final pillText =
        isDark ? AppColors.textSecondaryDark : const Color(0xff475569);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final cardW = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : screenWidth * 0.92;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: cardW,
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(cardW * 0.05),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: cardW * 0.025,
                  offset: Offset(0, cardW * 0.008),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Left 31% Image + BOOSTED Pill
                  Expanded(
                    flex: 31,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (opportunity.hasValidImage)
                          Image.network(
                            opportunity.imageUrl.trim(),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _buildFallbackThumb(cardW),
                          )
                        else
                          _buildFallbackThumb(cardW),
                        Positioned(
                          top: cardW * 0.022,
                          left: cardW * 0.022,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: cardW * 0.018,
                              vertical: cardW * 0.008,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffD97706),
                              borderRadius:
                                  BorderRadius.circular(cardW * 0.028),
                            ),
                            child: Text(
                              "BOOSTED",
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: Colors.white,
                                fontSize: cardW * 0.024,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Right 69% Content Details
                  Expanded(
                    flex: 69,
                    child: Padding(
                      padding: EdgeInsets.all(cardW * 0.034),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                opportunity.brand,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.028,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                  color: const Color(0xff64748B),
                                ),
                              ),
                              SizedBox(height: cardW * 0.008),
                              Text(
                                opportunity.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: cardW * 0.036,
                                  fontWeight: FontWeight.w800,
                                  height: 1.25,
                                  color: textColor,
                                ),
                              ),
                              if (opportunity.description.isNotEmpty) ...[
                                SizedBox(height: cardW * 0.008),
                                Text(
                                  opportunity.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: cardW * 0.03,
                                    color: const Color(0xff94A3B8),
                                  ),
                                ),
                              ],
                              if (opportunity.roles.isNotEmpty) ...[
                                SizedBox(height: cardW * 0.018),
                                Wrap(
                                  spacing: cardW * 0.012,
                                  runSpacing: cardW * 0.01,
                                  children:
                                      opportunity.roles.take(3).map((role) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: cardW * 0.02,
                                        vertical: cardW * 0.006,
                                      ),
                                      decoration: BoxDecoration(
                                        color: pillBg,
                                        borderRadius: BorderRadius.circular(
                                            cardW * 0.028),
                                      ),
                                      child: Text(
                                        role,
                                        style: TextStyle(
                                          fontSize: cardW * 0.027,
                                          fontWeight: FontWeight.w500,
                                          color: pillText,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: cardW * 0.024),
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
                                    fontSize: cardW * 0.041,
                                    fontWeight: FontWeight.w900,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: cardW * 0.02),
                              GestureDetector(
                                onTap: (opportunity.isApplied || isApplying)
                                    ? null
                                    : onApply,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: cardW * 0.045,
                                    vertical: cardW * 0.018,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: opportunity.isApplied
                                        ? null
                                        : AppColors.buttonGradientCreative,
                                    color: opportunity.isApplied
                                        ? const Color(0xff0D9488)
                                        : null,
                                    borderRadius:
                                        BorderRadius.circular(cardW * 0.05),
                                  ),
                                  child: Text(
                                    opportunity.isApplied
                                        ? "Applied"
                                        : (isApplying ? "..." : "Apply"),
                                    style: TextStyle(
                                      fontFamily: AppTypography.fontFamilySans,
                                      color: Colors.white,
                                      fontSize: cardW * 0.032,
                                      fontWeight: FontWeight.w700,
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
            ),
          ),
        );
      },
    );
  }

  Widget _buildFallbackThumb(double cardW) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1E293B), Color(0xff0F766E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.auto_awesome_outlined,
          size: cardW * 0.075,
          color: Colors.white.withValues(alpha: 0.35),
        ),
      ),
    );
  }
}
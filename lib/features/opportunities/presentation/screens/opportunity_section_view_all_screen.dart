import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/opportunity_item_model.dart';
import '../../domain/repositories/opportunities_repository.dart';
import '../bloc/opportunities_bloc.dart';
import '../bloc/opportunities_event.dart';
import '../widgets/cards/opportunity_boosted_card.dart';
import '../widgets/cards/opportunity_boosted_card_skeleton.dart';
import '../widgets/cards/opportunity_featured_card.dart';
import '../widgets/cards/opportunity_featured_card_skeleton.dart';
import '../widgets/cards/opportunity_high_priority_card.dart';
import '../widgets/cards/oppotunity_high_priority_card_skeleton.dart';
import 'opportunity_section_view_all_cubit.dart';

class OpportunitySectionViewAllScreen extends StatelessWidget {
  final OpportunitySectionType section;
  final String title;
  final Color dotColor;
  final IconData emptyIcon;
  final List<OpportunityItemModel> initialItems;
  final int initialTotal;
  final String budgetRange;
  final Set<String> roles;
  final Set<String> industries;
  final Set<String> locations;

  const OpportunitySectionViewAllScreen({
    super.key,
    required this.section,
    required this.title,
    required this.dotColor,
    required this.emptyIcon,
    this.initialItems = const [],
    this.initialTotal = 0,
    this.budgetRange = '',
    this.roles = const {},
    this.industries = const {},
    this.locations = const {},
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => OpportunitySectionViewAllCubit(
        repository: ctx.read<OpportunitiesRepository>(),
        section: section,
        budgetRange: budgetRange,
        roles: roles,
        industries: industries,
        locations: locations,
        initialItems: initialItems,
        initialTotal: initialTotal,
      )..loadInitial(),
      child: _OpportunitySectionViewAllBody(
        section: section,
        title: title,
        dotColor: dotColor,
        emptyIcon: emptyIcon,
      ),
    );
  }
}

class _OpportunitySectionViewAllBody extends StatefulWidget {
  final OpportunitySectionType section;
  final String title;
  final Color dotColor;
  final IconData emptyIcon;

  const _OpportunitySectionViewAllBody({
    required this.section,
    required this.title,
    required this.dotColor,
    required this.emptyIcon,
  });

  @override
  State<_OpportunitySectionViewAllBody> createState() =>
      _OpportunitySectionViewAllBodyState();
}

class _OpportunitySectionViewAllBodyState
    extends State<_OpportunitySectionViewAllBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 280) {
      context.read<OpportunitySectionViewAllCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _showNotice(BuildContext context, String message) {
    final screenW = MediaQuery.sizeOf(context).width;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: screenW * 0.032,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xff2E7D6E),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenW * 0.03),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final screenW = MediaQuery.sizeOf(context).width;
    final hPad = screenW * 0.04;
    final isGrid = widget.section == OpportunitySectionType.featured;
    final itemGap = widget.section == OpportunitySectionType.boosted
        ? screenW * 0.025
        : screenW * 0.04;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : const Color(0xffF8FAFC),
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: screenW * 0.048,
            color: textColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: BlocBuilder<OpportunitySectionViewAllCubit,
            OpportunitySectionViewAllState>(
          buildWhen: (prev, curr) =>
              prev.total != curr.total ||
              prev.items.length != curr.items.length,
          builder: (context, state) {
            final count =
                state.total > 0 ? state.total : state.items.length;
            return Row(
              children: [
                Container(
                  width: screenW * 0.026,
                  height: screenW * 0.026,
                  decoration: BoxDecoration(
                    color: widget.dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: screenW * 0.024),
                Flexible(
                  child: Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: screenW * 0.042,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(width: screenW * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenW * 0.022,
                    vertical: screenW * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: widget.dotColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(screenW * 0.04),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: screenW * 0.029,
                      fontWeight: FontWeight.w800,
                      color: widget.dotColor,
                    ),
                  ),
                ),
                SizedBox(width: hPad),
              ],
            );
          },
        ),
      ),
      body: BlocConsumer<OpportunitySectionViewAllCubit,
          OpportunitySectionViewAllState>(
        listenWhen: (prev, curr) =>
            prev.errorMessage != curr.errorMessage &&
            curr.errorMessage != null,
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            _showNotice(context, state.errorMessage!);
          }
        },
        builder: (context, state) {
          if (state.isLoadingInitial && state.items.isEmpty) {
            if (isGrid) {
              return GridView.builder(
                padding: EdgeInsets.fromLTRB(
                  hPad,
                  screenW * 0.045,
                  hPad,
                  screenW * 0.1,
                ),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenW * 0.032,
                  mainAxisSpacing: screenW * 0.032,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (_, __) =>
                    const OpportunityFeaturedCardSkeleton(),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.fromLTRB(
                hPad,
                screenW * 0.045,
                hPad,
                screenW * 0.1,
              ),
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(height: itemGap),
              itemBuilder: (_, __) => _buildSkeleton(),
            );
          }

          if (state.items.isEmpty) {
            final cardBg = isDark ? AppColors.surfaceDark : Colors.white;
            final borderColor =
                isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
            final textSecondary = isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight;

            return Padding(
              padding: EdgeInsets.all(hPad),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenW * 0.045,
                  vertical: screenW * 0.052,
                ),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(screenW * 0.05),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(screenW * 0.026),
                      decoration: BoxDecoration(
                        color: widget.dotColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.emptyIcon,
                        size: screenW * 0.052,
                        color: widget.dotColor,
                      ),
                    ),
                    SizedBox(width: screenW * 0.032),
                    Expanded(
                      child: Text(
                        "No ${widget.title} opportunities found.",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: screenW * 0.033,
                          fontWeight: FontWeight.w600,
                          color: textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: const Color(0xff0D9488),
            onRefresh: () => context
                .read<OpportunitySectionViewAllCubit>()
                .loadInitial(forceRefresh: true),
            child: isGrid
                ? GridView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      hPad,
                      screenW * 0.045,
                      hPad,
                      screenW * 0.12,
                    ),
                    itemCount:
                        state.items.length + (state.isLoadingMore ? 2 : 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: screenW * 0.032,
                      mainAxisSpacing: screenW * 0.032,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (ctx, idx) {
                      if (idx >= state.items.length) {
                        return const OpportunityFeaturedCardSkeleton();
                      }
                      final item = state.items[idx];
                      return OpportunityFeaturedCard(
                        opportunity: item,
                        onView: () => _showNotice(ctx, item.title),
                      );
                    },
                  )
                : ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      hPad,
                      screenW * 0.045,
                      hPad,
                      screenW * 0.12,
                    ),
                    itemCount:
                        state.items.length + (state.isLoadingMore ? 1 : 0),
                    separatorBuilder: (_, __) => SizedBox(height: itemGap),
                    itemBuilder: (ctx, idx) {
                      if (idx >= state.items.length) {
                        return _buildSkeleton();
                      }
                      return _buildListCard(
                        ctx,
                        state.items[idx],
                        state.applyingOpportunityId,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSkeleton() {
    switch (widget.section) {
      case OpportunitySectionType.highPriority:
        return const OpportunityHighPriorityCardSkeleton();
      case OpportunitySectionType.boosted:
        return const OpportunityBoostedCardSkeleton();
      case OpportunitySectionType.featured:
        return const OpportunityFeaturedCardSkeleton();
    }
  }

  Widget _buildListCard(
    BuildContext context,
    OpportunityItemModel item,
    String? applyingId,
  ) {
    Future<void> handleApply(String label) async {
      final cubit = context.read<OpportunitySectionViewAllCubit>();
      final ok = await cubit.applyToOpportunity(item.id);
      if (ok && context.mounted) {
        context
            .read<OpportunitiesBloc>()
            .add(const OpportunitiesRefreshRequested());
        _showNotice(context, "Applied to $label");
      }
    }

    switch (widget.section) {
      case OpportunitySectionType.highPriority:
        return OpportunityHighPriorityCard(
          opportunity: item,
          isApplying: applyingId == item.id,
          onApply: () => handleApply(item.title),
          onTap: () => _showNotice(context, item.title),
        );
      case OpportunitySectionType.boosted:
        return OpportunityBoostedCard(
          opportunity: item,
          isApplying: applyingId == item.id,
          onApply: () => handleApply(item.brand),
          onTap: () => _showNotice(context, item.title),
        );
      case OpportunitySectionType.featured:
        return OpportunityFeaturedCard(
          opportunity: item,
          onView: () => _showNotice(context, item.title),
        );
    }
  }
}
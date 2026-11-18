import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/tokens/tokens.dart';
import '../../data/models/gig_item_model.dart';
import '../../domain/repositories/gigs_repository.dart';
import '../bloc/gigs_bloc.dart';
import '../bloc/gigs_event.dart';
import '../widgets/cards/gig_featured_card.dart';
import '../widgets/cards/gig_featured_card_skeleton.dart';
import '../widgets/cards/gig_high_priority_card.dart';
import '../widgets/cards/gig_high_priority_card_skeleton.dart';
import '../widgets/cards/gig_new_card.dart';
import '../widgets/cards/gig_new_card_skeleton.dart';
import '../widgets/cards/gig_pro_master_card.dart';
import '../widgets/cards/gig_pro_master_card_skeleton.dart';
import '../widgets/gig_empty_state_card.dart';
import 'gig_section_view_all_cubit.dart';

class GigSectionViewAllScreen extends StatelessWidget {
  final GigSectionType section;
  final String title;
  final String subtitle;
  final Color badgeColor;
  final IconData badgeIcon;
  final List<GigItemModel> initialItems;
  final int initialTotal;
  final String searchQuery;
  final String city;
  final String category;
  final String sortBy;

  const GigSectionViewAllScreen({
    super.key,
    required this.section,
    required this.title,
    required this.subtitle,
    required this.badgeColor,
    required this.badgeIcon,
    this.initialItems = const [],
    this.initialTotal = 0,
    this.searchQuery = '',
    this.city = 'All Cities',
    this.category = 'All GIGs',
    this.sortBy = 'Best Match',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => GigSectionViewAllCubit(
        repository: ctx.read<GigsRepository>(),
        section: section,
        searchQuery: searchQuery,
        city: city,
        category: category,
        sortBy: sortBy,
        initialItems: initialItems,
        initialTotal: initialTotal,
      )..loadInitial(),
      child: _GigSectionViewAllBody(
        section: section,
        title: title,
        subtitle: subtitle,
        badgeColor: badgeColor,
        badgeIcon: badgeIcon,
      ),
    );
  }
}

class _GigSectionViewAllBody extends StatefulWidget {
  final GigSectionType section;
  final String title;
  final String subtitle;
  final Color badgeColor;
  final IconData badgeIcon;

  const _GigSectionViewAllBody({
    required this.section,
    required this.title,
    required this.subtitle,
    required this.badgeColor,
    required this.badgeIcon,
  });

  @override
  State<_GigSectionViewAllBody> createState() => _GigSectionViewAllBodyState();
}

class _GigSectionViewAllBodyState extends State<_GigSectionViewAllBody> {
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
      context.read<GigSectionViewAllCubit>().loadMore();
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
    final textSecondary =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final screenW = MediaQuery.sizeOf(context).width;
    final hPad = screenW * 0.04;
    final itemGap = widget.section == GigSectionType.proMaster
        ? screenW * 0.036
        : screenW * 0.045;

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
        title: BlocBuilder<GigSectionViewAllCubit, GigSectionViewAllState>(
          buildWhen: (prev, curr) =>
              prev.total != curr.total ||
              prev.items.length != curr.items.length,
          builder: (context, state) {
            final count =
                state.total > 0 ? state.total : state.items.length;
            return Row(
              children: [
                Container(
                  width: screenW * 0.075,
                  height: screenW * 0.075,
                  decoration: BoxDecoration(
                    color: widget.badgeColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.badgeIcon,
                    color: Colors.white,
                    size: screenW * 0.042,
                  ),
                ),
                SizedBox(width: screenW * 0.025),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: screenW * 0.04,
                                fontWeight: FontWeight.w800,
                                color: textColor,
                              ),
                            ),
                          ),
                          SizedBox(width: screenW * 0.018),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenW * 0.02,
                              vertical: screenW * 0.004,
                            ),
                            decoration: BoxDecoration(
                              color: widget.badgeColor.withValues(alpha: 0.14),
                              borderRadius:
                                  BorderRadius.circular(screenW * 0.04),
                            ),
                            child: Text(
                              '$count',
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                fontSize: screenW * 0.028,
                                fontWeight: FontWeight.w800,
                                color: widget.badgeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: screenW * 0.028,
                          fontWeight: FontWeight.w500,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: hPad),
              ],
            );
          },
        ),
      ),
      body: BlocConsumer<GigSectionViewAllCubit, GigSectionViewAllState>(
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
            return Padding(
              padding: EdgeInsets.all(hPad),
              child: GigEmptyStateCard(
                message: "No ${widget.title} found.",
                accentColor: widget.badgeColor,
                icon: widget.badgeIcon,
              ),
            );
          }

          return RefreshIndicator(
            color: const Color(0xff0D9488),
            onRefresh: () => context
                .read<GigSectionViewAllCubit>()
                .loadInitial(forceRefresh: true),
            child: ListView.separated(
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
                return _buildCard(ctx, state.items[idx]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeleton() {
    switch (widget.section) {
      case GigSectionType.highPriority:
        return const GigHighPriorityCardSkeleton();
      case GigSectionType.proMaster:
        return const GigProMasterCardSkeleton();
      case GigSectionType.featured:
        return const GigFeaturedCardSkeleton();
      case GigSectionType.explore:
        return const GigNewCardSkeleton();
    }
  }

  Widget _buildCard(BuildContext context, GigItemModel gig) {
    void handleBookmark() {
      context.read<GigSectionViewAllCubit>().toggleLocalBookmark(gig.id);
      context.read<GigsBloc>().add(GigBookmarkToggled(gig.id));
      _showNotice(
        context,
        gig.isFavorite ? 'Removed "${gig.title}"' : 'Saved "${gig.title}"',
      );
    }

    switch (widget.section) {
      case GigSectionType.highPriority:
        return GigHighPriorityCard(
          gig: gig,
          onTap: () => _showNotice(context, 'Opening "${gig.title}"'),
          onFavoriteTap: handleBookmark,
          onChatTap: () =>
              _showNotice(context, 'Chatting with ${gig.professional.name}'),
        );
      case GigSectionType.proMaster:
        return GigProMasterCard(
          gig: gig,
          onTap: () => _showNotice(context, 'Opening "${gig.title}"'),
          onViewGigTap: () => _showNotice(context, 'Opening "${gig.title}"'),
        );
      case GigSectionType.featured:
        return GigFeaturedCard(
          gig: gig,
          onTap: () => _showNotice(context, 'Opening "${gig.title}"'),
          onViewTap: () => _showNotice(context, 'Opening "${gig.title}"'),
          onFavoriteTap: handleBookmark,
        );
      case GigSectionType.explore:
        return GigNewCard(
          gig: gig,
          onViewGig: () => _showNotice(context, 'Opening "${gig.title}"'),
          onChat: () =>
              _showNotice(context, 'Chatting with ${gig.professional.name}'),
          onBookmark: handleBookmark,
        );
    }
  }
}
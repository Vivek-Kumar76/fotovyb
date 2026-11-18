import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../pagination/bloc/pagination_bloc.dart';
import '../pagination/bloc/pagination_event.dart';
import '../pagination/bloc/pagination_state.dart';
import '../pagination/identifiable.dart';
import '../tokens/tokens.dart';

enum PaginatedLayoutType { list, grid }

class PaginatedInfiniteScrollView<T extends Identifiable> extends StatefulWidget {
  final PaginationBloc<T> bloc;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? skeletonView;
  final Widget? emptyView;
  final PaginatedLayoutType layoutType;
  final SliverGridDelegate? gridDelegate;
  final EdgeInsetsGeometry padding;

  const PaginatedInfiniteScrollView({
    super.key,
    required this.bloc,
    required this.itemBuilder,
    this.skeletonView,
    this.emptyView,
    this.layoutType = PaginatedLayoutType.list,
    this.gridDelegate,
    this.padding = const EdgeInsets.all(AppSpacing.space4),
  });

  @override
  State<PaginatedInfiniteScrollView<T>> createState() =>
      _PaginatedInfiniteScrollViewState<T>();
}

class _PaginatedInfiniteScrollViewState<T extends Identifiable>
    extends State<PaginatedInfiniteScrollView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Trigger pre-fetching 400px before reaching the bottom
    if (maxScroll - currentScroll <= 400) {
      widget.bloc.add(PaginationNextPageRequested<T>());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        // Initial Full Page Loading
        if (state.status == PaginationStatus.loading && state.items.isEmpty) {
          return widget.skeletonView ??
              const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        // Full Page Error
        if (state.status == PaginationStatus.failure && state.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.circleAlert, color: Colors.redAccent, size: 36),
                const SizedBox(height: 12),
                Text(
                  state.errorMessage ?? "Failed to load data",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => widget.bloc.add(PaginationRefreshed<T>()),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        // Empty Result
        if (state.status == PaginationStatus.loaded && state.items.isEmpty) {
          return widget.emptyView ??
              const Center(
                child: Text(
                  "No items found",
                  style: TextStyle(color: Color(0xff64748B), fontSize: 14),
                ),
              );
        }

        final itemCount = state.items.length + (state.isLoadingMore ? 1 : 0);

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            widget.bloc.add(PaginationRefreshed<T>());
          },
          child: widget.layoutType == PaginatedLayoutType.list
              ? ListView.separated(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: widget.padding,
                  itemCount: itemCount,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.space4),
                  itemBuilder: (context, index) {
                    if (index >= state.items.length) {
                      return _buildBottomLoader();
                    }
                    return widget.itemBuilder(context, state.items[index]);
                  },
                )
              : GridView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: widget.padding,
                  gridDelegate: widget.gridDelegate ??
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    if (index >= state.items.length) {
                      return _buildBottomLoader();
                    }
                    return widget.itemBuilder(context, state.items[index]);
                  },
                ),
        );
      },
    );
  }

  Widget _buildBottomLoader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/pagination/bloc/pagination_bloc.dart';
import '../../../../core/pagination/bloc/pagination_event.dart';
import '../../../../core/pagination/identifiable.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../../core/widgets/paginated_infinite_scroll_view.dart'; // Correct path

class ViewAllScreen<T extends Identifiable> extends StatefulWidget {
  final String title;
  final List<T> seedItems;
  final PaginationFetcher<T> fetcher;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final PaginatedLayoutType layoutType;
  final SliverGridDelegate? gridDelegate;

  const ViewAllScreen({
    super.key,
    required this.title,
    this.seedItems = const [],
    required this.fetcher,
    required this.itemBuilder,
    this.layoutType = PaginatedLayoutType.list,
    this.gridDelegate,
  });

  @override
  State<ViewAllScreen<T>> createState() => _ViewAllScreenState<T>();
}

class _ViewAllScreenState<T extends Identifiable> extends State<ViewAllScreen<T>> {
  late final PaginationBloc<T> _paginationBloc;

  @override
  void initState() {
    super.initState();
    _paginationBloc = PaginationBloc<T>(fetcher: widget.fetcher)
      ..add(PaginationStarted<T>(seedItems: widget.seedItems));
  }

  @override
  void dispose() {
    _paginationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeLg,
            fontWeight: AppTypography.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
        ),
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        ),
      ),
      body: PaginatedInfiniteScrollView<T>(
        bloc: _paginationBloc,
        itemBuilder: widget.itemBuilder,
        layoutType: widget.layoutType,
        gridDelegate: widget.gridDelegate,
      ),
    );
  }
}
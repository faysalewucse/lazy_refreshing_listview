import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class LazyRefreshingListView extends StatefulWidget {
  final bool disableRefresh;
  final bool disableLazyLoading;
  final int listSize;
  final ScrollController? scrollController;
  final ListView listView;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLazyLoad;
  final Widget? header;
  final Widget? footer;
  final double lazyLoadTriggerRatio;

  const LazyRefreshingListView({
    super.key,
    this.disableRefresh = false,
    this.disableLazyLoading = false,
    this.listSize = 10,
    this.lazyLoadTriggerRatio = 0.3,
    this.scrollController,
    required this.listView,
    this.onRefresh,
    this.onLazyLoad,
    this.header,
    this.footer,
  });

  @override
  State<LazyRefreshingListView> createState() => _LazyRefreshingListViewState();
}

class _LazyRefreshingListViewState extends State<LazyRefreshingListView> {
  late final RefreshController _refreshController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _scrollController = widget.scrollController ?? ScrollController();

    if (!widget.disableLazyLoading) {
      _scrollController.addListener(_handleLazyLoading);
    }
  }

  void _handleLazyLoading() {
    final position = _scrollController.position;
    final threshold = position.viewportDimension * widget.lazyLoadTriggerRatio;

    if (position.pixels >= position.maxScrollExtent - threshold) {
      widget.onLazyLoad?.call().then((_) {
        _refreshController.loadComplete();
      });
    }
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disableRefresh) {
      return widget.listView;
    }

    return SmartRefresher(
      header: widget.header,
      footer: widget.footer,
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: !widget.disableLazyLoading,
      onRefresh: () async {
        if (widget.onRefresh != null) {
          await widget.onRefresh!();
        }
        _refreshController.refreshCompleted();
      },
      onLoading:
          widget.onLazyLoad != null
              ? () async {
                await widget.onLazyLoad!();
                _refreshController.loadComplete();
              }
              : null,
      child: widget.listView,
    );
  }
}

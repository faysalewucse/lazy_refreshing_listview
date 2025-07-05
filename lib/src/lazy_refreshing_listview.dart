import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

/// A widget that wraps a [ListView] and provides pull-to-refresh and
/// lazy-loading (infinite scroll) functionality.
///
/// Simply provide your list view and the optional `onRefresh` and
/// `onLazyLoad` callbacks to trigger actions.
class LazyRefreshingListView extends StatefulWidget {
  /// Disable pull-to-refresh feature. Default is `false`.
  final bool disableRefresh;

  /// Disable lazy-loading feature (infinite scroll). Default is `false`.
  final bool disableLazyLoading;

  /// Optional external scroll controller. If not provided, a local one is used.
  final ScrollController? scrollController;

  /// The actual [ListView] widget to be displayed.
  final ListView listView;

  /// Called when a pull-to-refresh is triggered.
  ///
  /// Note: This is a synchronous callback. Use `Future<void>` if you need async support.
  final VoidCallback? onRefresh;

  /// Called when the user scrolls near the bottom (lazy load trigger).
  ///
  /// Note: This is a synchronous callback. Use `Future<void>` if you need async support.
  final VoidCallback? onLazyLoad;

  /// Optional custom header widget for pull-to-refresh.
  final Widget? header;

  /// Optional custom footer widget for lazy-loading.
  final Widget? footer;

  /// Determines how close to the bottom the user must scroll before
  /// triggering `onLazyLoad`. Default is `0.3` (30% of viewport).
  final double lazyLoadTriggerRatio;

  /// Creates a [LazyRefreshingListView] widget.
  const LazyRefreshingListView({
    super.key,
    this.disableRefresh = false,
    this.disableLazyLoading = false,
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

  /// Handles lazy-loading logic based on scroll position.
  void _handleLazyLoading() {
    final position = _scrollController.position;
    final threshold = position.viewportDimension * widget.lazyLoadTriggerRatio;

    if (position.pixels >= position.maxScrollExtent - threshold) {
      widget.onLazyLoad?.call();
      _refreshController.loadComplete();
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
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: !widget.disableLazyLoading,
      header: widget.header,
      footer: widget.footer,
      onRefresh: () {
        log("On refresh called", name: "refreshing");
        widget.onRefresh?.call();
        _refreshController.refreshCompleted();
      },
      onLoading: widget.onLazyLoad != null
          ? () {
        log("On loading called", name: "loading");
        widget.onLazyLoad?.call();
        _refreshController.loadComplete();
      }
          : null,
      child: widget.listView,
    );
  }
}

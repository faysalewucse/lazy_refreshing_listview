import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class LazyRefreshingListView extends StatefulWidget {
  /// The widget to be displayed as the main content of the list.
  final Widget child;

  /// Optional callback function triggered when the user pulls down to refresh.
  /// Should return a `Future<void>` to handle asynchronous refresh operations.
  final Future<void> Function()? onRefresh;

  /// Optional callback function triggered when the user scrolls to the bottom
  /// to load more data. Should return a `Future<bool>` where `true` indicates
  /// more data is available, and `false` indicates no more data to load.
  final Future<bool> Function()? onLoading;

  /// Whether pull-to-refresh functionality is enabled. Defaults to `true`.
  final bool enablePullDown;

  /// Whether infinite loading (pull-up) functionality is enabled. Defaults to `true`.
  final bool enablePullUp;

  /// Optional text to display when no more data is available to load.
  /// Defaults to "No more data" if not provided.
  final String? noMoreDataText;

  /// Optional text style for the "no more data" text.
  /// Defaults to a grey-colored text with font size 14 if not provided.
  final TextStyle? noMoreDataTextStyle;

  /// The widget to display while loading more data.
  /// Defaults to a `CircularProgressIndicator`.
  final Widget loader;

  /// Optional custom header widget for the pull-to-refresh indicator.
  /// If not provided, the default header from `pull_to_refresh_flutter3` is used.
  final Widget? customHeader;

  /// The height of the footer widget when loading or displaying no more data.
  /// Defaults to 55.
  final double footerHeight;

  /// Creates a `LazyRefreshingListView` widget.
  const LazyRefreshingListView({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.noMoreDataText,
    this.noMoreDataTextStyle,
    this.loader = const CircularProgressIndicator(),
    this.customHeader,
    this.footerHeight = 55,
  });

  @override
  State<LazyRefreshingListView> createState() => _LazyRefreshingListViewState();
}

/// The state class for `LazyRefreshingListView`, managing the refresh controller
/// and handling refresh and loading logic.
class _LazyRefreshingListViewState extends State<LazyRefreshingListView> {
  /// The controller for managing pull-to-refresh and infinite loading states.
  late final RefreshController _controller;

  @override
  void initState() {
    super.initState();
    /// Initializes the `RefreshController` to manage refresh and loading states.
    _controller = RefreshController();
  }

  @override
  void dispose() {
    /// Disposes the `RefreshController` to prevent memory leaks.
    _controller.dispose();
    super.dispose();
  }

  /// Handles the pull-to-refresh action by invoking the `onRefresh` callback.
  /// Resets the "no more data" state and updates the controller based on the
  /// result of the refresh operation.
  Future<void> _handleRefresh() async {
    if (widget.onRefresh != null) {
      try {
        _controller.resetNoData();
        await widget.onRefresh!();
        _controller.refreshCompleted();
      } catch (e) {
        _controller.refreshFailed();
      }
    }
  }

  /// Handles the infinite loading action by invoking the `onLoading` callback.
  /// Updates the controller based on whether more data is available or not.
  Future<void> _handleLoading() async {
    if (widget.onLoading != null) {
      try {
        final hasMore = await widget.onLoading!();
        if (hasMore) {
          _controller.loadComplete();
        } else {
          _controller.loadNoData();
        }
      } catch (e) {
        _controller.loadFailed();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Builds the `SmartRefresher` widget with the configured properties and
    /// custom footer for loading states.
    return SmartRefresher(
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      onRefresh: widget.onRefresh != null ? _handleRefresh : null,
      onLoading: widget.onLoading != null ? _handleLoading : null,
      controller: _controller,
      header: widget.customHeader,
      footer: CustomFooter(
        builder: (_, mode) {
          Widget body = const SizedBox.shrink();

          /// Displays the loader widget during loading state or a "no more data"
          /// message when there is no more data to load.
          if (mode == LoadStatus.loading) {
            body = widget.loader;
          } else if (mode == LoadStatus.noMore) {
            body = Text(
              widget.noMoreDataText ?? "No more data",
              style: widget.noMoreDataTextStyle ??
                  const TextStyle(color: Colors.grey, fontSize: 14),
            );
          }

          return SizedBox(
            height: widget.footerHeight,
            child: Center(child: body),
          );
        },
      ),
      child: widget.child,
    );
  }
}

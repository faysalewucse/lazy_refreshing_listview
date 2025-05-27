# lazy_refreshing_listview

A smart and reusable Flutter widget that enables pull-to-refresh and infinite scroll (lazy loading) for any `ListView` with minimal setup.

## Features

- 🔄 Pull-to-refresh functionality
- ⬇️ Infinite scrolling (lazy loading)
- 🔌 Works with any `ListView` widget
- 📱 Custom scroll controller support
- ⚙️ Easy-to-use callbacks
- 🎨 Customizable refresh header and loading footer

## Usage

```dart
import 'package:lazy_refreshing_listview/lazy_refreshing_listview.dart';

LazyRefreshingListView(
  onRefresh: () async {
    // Handle refresh logic
    await _refreshData();
  },
  onLazyLoad: () async {
    // Handle load more logic
    await _loadMoreData();
  },
  listView: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(items[index].title),
        subtitle: Text(items[index].description),
      );
    },
  ),
)
```

## API Reference

### LazyRefreshingListView

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `listView` | `ListView` | **required** | The ListView widget to wrap |
| `onRefresh` | `Future<void> Function()?` | `null` | Callback when user pulls to refresh |
| `onLazyLoad` | `Future<void> Function()?` | `null` | Callback when scrolled to bottom |
| `scrollController` | `ScrollController?` | `null` | Optional scroll controller |
| `disableRefresh` | `bool` | `false` | Disable pull-to-refresh functionality |
| `disableLazyLoading` | `bool` | `false` | Disable infinite scroll functionality |
| `header` | `Widget?` | `null` | Custom refresh indicator widget |
| `footer` | `Widget?` | `null` | Custom loading indicator widget |

## Advanced Usage

### Custom Refresh Header

```dart
LazyRefreshingListView(
  header: Container(
    height: 60,
    child: Center(
      child: Text(
        'Pull to refresh',
        style: TextStyle(color: Colors.blue),
      ),
    ),
  ),
  onRefresh: _onRefresh,
  onLazyLoad: _onLazyLoad,
  listView: yourListView,
)
```

### Custom Loading Footer

```dart
LazyRefreshingListView(
  footer: Container(
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 16),
        Text('Loading more...'),
      ],
    ),
  ),
  onRefresh: _onRefresh,
  onLazyLoad: _onLazyLoad,
  listView: yourListView,
)
```

### Disable Specific Features

```dart
// Only enable pull-to-refresh
LazyRefreshingListView(
  disableLazyLoading: true,
  onRefresh: _onRefresh,
  listView: yourListView,
)

// Only enable lazy loading
LazyRefreshingListView(
  disableRefresh: true,
  onLazyLoad: _onLazyLoad,
  listView: yourListView,
)
```

## Tips

- The widget automatically handles scroll detection for lazy loading
- Pull-to-refresh works with both iOS and Android native feel
- Compatible with `ListView.builder`, `ListView.separated`, and custom ListViews
- Use `disableRefresh` or `disableLazyLoading` to control specific features
- The `onLazyLoad` callback is triggered when the user scrolls to within 200 pixels of the bottom

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests to our [GitHub repository](https://github.com/yourusername/lazy_refreshing_listview).

## Issues and Feedback

Please file issues and feature requests on our [GitHub Issues page](https://github.com/yourusername/lazy_refreshing_listview/issues).
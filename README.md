Sure, Faysal! Here's your **updated and polished `README.md`** that reflects the latest changes to your package — notably:

* `onRefresh` and `onLazyLoad` are now `VoidCallback` (i.e., **sync**),
* Scroll trigger is controlled by `lazyLoadTriggerRatio`,
* Fixed descriptions to match current implementation,
* Clean formatting with emojis and clear sections.

---

````md
# lazy_refreshing_listview

A smart and reusable Flutter widget that enables pull-to-refresh and infinite scroll (lazy loading) for any `ListView` with minimal setup.

---

## ✨ Features

- 🔄 Pull-to-refresh functionality
- ⬇️ Infinite scrolling (lazy loading)
- 🧱 Works with any `ListView` widget
- 🎯 Trigger lazy load based on scroll threshold
- ⚙️ Easy-to-use sync `VoidCallback`-based handlers
- 📱 Supports custom `ScrollController`
- 🎨 Customizable refresh header and loading footer

---

## 🚀 Quick Usage

```dart
import 'package:lazy_refreshing_listview/lazy_refreshing_listview.dart';

LazyRefreshingListView(
  onRefresh: () {
    // Sync logic to handle refresh
    _refreshData();
  },
  onLazyLoad: () {
    // Sync logic to handle load more
    _loadMoreData();
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
);
````

---

## 📚 API Reference

### `LazyRefreshingListView`

| Property               | Type                | Default      | Description                                                  |
|------------------------|---------------------|--------------|--------------------------------------------------------------|
| `listView`             | `ListView`          | **Required** | The list to be displayed and managed                         |
| `onRefresh`            | `VoidCallback?`     | `null`       | Called on pull-to-refresh                                    |
| `onLazyLoad`           | `VoidCallback?`     | `null`       | Called when nearing scroll end                               |
| `disableRefresh`       | `bool`              | `false`      | Disable pull-to-refresh feature                              |
| `disableLazyLoading`   | `bool`              | `false`      | Disable infinite scroll                                      |
| `lazyLoadTriggerRatio` | `double`            | `0.3`        | Ratio of screen height before bottom to trigger lazy loading |
| `scrollController`     | `ScrollController?` | `null`       | Custom scroll controller                                     |
| `header`               | `Widget?`           | `null`       | Custom refresh header                                        |
| `footer`               | `Widget?`           | `null`       | Custom loading footer                                        |

---

## 🧩 Advanced Examples

### 🪄 Custom Refresh Header

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

### 🌀 Custom Loading Footer

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

---

## 🧯 Disable Specific Features

```dart
// Only enable pull-to-refresh
LazyRefreshingListView(
  disableLazyLoading: true,
  onRefresh: _onRefresh,
  listView: yourListView,
);

// Only enable lazy loading
LazyRefreshingListView(
  disableRefresh: true,
  onLazyLoad: _onLazyLoad,
  listView: yourListView,
);
```

---

## 💡 Tips

* Scroll detection is handled internally; just provide `onLazyLoad`.
* Pull-to-refresh uses native-feeling indicators on both Android and iOS.
* Compatible with `ListView.builder`, `ListView.separated`, etc.
* You can control how early lazy loading starts with `lazyLoadTriggerRatio` (default: 0.3 of the screen height).
* The widget supports both internal and external `ScrollController`.

---

## 🛠 Contributing

Contributions are welcome! If you have ideas, bug fixes, or improvements, feel free to fork the repo and submit a PR.

👉 GitHub: [https://github.com/faysalewucse/lazy\_refreshing\_listview](https://github.com/faysalewucse/lazy_refreshing_listview)

---

## 🐞 Issues & Feedback

Please report bugs or feature requests via the GitHub issues page:

[https://github.com/faysalewucse/lazy\_refreshing\_listview/issues](https://github.com/faysalewucse/lazy_refreshing_listview/issues)

---

## 📄 License

MIT © 2025 [Faysal Ahmed](https://github.com/faysalewucse)

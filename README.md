# LazyRefreshingListView

A customizable Flutter widget built on top of `pull_to_refresh_flutter3` that simplifies the implementation of pull-to-refresh and infinite scrolling (lazy loading) for any scrollable child, like a `ListView`.

---

## ✨ Features

* ✅ Pull-to-refresh support
* ✅ Infinite scroll loading
* ✅ Custom loader and no-more-data message
* ✅ Easily pluggable into any scrollable widget
* ✅ Clean API with sensible defaults
* ✅ Full control over styling and layout

---

## 🧱 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  lazy_refreshing_list_view: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🔧 Usage

```dart
import 'package:lazy_refreshing_list_view/lazy_refreshing_list_view.dart';

LazyRefreshingListView(
  onRefresh: () async {
    // Your refresh logic here
  },
  onLoading: () async {
    // Return true if more data is available, false otherwise
    return false;
  },
  child: ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) => ListTile(title: Text('Item #$index')),
  ),
);
```

---

## 📌 Parameters

| Property              | Type                       | Description                                                                |
|-----------------------|----------------------------|----------------------------------------------------------------------------|
| `child`               | `Widget`                   | The scrollable widget to wrap (e.g., `ListView`, `GridView`).              |
| `onRefresh`           | `Future<void> Function()?` | Callback triggered on pull-to-refresh. Optional.                           |
| `onLoading`           | `Future<bool> Function()?` | Callback triggered when scrolled to bottom. Return `true` if more data.    |
| `enablePullDown`      | `bool`                     | Enable pull-to-refresh. Default: `true`.                                   |
| `enablePullUp`        | `bool`                     | Enable infinite loading. Default: `true`.                                  |
| `noMoreDataText`      | `String?`                  | Text shown when no more data is available. Default: `'No more data'`.      |
| `noMoreDataTextStyle` | `TextStyle?`               | Style for the no more data message.                                        |
| `loader`              | `Widget`                   | Custom widget shown while loading. Default: `CircularProgressIndicator()`. |
| `customHeader`        | `Widget?`                  | Custom pull-to-refresh header. Optional.                                   |
| `footerHeight`        | `double`                   | Height of the footer section. Default: `55`.                               |

---

## 🔄 Example

Here's a full working example:

```dart
class MyListPage extends StatelessWidget {
  final List<String> items = List.generate(20, (i) => 'Item $i');

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    // refresh your data here
  }

  Future<bool> _loadMore() async {
    await Future.delayed(Duration(seconds: 2));
    // return false when no more data is available
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LazyRefreshingListView(
      onRefresh: _refresh,
      onLoading: _loadMore,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(title: Text(items[index])),
      ),
    );
  }
}
```

---

## 💡 Tip

This widget uses the [pull\_to\_refresh\_flutter3](https://pub.dev/packages/pull_to_refresh_flutter3) package under the hood. You can customize it further using that package’s capabilities.

---

## 📃 License

MIT © 2025 [Faysal Ahmed](https://github.com/faysalewucse)

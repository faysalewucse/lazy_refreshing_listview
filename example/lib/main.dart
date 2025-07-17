import 'package:flutter/material.dart';
import 'package:lazy_refreshing_listview/lazy_refreshing_listview.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LazyRefreshingListView Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

/// The home page widget that demonstrates the usage of LazyRefreshingListView.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Sample list of items to display
  List<String> _items = List.generate(20, (index) => 'Item ${index + 1}');
  int _page = 1; // Track the current page for loading more items

  /// Simulates a refresh operation by resetting the list.
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    setState(() {
      _page = 1;
      _items = List.generate(20, (index) => 'Item ${index + 1}');
    });
  }

  /// Simulates loading more items. Returns false if no more data is available.
  Future<bool> _onLoading() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    setState(() {
      _page++;
      if (_page <= 3) {
        // Add more items until page 3
        _items.addAll(
          List.generate(20, (index) => 'Item ${_items.length + index + 1}'),
        );
      }
    });
    return _page <= 3; // Return false when no more data is available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LazyRefreshingListView Demo')),
      body: LazyRefreshingListView(
        // Enable both pull-to-refresh and infinite loading
        enablePullDown: true,
        enablePullUp: true,
        // Provide refresh and loading callbacks
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        // Customize the "no more data" text and style
        noMoreDataText: 'No more items to load',
        noMoreDataTextStyle: const TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        // Use a custom loader widget
        loader: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        // Set the footer height
        footerHeight: 60,
        // The main content of the list
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_items[index]),
              subtitle: Text('Subtitle for ${_items[index]}'),
              leading: CircleAvatar(child: Text('${index + 1}')),
            );
          },
        ),
      ),
    );
  }
}

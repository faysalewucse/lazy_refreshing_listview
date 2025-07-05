import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_refreshing_listview/lazy_refreshing_listview.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartListview Demo',
      home: LazyPullListviewExample(),
    );
  }
}

class LazyPullListviewExample extends StatefulWidget {
  const LazyPullListviewExample({super.key});

  @override
  State<LazyPullListviewExample> createState() =>
      _LazyPullListviewExampleState();
}

class _LazyPullListviewExampleState extends State<LazyPullListviewExample> {
  final List<dynamic> items = [];
  int _page = 0;
  final int _limit = 10;
  bool _hasMore = true;

  Future<void> _fetchData({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 0;
      _hasMore = true;
    } else if (!_hasMore) {
      return;
    }

    final start = _page * _limit;
    final url =
        'http://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$_limit';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> newItems = json.decode(response.body);
      setState(() {
        if (isRefresh) {
          items.clear();
        }
        items.addAll(newItems);
        _hasMore = newItems.length == _limit;
        _page++;
      });
    }
  }

  Future<void> _onRefresh() async => _fetchData(isRefresh: true);

  Future<void> _onLazyLoad() async => _fetchData();

  @override
  void initState() {
    super.initState();
    _fetchData(); // initial load
  }

  String limitWords(String text, int wordLimit) {
    final words = text.split(' ');
    String shortened =
        words.length <= wordLimit
            ? text
            : '${words.take(wordLimit).join(' ')}...';

    return shortened.isNotEmpty
        ? '${shortened[0].toUpperCase()}${shortened.substring(1)}'
        : shortened;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazy Pull ListView Example'),
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.0,
          bottom: 40.0,
        ),
        child: LazyRefreshingListView(
          onRefresh: _onRefresh,
          onLazyLoad: _onLazyLoad,
          listView: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
            itemBuilder: (_, index) {
              final item = items[index];
              return ListTile(
                tileColor: Colors.grey[200],
                title: Text(
                  limitWords(item['title'], 5),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(limitWords(item["body"], 10))
              );
            },
          ),
        ),
      ),
    );
  }
}

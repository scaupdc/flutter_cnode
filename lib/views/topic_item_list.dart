import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cnode_flutter_client/models/topic.dart';
import 'package:cnode_flutter_client/views/topic_item.dart';
import 'package:flutter/material.dart';

class TopicItemList extends StatefulWidget {
  final String tab;
  TopicItemList({@required this.tab});
  @override
  _TopicItemListState createState() => _TopicItemListState();
}

class _TopicItemListState extends State<TopicItemList>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> key = GlobalKey<RefreshIndicatorState>();
  List<Topic> _topics;

  getTopics() async {
    HttpClient httpClient = new HttpClient();
    Uri uri = new Uri.https('cnodejs.org', '/api/v1/topics', {
      'page': '0',
      'tab': widget.tab,
      'limit': '15',
      'mdrender': 'false',
    });
    HttpClientRequest request = await httpClient.getUrl(uri);
    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> json = jsonDecode(responseBody);
    List<dynamic> data = json['data'];
    data.forEach((dynamic topicJson) => _topics.add(Topic.fromJson(topicJson)));
    setState(() {
      _topics;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
    _topics = List();
    getTopics();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void didUpdateWidget(TopicItemList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        key: key,
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: EdgeInsets.all(0.0),
          itemCount: _topics.length > 0 ? _topics.length * 2 : 0,
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd)
              return Divider(
                height: 1.0,
              );
            return TopicItem(
              topic: _topics[index ~/ 2],
            );
          },
        ),
      ),
    );
  }

  Future<Null> _onRefresh() {
    final Completer<Null> completer = Completer<Null>();
    Timer(const Duration(seconds: 3), () {
      completer.complete(null);
    });
    return completer.future.then((_) {});
  }
}

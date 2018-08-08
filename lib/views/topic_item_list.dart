import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cnode_flutter_client/models/topic.dart';
import 'package:cnode_flutter_client/views/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TopicItemList extends StatefulWidget {
  final String tab;
  TopicItemList({@required this.tab});
  @override
  _TopicItemListState createState() => _TopicItemListState();
}

class _TopicItemListState extends State<TopicItemList>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _keyRefreshIndicatorState =
      GlobalKey<RefreshIndicatorState>();
  List<Topic> _topics;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Timer(
      const Duration(
        milliseconds: 500,
      ),
      () {
        _keyRefreshIndicatorState.currentState?.show();
      },
    );
  }

  Widget _buildContent() {
    if (_topics == null) {
      return ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[],
      );
    } else {
      if (_topics.length > 0) {
        return ListView.builder(
          padding: EdgeInsets.all(0.0),
          itemCount: _topics.length * 2,
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd)
              return Divider(
                height: 1.0,
              );
            return TopicItem(
              topic: _topics[index ~/ 2],
            );
          },
        );
      } else {
        return CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/it_dog_ph.png',
                      width: 64.0,
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Text(
                      'Shit!Nothing...',
                      style: TextStyle(
                        color: Color(0xFFcdcdcd),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return SafeArea(
      child: RefreshIndicator(
        key: _keyRefreshIndicatorState,
        onRefresh: _onRefresh,
        child: _buildContent(),
      ),
    );
  }

  Future<Null> _onRefresh() async {
    HttpClient httpClient = HttpClient();
    Uri uri = Uri.https('cnodejs.org', '/api/v1/topics', {
      'page': '0',
      'tab': widget.tab,
      'limit': '15',
      'mdrender': 'false',
    });

    HttpClientRequest request = await httpClient.getUrl(uri);
    HttpClientResponse response = await request.close();
    return response.transform(utf8.decoder).join().then((String responseBody) {
      Map<String, dynamic> json = jsonDecode(responseBody);
      List<dynamic> data = json['data'];
      if (_topics != null) {
        _topics.clear();
      } else {
        _topics = <Topic>[];
      }
      data.forEach(
        (dynamic topicJson) => _topics.add(Topic.fromJson(topicJson)),
      );
      return Future<Null>((() => null));
    }).then((Null _) {
      setState(() {});
    });
  }
}

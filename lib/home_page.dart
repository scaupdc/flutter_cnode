import 'dart:async';

import 'package:cnode_flutter_client/models/user.dart';
import 'package:cnode_flutter_client/views/guest_drawer.dart';
import 'package:cnode_flutter_client/views/topic_item_list.dart';
import 'package:cnode_flutter_client/views/member_drawer.dart';
import 'package:flutter/material.dart';

class _Tab {
  const _Tab({this.value, this.text});
  final String value;
  final String text;
}

const List<_Tab> _allTabs = <_Tab>[
  const _Tab(value: '', text: '全部'),
  const _Tab(value: 'good', text: '精华'),
  const _Tab(value: 'share', text: '分享'),
  const _Tab(value: 'ask', text: '问答'),
  const _Tab(value: 'job', text: '招聘'),
  const _Tab(value: 'dev', text: '测试'),
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _allTabs.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Null> _onRefresh() {
    final Completer<Null> completer = Completer<Null>();
    Timer(const Duration(seconds: 3), () {
      completer.complete(null);
    });
    return completer.future.then((_) {});
  }

  _onPressedPostTopic() {
    print('post');
  }

  @override
  Widget build(BuildContext context) {
    final User user = User.singleton;
    print(user.status);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Image.asset(
          'assets/cnodejs_light.png',
          width: 102.0,
          height: 25.0,
        ),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: _allTabs.map((_Tab tab) {
            return Tab(text: tab.text);
          }).toList(),
        ),
      ),
      drawer: user.status == UserStatus.member
          ? MemberDrawer(
              onPressedSetting: () {},
              onPressedAvatar: () {},
              onTapFavorites: () {},
              onTapNotifications: () {},
              onTapTopics: () {},
            )
          : GuestDrawer(
              onLoginSuccess: _onLoginSuccess,
            ),
      body: TabBarView(
        controller: _controller,
        children: _allTabs.map((_Tab tab) {
          return TopicItemList(
            tab: tab.value,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _onPressedPostTopic,
        tooltip: '发布主题',
        child: Icon(Icons.edit),
      ),
    );
  }

  _onLoginSuccess() {
    setState(() {});
  }
}

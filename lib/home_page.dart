import 'dart:async';

import 'package:cnode_flutter_client/models/user.dart';
import 'package:cnode_flutter_client/views/topic_item_list.dart';
import 'package:cnode_flutter_client/views/user_drawer.dart';
import 'package:flutter/material.dart';

class _Page {
  const _Page({this.value, this.text});
  final String value;
  final String text;
}

const List<_Page> _allPages = const <_Page>[
  const _Page(value: '', text: '全部'),
  const _Page(value: 'good', text: '精华'),
  const _Page(value: 'share', text: '分享'),
  const _Page(value: 'ask', text: '问答'),
  const _Page(value: 'job', text: '招聘'),
  const _Page(value: 'dev', text: '测试'),
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final User user = User.singleton;
  TabController _controller;
  Widget appBarTitle;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _allPages.length);
    appBarTitle = Image.asset(
      'assets/cnodejs_light.png',
      width: 102.0,
      height: 25.0,
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: _allPages.map((_Page page) {
            return Tab(text: page.text);
          }).toList(),
        ),
      ),
      drawer: user.success
          ? UserDrawer(
              onPressedSetting: () {},
              onPressedAvatar: () {},
              onTapFavorites: () {},
              onTapNotifications: () {},
              onTapTopics: () {},
            )
          : null,
      body: TabBarView(
        controller: _controller,
        children: _allPages.map((_Page page) {
          return TopicItemList(
            tab: page.value,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => print('test'),
        tooltip: '发布主题',
        child: Icon(Icons.edit),
      ),
    );
  }
}

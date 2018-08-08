import 'package:cnode_flutter_client/models/user.dart';
import 'package:flutter/material.dart';

class MemberDrawer extends StatelessWidget {
  final User user = User.singleton;
  final VoidCallback onPressedAvatar;
  final VoidCallback onPressedSetting;
  final GestureTapCallback onTapTopics;
  final GestureTapCallback onTapFavorites;
  final GestureTapCallback onTapNotifications;

  MemberDrawer({
    this.onPressedAvatar,
    this.onPressedSetting,
    this.onTapTopics,
    this.onTapFavorites,
    this.onTapNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.green,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Container(
                height: 200.0,
                color: Colors.green,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Center(
                        child: _buildAvatar(),
                      ),
                    ),
                    Positioned(
                      top: 15.0,
                      right: 15.0,
                      child: _buildSetting(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.white,
                  child: _buildMenus(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(80.0),
            ),
          ),
          margin: EdgeInsets.only(bottom: 15.0),
          child: CircleAvatar(
            backgroundColor: Colors.lightGreen,
            radius: 40.0,
            backgroundImage: NetworkImage(
              user.avatarUrl,
            ),
          ),
        ),
        Text(
          user.loginname,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSetting() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.white,
          onPressed: onPressedSetting,
        ),
      ),
    );
  }

  Widget _buildMenus() {
    return ListView(
      padding: EdgeInsets.all(30.0),
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.comment,
            color: Colors.green,
          ),
          title: Text(
            '我的主题',
            style: TextStyle(color: Colors.green),
          ),
          onTap: onTapTopics,
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.favorite,
            color: Colors.green,
          ),
          title: Text(
            '我的收藏',
            style: TextStyle(color: Colors.green),
          ),
          onTap: onTapFavorites,
        ),
        Divider(),
        ListTile(
          leading: Icon(
            Icons.notifications_none,
            color: Colors.green,
          ),
          title: Text(
            '我的消息',
            style: TextStyle(color: Colors.green),
          ),
          onTap: onTapNotifications,
        )
      ],
    );
  }
}

import 'package:cnode_flutter_client/models/user.dart';
import 'package:flutter/material.dart';

class DrawerAvatar extends StatelessWidget {
  final User user = User.singleton;

  @override
  Widget build(BuildContext context) {
    if (user.success) {
      user.success = false;
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
    } else {
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
              backgroundColor: Colors.grey[100],
              radius: 40.0,
              child: Center(
                child: Image.asset(
                  'assets/it_dog.png',
                  width: 40.0,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Text(
            '火星游客',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      );
    }
  }
}

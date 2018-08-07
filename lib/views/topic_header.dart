import 'package:cnode_flutter_client/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:cnode_flutter_client/helper.dart';

class TopicHeader extends StatelessWidget {
  final Topic topic;
  TopicHeader({@required this.topic});

  Widget _buildTitle() {
    List<Widget> list = <Widget>[];
    if (topic.top) {
      list.add(
        Container(
          child: Text(
            '置顶',
            style: TextStyle(color: Colors.white),
          ),
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      );
    }
    if (topic.good) {
      list.add(
        Container(
          child: Text(
            '精华',
            style: TextStyle(color: Colors.white),
          ),
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      );
    }
    list.add(
      Expanded(
        child: Text(
          topic.title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list,
    );
  }

  Widget _buildSub() {
    return Row(
      children: <Widget>[
        Text(
          fromNow(topic.createAt),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          topic.author.loginname,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          '${topic.visitCount}浏览量',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Text(
        //   'this is titlethis is titlethis is titlethis is titlethis is titlethis is titlethis is title',

        //   style: TextStyle(
        //     fontSize: 16.0,
        //   ),
        // ),
        Container(
          padding: EdgeInsets.all(15.0),
          child: _buildTitle(),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: _buildSub(),
        ),
        Divider(
          height: 1.0,
        ),
      ],
    );
  }
}

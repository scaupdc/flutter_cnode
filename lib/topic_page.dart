import 'package:cnode_flutter_client/models/topic.dart';
import 'package:cnode_flutter_client/views/topic_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TopicPage extends StatefulWidget {
  final Topic topic;
  TopicPage({@required this.topic});
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主题详情'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              TopicHeader(
                topic: widget.topic,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                child: MarkdownBody(
                  data: widget.topic.content.replaceAll('//dn', 'http://dn'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

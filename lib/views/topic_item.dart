import 'package:cnode_flutter_client/models/topic.dart';
import 'package:cnode_flutter_client/topic_page.dart';
import 'package:flutter/material.dart';
import 'package:cnode_flutter_client/helper.dart';

class TopicItem extends StatefulWidget {
  final Topic topic;
  TopicItem({@required this.topic});
  @override
  _TopicItemState createState() => _TopicItemState();
}

class _TopicItemState extends State<TopicItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new PageRouteBuilder(
            pageBuilder: (_, __, ___) => TopicPage(
                  topic: widget.topic,
                ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        backgroundImage:
                            NetworkImage(widget.topic.author.avatarUrl),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.topic.author.loginname),
                          Text(
                            fromNow(widget.topic.createAt),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: '${widget.topic.replyCount}',
                            style: TextStyle(
                              color: Colors.green,
                            )),
                        TextSpan(
                            text: ' / ${widget.topic.visitCount}',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text('${widget.topic.title}'),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}

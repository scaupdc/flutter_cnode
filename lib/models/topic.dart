import 'package:cnode_flutter_client/models/author.dart';

class Topic {
  final String id;
  final String authorId;
  final String tab;
  final String content;
  final String title;
  final String lastReplyAt;
  final String createAt;
  final bool good;
  final bool top;
  final int replyCount;
  final int visitCount;
  final Author author;

  Topic(
      {this.id,
      this.authorId,
      this.tab,
      this.content,
      this.title,
      this.lastReplyAt,
      this.createAt,
      this.good,
      this.top,
      this.replyCount,
      this.visitCount,
      this.author});

  Topic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        authorId = json['author_id'],
        tab = json['tab'],
        content = json['content'],
        title = json['title'],
        lastReplyAt = json['last_reply_at'],
        createAt = json['create_at'],
        good = json['good'],
        top = json['top'],
        replyCount = json['reply_count'],
        visitCount = json['visit_count'],
        author = Author.fromJson(json['author']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'author_id': authorId,
        'tab': tab,
        'content': content,
        'title': title,
        'last_reply_at': lastReplyAt,
        'create_at': createAt,
        'good': good,
        'top': top,
        'reply_count': replyCount,
        'visit_count': visitCount,
        'author': author,
      };
}

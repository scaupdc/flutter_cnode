class Author {
  final String loginname;
  final String avatarUrl;

  Author({this.loginname, this.avatarUrl});

  factory Author.fromJson(Map<String, dynamic> json) {
    String url = json['avatar_url'];
    if (url.startsWith('//')) {
      url = 'https:$url';
    }
    return Author(loginname: json['loginname'], avatarUrl: url);
  }

  Map<String, dynamic> toJson() => {
        'loginname': loginname,
        'avatar_url': avatarUrl,
      };
}

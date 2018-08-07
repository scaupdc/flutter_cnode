class User {
  static User singleton;

  bool success;
  final String loginname;
  final String id;
  final String avatarUrl;

  User({this.success, this.loginname, this.id, this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    String url = json['avatar_url'];
    if (url.startsWith('//')) {
      url = 'https:$url';
    }
    return User(
      success: json['success'],
      loginname: json['loginname'],
      id: json['id'],
      avatarUrl: url,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'loginname': loginname,
        'id': id,
        'avatar_url': avatarUrl,
      };
}

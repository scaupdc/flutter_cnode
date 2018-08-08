enum UserStatus { guest, member, switcher }

class User {
  static User singleton;
  UserStatus status;
  final bool success;
  final String loginname;
  final String id;
  final String avatarUrl;

  User({this.status, this.success, this.loginname, this.id, this.avatarUrl});

  factory User.guest() {
    return User(
      status: UserStatus.guest,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    String url = json['avatar_url'];
    if (url.startsWith('//')) {
      url = 'https:$url';
    }
    return User(
      status: UserStatus.member,
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

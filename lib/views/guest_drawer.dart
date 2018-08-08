import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cnode_flutter_client/config.dart';
import 'package:cnode_flutter_client/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestDrawer extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  GuestDrawer({
    this.onLoginSuccess,
  });

  @override
  _GuestDrawerState createState() => _GuestDrawerState();
}

class _GuestDrawerState extends State<GuestDrawer>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  User user = User.singleton;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Colors.green,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  color: Colors.green,
                  child: Center(
                    child: _buildAvatar(),
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.white,
                      child: Center(
                        child: _buildBottomContent(),
                      )),
                ),
              ],
            ),
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
          '汪星来的游客',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomContent() {
    if (user.status == UserStatus.guest) {
      return OutlineButton(
        child: Text('登录'),
        onPressed: _onPressedLogin,
      );
    } else if (user.status == UserStatus.switcher) {
      return CircularProgressIndicator();
    } else {
      return SizedBox();
    }
  }

  Future _onPressedLogin() async {
    setState(() {
      user.status = UserStatus.switcher;
    });

    try {
      final String scanResult = await BarcodeScanner.scan();
      _postAccessToken(scanResult);
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        _showSnackBar('无法访问相机');
      } else {
        _showSnackBar('未知错误');
      }
      user.status = UserStatus.guest;
      setState(() {});
    } on FormatException {} catch (ex) {
      _showSnackBar('未知错误');
      user.status = UserStatus.guest;
      setState(() {});
    }
  }

  _showSnackBar(String msg) {
    final SnackBar bar = SnackBar(
      content: Text(msg),
    );
    _scaffoldKey.currentState.showSnackBar(bar);
  }

  _postAccessToken(String accessToken) async {
    HttpClient httpClient = HttpClient();
    Uri uri = Uri.https('cnodejs.org', '/api/v1/accesstoken', {
      'accesstoken': accessToken,
    });
    HttpClientRequest request = await httpClient.postUrl(uri);
    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> json = jsonDecode(responseBody);
    final bool success = json['success'];
    if (success) {
      User.singleton = User.fromJson(json);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(accessTokenKey, accessToken);
      widget.onLoginSuccess();
    } else {
      final String msg = json['error_msg'];
      if (msg != null) {
        _showSnackBar(msg);
      }
      setState(() {
        user.status = UserStatus.guest;
      });
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cnode_flutter_client/config.dart';
import 'package:cnode_flutter_client/home_page.dart';
import 'package:cnode_flutter_client/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _status;
  String _accessToken;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const platform = const MethodChannel('scaupdc.github.io/scan');

  @override
  void initState() {
    super.initState();
    _status = 'loading';
    _queryStatus();
  }

  _queryStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _accessToken = sp.getString(accessTokenKey);
    print('token=$_accessToken');
    if (_accessToken != null) {
      _postAccessToken();
    } else {
      setState(() {
        _status = 'login';
      });
      print('login------');
    }
  }

  _postAccessToken() async {
    HttpClient httpClient = HttpClient();
    Uri uri = Uri.https('cnodejs.org', '/api/v1/accesstoken', {
      'accesstoken': _accessToken,
    });
    HttpClientRequest request = await httpClient.postUrl(uri);
    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();

    setState(() {
      _status = 'login';
    });

    Map<String, dynamic> json = jsonDecode(responseBody);
    print(json);
    final bool success = json['success'];
    if (success) {
      User.singleton = User.fromJson(json);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(accessTokenKey, _accessToken);
      _enterHome();
    } else {
      final String msg = json['error_msg'];
      if (msg != null) {
        final SnackBar bar = SnackBar(
          content: Text(msg),
        );
        _scaffoldKey.currentState.showSnackBar(bar);
      }
    }
  }

  Widget _buildActionWidget() {
    print('status=' + _status.toString());
    if (_status == 'loading') {
      return CircularProgressIndicator();
    } else {
      return Container(
        width: 200.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              onPressed: _onPressScan,
              child: Text('扫码登录'),
              color: Colors.green,
            ),
            RaisedButton(
              onPressed: _onPressGuest,
              child: Text('随便看看'),
              color: Colors.green[50],
            ),
          ],
        ),
      );
    }
  }

  void _onPressScan() {
    _invokeScan();
  }

  Future<Null> _invokeScan() async {
    try {
      final String scanResult = await platform.invokeMethod('invokeScan');
      print('result=$scanResult');

      if (scanResult != null) {
        if (scanResult == 'error') {
          final SnackBar bar = SnackBar(
            content: Text('扫描结果无效'),
          );
          _scaffoldKey.currentState.showSnackBar(bar);
        } else if (scanResult == 'close') {
        } else {
          setState(() {
            _status = 'loading';
            _accessToken = scanResult;
          });
          _postAccessToken();
        }
      }
    } on PlatformException catch (e) {
      print('Failed: ${e.message}');
    }
  }

  void _onPressGuest() {
    _enterHome();
  }

  void _enterHome() {
    Navigator.pushReplacement(
      context,
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => Home(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: Image.asset(
                      'assets/it_dog.png',
                      width: 80.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  _buildActionWidget(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 10.0,
            right: 10.0,
            child: Text(
              'Powered By Flutter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w200,
                color: Colors.grey[500],
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:json_feed/Services/AuthService.dart';
import 'package:json_feed/home.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthService authService = AuthService();

  Widget page = Login();

  final _route = <String, WidgetBuilder>{
    '/login': (context) => Login(),
    '/home': (context) => Home(),
  };

  if (await authService.isLogin()) {
    page = Home();
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Json Feed',
    home: page,
    routes: _route,
  ));
}

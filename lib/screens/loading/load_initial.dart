// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../exports.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isSync = true;
  bool checkLogin = true;
  //bool _isDetailsDone = true;
  String? uEmail;
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    // _getUserName();
    Timer(
        Duration(seconds: 5),
        () => setState(() {
              _isSync = false;
            }));
  }

  // Future _getUserName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('name') == null) {
  //     setState(() {
  //       uEmail = prefs.getString('uEmail');
  //       _isDetailsDone = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    bool checkLogin = Provider.of<UserProvider>(context).user.token.isEmpty;
    // if (checkLogin || !checkLogin) {
    //   setState(() {
    //     _isSync = false;
    //   });
    // }
    return Scaffold(
        backgroundColor: Colors.white,
        body: _isSync
            ? Center(
                child: Image.asset(
                  "assets/splash/loading.gif",
                  height: 75.0,
                  width: 75.0,
                  fit: BoxFit.scaleDown,
                ),
              )
            : checkLogin
                ? GetStarted()
                : HomePage());
  }
}

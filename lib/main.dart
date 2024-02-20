// // ignore_for_file: prefer_const_constructors, unused_element, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './exports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //bool _isSync = true;
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    initPlatform();
    authService.getUserData(context);
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoadingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/view': (context) => PetListScreen(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   //'/second': (context) => const SecondScreen(),
      //   '/add': (context) => AddPets(),
      // },

      // home: Provider.of<UserProvider>(context).user.token.isEmpty
      //     ? SignUpScreen()
      //     : PetListScreen(),

      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "assets/splash/loading_2.png",
            height: 75.0,
            width: 75.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
      // home: _isSync
      //     ? CircularProgressIndicator()
      //     : checkLogin
      //         ? SignUpScreen()
      //         : PetListScreen(),
    );
  }

  void initPlatform() async {
    String notificationId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await OneSignal.shared.setAppId('86f093f9-9344-4176-a645-3bc68e45b948');
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      OSNotificationDisplayType.notification;
    });
    // OneSignal.shared
    //     .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
    //   String? onesignalUserId = changes.to.userId;
    //   print('Player ID: ' + onesignalUserId!);
    // });
    await OneSignal.shared.getDeviceState().then((value) => {
          notificationId = value!.userId!,
        });
    prefs.setString('playerId', notificationId);
    print(notificationId);
  }
}

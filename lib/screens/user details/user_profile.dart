// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isSyncing = true;
  String? name;
  String? address;
  String? email;
  String? phone;
  String? userImage;
  String? mobile;

  Future getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    address = prefs.getString('address');
    email = prefs.getString('uEmail');
    phone = prefs.getString('phone');
    mobile = prefs.getString('mobile');
    userImage = prefs.getString('imageUser');
    setState(() {
      _isSyncing = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text("About Me"),
        ),
        body: _isSyncing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: CachedNetworkImageProvider('$userImage'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Center(
                      child: Text(
                        "$name",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("E-Mail", style: TextStyle(fontSize: 20)),
                    subtitle: Text("$email", style: TextStyle(fontSize: 15)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("Phone", style: TextStyle(fontSize: 20)),
                    subtitle: Text("$phone", style: TextStyle(fontSize: 15)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Icon(Icons.mobile_screen_share),
                    title: Text("Mobile", style: TextStyle(fontSize: 20)),
                    subtitle: Text("$mobile", style: TextStyle(fontSize: 15)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text("Address", style: TextStyle(fontSize: 20)),
                    subtitle: Text("$address", style: TextStyle(fontSize: 15)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    onLongPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                    },
                    leading: Icon(Icons.password),
                    title:
                        Text("Change Password", style: TextStyle(fontSize: 20)),
                    subtitle: Text("Long Press Here To Change Password",
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ));
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.amber,
        context: ctx,
        builder: (ctx) => Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.white54,
              alignment: Alignment.center,
              child: const Text('Breathe in... Breathe out...'),
            ));
  }
}

// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../exports.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  BuildContext context;
  final String title;
  final String? urlImg;

  final GlobalKey<ScaffoldState> scaffoldKey;
  // void signOutUser(BuildContext context) {
  //   AuthService().signOutuser(context);
  // }
  var obj = HomePage();

  MyAppBar(
      {Key? key,
      required this.scaffoldKey,
      required this.title,
      required this.urlImg,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.closeDrawer();
            //close drawer, if drawer is open
          } else {
            scaffoldKey.currentState!.openDrawer();
            //open drawer, if drawer is closed
          }
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(1.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 3,
                    offset: Offset.zero,
                    color: Color.fromARGB(255, 14, 32, 223))
              ]),
          // child: CachedNetworkImage(imageUrl: "$urlImg"),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: CachedNetworkImageProvider("$urlImg"),
          ),
        ),
      ),
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.person,
      //     size: 40,
      //   ),
      //   onPressed: () {
      //     if (scaffoldKey.currentState!.isDrawerOpen) {
      //       scaffoldKey.currentState!.closeDrawer();
      //       //close drawer, if drawer is open
      //     } else {
      //       scaffoldKey.currentState!.openDrawer();
      //       //open drawer, if drawer is closed
      //     }
      //   },
      // ),
      backgroundColor: Color(0xff3a57e8),
      toolbarHeight: 100,
      shadowColor: Colors.pink.shade200,
      title: Text(title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      elevation: 9,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 7, spreadRadius: 3, color: Color(0xff3a57e8))
                ], shape: BoxShape.circle, color: Color(0xff3a57e8)),
                child: IconButton(
                  color: Color.fromARGB(255, 255, 255, 255),
                  // onPressed: () => obj.signOutUser(context),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Logout'),
                        content: Text('Confirm LogOut'),
                        actions: [
                          ElevatedButton(
                              onPressed: () => obj.signOutUser(context),
                              child: Text('Confirm')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Go Back'))
                        ],
                      ),
                    );
                  },

                  icon: Icon(
                    Icons.logout,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}

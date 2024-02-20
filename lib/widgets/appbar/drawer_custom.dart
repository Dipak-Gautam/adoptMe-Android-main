// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';

class DrawerWidget extends StatefulWidget {
  String? name, image, email;
  DrawerWidget(
      {super.key,
      required this.email,
      required this.name,
      required this.image});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UserProfile()));
            },
            child: UserAccountsDrawerHeader(
              accountName: Text("${widget.name}"),
              accountEmail: Text("${widget.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider("${widget.image}"),
                // backgroundImage:
                //     Image.network(widget.image as String) as ImageProvider,
                // backgroundImage: CachedNetworkImage(
                //   imageUrl: "${widget.image}",
                //   placeholder: (context, url) => CircularProgressIndicator(),
                //   errorWidget: (context, url, error) => Icon(Icons.error),
                // ) as ImageProvider,
              ),
              decoration: BoxDecoration(
                color: Color(0xff3a57e8),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "${widget.image}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.library_add),
            title: Text("Add Pet for Adoption"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EnterPetDetails()));
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text("My Listed Pets"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyListedPets()));
              // showAboutDialog(
              //     context: context, children: [Text("Git Pull left")]);
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("My Pets Booked"),
            onTap: () {
              Navigator.pop(context);
              // showAboutDialog(
              //     context: context, children: [Text("Git Pull left")]);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyPetsBookings()));
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text("My Bookings"),
            onTap: () {
              Navigator.pop(context);
              // showAboutDialog(
              //     context: context, children: [Text("Git Pull left")]);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyBookings()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text("My Profile"),
            onTap: () {
              Navigator.pop(context);
              // showAboutDialog(
              //     context: context, children: [Text("Git Pull left")]);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UserProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text("About Us"),
            onTap: () {
              Navigator.pop(context);
              // showAboutDialog(
              //     context: context, children: [Text("Git Pull left")]);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutUs()));
            },
          ),
        ],
      ),
    );

    // return Drawer(
    //   child: ListView(
    //     children: [
    //       DrawerHeader(
    //         child: Stack(
    //           children: [
    //             Positioned(
    //               bottom: 8.0,
    //               left: 4.0,
    //               child: Text(
    //                 "App Making.co",
    //                 style: TextStyle(color: Colors.white, fontSize: 20),
    //               ),
    //             )
    //           ],
    //         ),
    //         decoration: BoxDecoration(
    //           color: Colors.red,
    //           image: DecorationImage(
    //             image: NetworkImage(
    //               "https://appmaking.co/wp-content/uploads/2021/08/android-drawer-bg.jpeg",
    //             ),
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.home),
    //         title: Text("Home"),
    //         onTap: () {},
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.account_box),
    //         title: Text("About"),
    //         onTap: () {},
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.grid_3x3_outlined),
    //         title: Text("Products"),
    //         onTap: () {},
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.contact_mail),
    //         title: Text("Contact"),
    //         onTap: () {},
    //       )
    //     ],
    //   ),
    // );
  }
}

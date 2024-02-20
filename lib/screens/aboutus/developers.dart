// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Developers extends StatelessWidget {
  const Developers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Team'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          DeveloperListItem(
            name: 'Ashish Paudel',
            address: 'Hemja, Pokhara',
            imageUrl: "assets/dev/a.png",
            email: "ashishpaudel54@gmail.com",
          ),
          DeveloperListItem(
            name: 'Subash Poudel',
            address: 'Bindyabasini, Pokhara',
            imageUrl: "assets/dev/subash.png",
            email: "subashpoudel193@gmail.com",
          ),
          DeveloperListItem(
            name: 'Dipak Gautam',
            address: 'Amardeep, Pokhara',
            imageUrl: "assets/dev/boma.png",
            email: "anjangautam095@gmail.com ",
          ),
        ],
      ),
    );
  }
}

class DeveloperListItem extends StatelessWidget {
  final String name;
  final String address;
  final String imageUrl;
  final String email;

  const DeveloperListItem({
    Key? key,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          String sendemail = Uri.encodeComponent(email);
          Uri mail = Uri.parse("mailto:$sendemail");
          if (await launchUrl(mail)) {
          } else {}
        },
        child: Row(
          children: [
            Container(
              width: 130,
              height: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(48), // Image radius
                  child: Image.asset(imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                Text(
                  address,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Tap to contact",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

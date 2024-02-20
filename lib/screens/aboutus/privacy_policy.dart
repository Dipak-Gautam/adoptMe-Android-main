// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xff000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              padding: EdgeInsets.all(0),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0x00ffffff),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Color(0x4d9e9e9e), width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image(
                  image: AssetImage("assets/splash/loading_2.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: Text(
                "v1.0.0pre",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  color: Color(0xff7b7b7b),
                ),
              ),
            ),
            Text(
              "AdoptMe-Rehome a Pet",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 24,
                color: Color(0xff000000),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Text(
                "AdoptMe Nepal built the AdoptME - Rehome a Pet app as a Free app. This SERVICE is provided by AdoptMe Nepal at no cost and is intended for use as is.This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at AdoptME - Rehome a Pet unless otherwise defined in this Privacy Policy. Information Collection and Use: For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to User Image, Phone Number, Name, Location entered by user, Email. The information that we request will be retained by us and used as described in this privacy policy. The app does use third-party services that may collect information used to identify you. Security: We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.Links to Other Sites: This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services. Changes to This Privacy Policy: We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. This policy is effective as of 2023-04-01 Contact Us If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at adoptmenepal@gmail.com.",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  color: Color(0xff222020),
                ),
              ),
            ),
            TextButton(
                onPressed: () async {
                  String email = Uri.encodeComponent("adoptmenepal@gmail.com");
                  Uri mail = Uri.parse("mailto:$email");
                  if (await launchUrl(mail)) {
                  } else {}
                },
                child: Text("Mail Us Now"))
          ],
        ),
      ),
    );
  }
}

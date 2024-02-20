// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import '../../../exports.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordInit extends StatefulWidget {
  const ForgotPasswordInit({super.key});

  @override
  State<ForgotPasswordInit> createState() => _ForgotPasswordInitState();
}

class _ForgotPasswordInitState extends State<ForgotPasswordInit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //String? email;
  TextEditingController _emailController = TextEditingController();
  bool _isSyncing = false;

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  resetNow(email) async {
    try {
      Dio dio = Dio();
      Response rsp = await dio.post('${Constants.uri}/password/forgot-password',
          data: {"email": email});
      if (rsp.statusCode == 201) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Success"),
                  content: Text(rsp.data["msg"]),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.all(14),
                        child: const Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ));
        setState(() {
          _isSyncing = false;
        });
      }
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        case 500:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.response?.data["msg"]),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
          break;
        default:
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(14),
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3a57e8),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Color(0x00ffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: _isSyncing
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 50),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ///***If you have exported images you must have to copy those images in assets/images directory.
                            Image(
                              image: CachedNetworkImageProvider(
                                  "https://cdn4.iconfinder.com/data/icons/seo-and-marketing-icons-1-1/129/56-128.png"),
                              height: 100,
                              width: 140,
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                              child: Text(
                                "Forgot Your Password?",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 24,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            Text(
                              "Just enter the email address you've used to register with us and we will send you a reset link!",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xffd2d2d2),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  validator: validateEmail,
                                  controller: _emailController,
                                  obscureText: false,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                  decoration: InputDecoration(
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          color: Color(0x00ffffff), width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          color: Color(0x00ffffff), width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          color: Color(0x00ffffff), width: 1),
                                    ),
                                    hintText: "Type Your Email",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff525252),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xfff2f2f3),
                                    isDense: false,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        onPressed: () {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            setState(() {
                              _isSyncing = true;
                            });
                            resetNow(_emailController.text);
                          }
                        },
                        color: Color(0xffe96053),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0)),
                          side: BorderSide(color: Color(0xff808080), width: 1),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "SEND",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        textColor: Color(0xffffffff),
                        height: 50,
                        minWidth: 150,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../exports.dart';
import 'dart:convert';

class UserDetailsService {
  void addDetails({
    required BuildContext context,
    required String name,
    required String mobile,
    required String phone,
    required String address,
    required String email,
    required String image,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = prefs.getString('_uid');
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = "multipart/form-data";
    FormData formData = FormData.fromMap(<String, dynamic>{
      // "image": await MultipartFile.fromFile(_image?.path,
      //     filename: _image.path.split('/').last ?? 'image.jpeg'),
      "image": await MultipartFile.fromFile(image),
      "name": name,
      "mobile": mobile,
      "phone": phone,
      "uid": userID,
      "email": email,
      "address": address,
    });

    try {
      Response responseP = await dio
          .post("${Constants.uri}/user/addUserDetails", data: formData);
      // switch (responseP.statusCode) {
      //   case 201:
      _showMaterialDialog(
          context, "Success", "Login Once again for authenticity", () async {
        try {
          // final data = {'uid': userID};
          // Response response =
          //     await Dio().post("${Constants.uri}/user/details", data: data);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', responseP.data['name']);
          prefs.setString('phone', responseP.data['phone']);
          prefs.setString('mobile', responseP.data['mobile']);
          prefs.setString('address', responseP.data['address']);
          prefs.setString('imageUser', responseP.data['urli']);
        } on Exception catch (e) {
          _showMaterialDialog(context, "Error", e.toString(), () {
            _dismissDialog(context);
          });
        }
        //prefs.setString('_uid', responseP.data['_id']);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      });
      //     break;
      //   case 400:
      //     _showMaterialDialog(context, "Error", responseP.data['msg'], () {
      //       _dismissDialog(context);
      //     });
      //     break;
      //   case 500:
      //     _showMaterialDialog(context, "Error", responseP.data['msg'], () {
      //       _dismissDialog(context);
      //     });
      //     break;
      //   default:
      //     _showMaterialDialog(context, "Error", "some error occured", () {
      //       _dismissDialog(context);
      //     });
      // }
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
                              builder: (context) => RegisterScreen()));
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
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => RegisterScreen()));
                          Navigator.of(context).pop();
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
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => EnterUserDetails()));
                          Navigator.of(context).pop();
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
}

void _showMaterialDialog(
    BuildContext context, String title, String msg, VoidCallback onSuccess) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: onSuccess,
              child: Text('Close'),
            ),
          ],
        );
      });
}

_dismissDialog(BuildContext context) {
  Navigator.pop(context);
}

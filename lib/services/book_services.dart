// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../exports.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../exports.dart';
import 'package:flutter/services.dart';

class BookService {
  void bookPet({
    required BuildContext context,
    required String petID,
    required String date,
    required String time,
  }) async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('_uid');

    // FormData formData = FormData.fromMap(<String, dynamic>{
    //   "petID": petID,
    //   "userID": userID,
    //   "date": date,
    //   "time": time,
    // });
    try {
      Response responseP =
          await dio.post("${Constants.uri}/book/bookPets", data: {
        "userID": userID,
        "petID": petID,
        "date": date,
        "time": time,
      });
      // if (responseP.statusCode == 200) {
      // success
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Success"),
                content: Text(responseP.data["msg"]),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      //Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
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

      // check = responseR.statusCode;

      // _showDialog(
      //   context: context,
      //   response: responseP.data['msg'],
      //   title: 'Success',
      // );
      // } else {
      //   // handle error

      //   _showDialog(
      //     context: context,
      //     response: responseP.data['msg'],
      //     title: 'Error',
      //   );
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
                          Navigator.of(context).pop();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => RegisterScreen()));
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
                          Navigator.of(context).pop();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => RegisterScreen()));
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
                              builder: (context) => RegisterScreen()));
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

  Future<dynamic> _showDialog({
    required BuildContext context,
    required String? response,
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(response!.toString()),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ],
        );
      },
    );
  }
}

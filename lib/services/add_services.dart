// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../exports.dart';
import 'package:flutter/services.dart';

class AddService {
  void addPets({
    required BuildContext context,
    required String nickname,
    required String category,
    required String breed,
    required String age,
    required String weight,
    required String health,
    required String color,
    required String location,
    required String image,
    required String gender,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = prefs.getString('_uid');
    var playerId = prefs.getString('playerId');
    //  print(userID);

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = "multipart/form-data";
    FormData formData = FormData.fromMap(<String, dynamic>{
      // "image": await MultipartFile.fromFile(_image?.path,
      //     filename: _image.path.split('/').last ?? 'image.jpeg'),
      "image": await MultipartFile.fromFile(image),
      "nickname": nickname,
      "breed": breed,
      "category": category,
      "age": age,
      "weight": weight,
      "health": health,
      "color": color,
      "location": location,
      //"uid": "5f3d4b3c5d8e4f3d4b3c5d8e",
      "uid": userID,
      "gender": gender,
      "playerId": playerId
    });

    try {
      // print(image);

      Response responseP =
          await dio.post("${Constants.uri}/add/addP", data: formData);

      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Success"),
                content: Text(responseP.data["msg"]),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
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

      // if (responseP.statusCode == 201) {
      //   // success
      //   //print(image);
      //   // check = responseR.statusCode;
      //  // print("success");

      //   _showDialog(
      //     context: context,
      //     response: responseP.data['msg'],
      //     title: 'Success',
      //     routes: '/view',
      //   );
      // } else {
      //   // handle error
      //   print("failed");
      //   print(responseP.toString());
      //   _showDialog(
      //     context: context,
      //     response: responseP.data['msg'],
      //     title: 'Error',
      //     routes: '/add',
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EnterPetDetails()));
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
                              builder: (context) => EnterPetDetails()));
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
                              builder: (context) => EnterPetDetails()));
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

  // Future<dynamic> _showDialog(
  //     {required BuildContext context,
  //     required String? response,
  //     required String title,
  //     required String routes}) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(response!.toString()),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             child: Text("OK"),
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => HomePage(),
  //                 ),
  //               );
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
